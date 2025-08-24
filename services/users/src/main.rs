use axum::{
    extract::Query,
    http::StatusCode,
    response::Json,
    routing::{get, post},
    Router,
};
use serde::{Deserialize, Serialize};
use std::{net::SocketAddr, time::Duration};
use tower_http::{cors::CorsLayer, trace::TraceLayer};
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};
use uuid::Uuid;

#[derive(Debug, Serialize, Deserialize)]
struct User {
    id: Uuid,
    name: String,
    email: String,
    created_at: chrono::DateTime<chrono::Utc>,
}

#[derive(Debug, Deserialize)]
struct CreateUserRequest {
    name: String,
    email: String,
}

#[derive(Debug, Deserialize)]
struct ListUsersQuery {
    limit: Option<i32>,
    offset: Option<i32>,
}

#[derive(Debug, Serialize)]
struct HealthResponse {
    status: String,
    timestamp: chrono::DateTime<chrono::Utc>,
    service: String,
    version: String,
}

#[derive(Debug, Serialize)]
struct ListUsersResponse {
    users: Vec<User>,
    total: i32,
    limit: i32,
    offset: i32,
}

async fn health_check() -> Result<Json<HealthResponse>, StatusCode> {
    Ok(Json(HealthResponse {
        status: "ok".to_string(),
        timestamp: chrono::Utc::now(),
        service: "users".to_string(),
        version: env!("CARGO_PKG_VERSION").to_string(),
    }))
}

async fn list_users(Query(params): Query<ListUsersQuery>) -> Result<Json<ListUsersResponse>, StatusCode> {
    let limit = params.limit.unwrap_or(10).max(1).min(100);
    let offset = params.offset.unwrap_or(0).max(0);

    // Mock data - in real implementation, this would query the database
    let mock_users = vec![
        User {
            id: Uuid::new_v4(),
            name: "Alice Johnson".to_string(),
            email: "alice@example.com".to_string(),
            created_at: chrono::Utc::now() - chrono::Duration::days(30),
        },
        User {
            id: Uuid::new_v4(),
            name: "Bob Smith".to_string(),
            email: "bob@example.com".to_string(),
            created_at: chrono::Utc::now() - chrono::Duration::days(15),
        },
    ];

    Ok(Json(ListUsersResponse {
        users: mock_users,
        total: 2,
        limit,
        offset,
    }))
}

async fn create_user(Json(payload): Json<CreateUserRequest>) -> Result<Json<User>, StatusCode> {
    // Validate input
    if payload.name.is_empty() || payload.email.is_empty() {
        return Err(StatusCode::BAD_REQUEST);
    }

    // Mock user creation - in real implementation, this would insert into database
    let user = User {
        id: Uuid::new_v4(),
        name: payload.name,
        email: payload.email,
        created_at: chrono::Utc::now(),
    };

    tracing::info!("Created user: {:?}", user);
    Ok(Json(user))
}

fn init_tracing() {
    let otlp_endpoint = std::env::var("OTEL_EXPORTER_OTLP_ENDPOINT")
        .unwrap_or_else(|_| "http://otel-collector:4317".to_string());
    
    let service_name = std::env::var("OTEL_SERVICE_NAME")
        .unwrap_or_else(|_| "users".to_string());

    // Initialize OpenTelemetry
    let tracer = opentelemetry_otlp::new_pipeline()
        .tracing()
        .with_exporter(
            opentelemetry_otlp::new_exporter()
                .tonic()
                .with_endpoint(otlp_endpoint),
        )
        .with_service_name(service_name)
        .with_service_version(env!("CARGO_PKG_VERSION"))
        .install_batch(opentelemetry_sdk::runtime::Tokio)
        .expect("Failed to initialize OpenTelemetry tracer");

    // Create tracing subscriber
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| "users=debug,tower_http=debug".into()),
        )
        .with(tracing_subscriber::fmt::layer().json())
        .with(tracing_opentelemetry::layer().with_tracer(tracer))
        .init();
}

#[tokio::main]
async fn main() {
    // Initialize tracing
    init_tracing();

    // Build application router
    let app = Router::new()
        .route("/healthz", get(health_check))
        .route("/readyz", get(health_check))
        .route("/users", get(list_users).post(create_user))
        .layer(TraceLayer::new_for_http())
        .layer(CorsLayer::permissive());

    // Start server
    let addr = SocketAddr::from(([0, 0, 0, 0], 8080));
    tracing::info!("Users service listening on {}", addr);

    let listener = tokio::net::TcpListener::bind(addr)
        .await
        .expect("Failed to bind to address");

    axum::serve(listener, app)
        .with_graceful_shutdown(shutdown_signal())
        .await
        .expect("Server failed to start");
}

async fn shutdown_signal() {
    let ctrl_c = async {
        tokio::signal::ctrl_c()
            .await
            .expect("failed to install Ctrl+C handler");
    };

    #[cfg(unix)]
    let terminate = async {
        tokio::signal::unix::signal(tokio::signal::unix::SignalKind::terminate())
            .expect("failed to install signal handler")
            .recv()
            .await;
    };

    #[cfg(not(unix))]
    let terminate = std::future::pending::<()>();

    tokio::select! {
        _ = ctrl_c => {
            tracing::info!("Received Ctrl+C, shutting down gracefully");
        },
        _ = terminate => {
            tracing::info!("Received SIGTERM, shutting down gracefully");
        },
    }

    // Shutdown OpenTelemetry
    opentelemetry::global::shutdown_tracer_provider();
}