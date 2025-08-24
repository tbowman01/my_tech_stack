# Enterprise AI Platform

A reference implementation for a secure, AI-driven, cloud-agnostic platform.

## 🚀 Quick Start Options

### Option 1: Docker Development (Recommended for Getting Started)

The fastest way to get the platform running locally:

```bash
# Clone and setup
git clone https://github.com/your-org/enterprise-ai-platform
cd enterprise-ai-platform
make init-dev

# Start lightweight development environment
make dev

# Access services:
# - API Gateway: http://localhost:8080
# - Users Service: http://localhost:8081  
# - AI Inference: http://localhost:8082
# - Jaeger Tracing: http://localhost:16686
```

### Option 2: Full Production Stack (Docker)

For complete infrastructure with monitoring:

```bash
# Start full stack with all services
make docker-up

# Access dashboards:
# - API Gateway: http://localhost:8080
# - Prometheus: http://localhost:9090
# - Grafana: http://localhost:3000 (admin/admin)
# - Jaeger: http://localhost:16686
```

### Option 3: Kubernetes Production Deployment

```bash
# Install prerequisites (Docker, make, terraform, helm, kubectl, cosign, sops, age)
make init-dev && make deps

# Deploy infrastructure
cd infra/terraform/envs/dev && terraform init && terraform apply

# Deploy platform
make platform-apply && make vault-bootstrap && make keycloak-bootstrap

# Deploy services  
make deploy-dev
```

## 🏗️ Architecture

### Modern Cloud-Native Stack
- **Container Orchestration**: Kubernetes with Cilium service mesh
- **API Gateway**: Envoy Gateway with advanced routing and security
- **Security**: SPIFFE/SPIRE identities, Vault secrets, OPA policies
- **Observability**: OpenTelemetry → Prometheus/Loki/Tempo + Grafana
- **AI/ML**: Inference services, vector search, MLOps pipelines

### Services
- **API Gateway** (Node.js/Fastify) - Request routing and authentication
- **Users Service** (Rust/Axum) - User management with gRPC
- **AI Inference** (Python/FastAPI) - Text generation and embeddings
- **Full Infrastructure** - PostgreSQL, Redis, ClickHouse, Qdrant, OpenSearch

## 📋 Development Commands

```bash
# Development Environment (Hot Reload)
make dev              # Start lightweight dev stack
make dev-logs         # View development logs
make dev-clean        # Clean up dev environment

# Full Production Stack
make docker-up        # Start complete infrastructure  
make docker-health    # Check container status
make docker-clean     # Clean up all resources

# Monitoring & Debugging
make monitor-all      # Open all dashboards
make docker-shell SERVICE=api-gateway # Debug container
make docker-backup-db # Backup database

# Code Quality
make test            # Run all tests
make lint            # Run linters
make scan            # Security scans
```

## 🔒 Security Features

- **Distroless/Chainguard images** - Minimal attack surface
- **SBOM generation** - Supply chain transparency
- **Trivy/Grype scanning** - Vulnerability detection  
- **Cosign signing** - Keyless container signing
- **OPA/Gatekeeper** - Policy enforcement
- **Vault + SOPS** - Secret management
- **SPIFFE IDs** - Service identity and mTLS
- **Cilium L7 policies** - Network security

## 🤖 AI Capabilities

- **Inference Service** - Text generation and completion
- **Embedding Service** - Vector representations for semantic search
- **Vector Database** - Qdrant for similarity search
- **MLOps Ready** - MLflow experiments, Feast features
- **Safety Guardrails** - Content filtering and rate limiting

## 📊 Observability

- **Distributed Tracing** - OpenTelemetry → Jaeger/Tempo
- **Metrics Collection** - Prometheus + custom dashboards  
- **Structured Logging** - JSON logs → Loki aggregation
- **Health Monitoring** - Kubernetes probes + alerting
- **Performance Profiling** - Continuous profiling support

## 🗂️ Repository Structure

```
├── apps/                    # User-facing applications
│   ├── api-gateway/        # Main API gateway (Node.js)
│   ├── ai/inference/       # AI inference service (Python)
│   └── web/                # Web interface (Next.js)
├── services/               # Business services  
│   └── users/              # User management (Rust)
├── infra/                  # Infrastructure as Code
│   ├── terraform/          # Cloud infrastructure
│   ├── helm/               # Kubernetes deployments
│   └── kustomize/          # Environment overlays
├── libs/contracts/         # API contracts (OpenAPI + gRPC)
├── policies/               # Security policies (OPA/Gatekeeper)
├── ops/                    # Operational configurations
├── docs/                   # Documentation (Docusaurus)
└── scripts/                # Automation scripts
```

## 🚢 Deployment Options

### Local Development
- **Docker Compose** - Full stack in containers
- **Hot Reload** - Real-time code changes  
- **Integrated Debugging** - Container shell access
- **Sample Data** - Pre-populated databases

### Cloud Production
- **Multi-cloud** - AWS/GCP/Azure via Terraform
- **Auto-scaling** - HPA and cluster scaling
- **Progressive Deployment** - Argo Rollouts + Flagger
- **Disaster Recovery** - Multi-region setup

## 📚 Documentation & IDP

- **Documentation Site** - Docusaurus at `/docs`
- **API Documentation** - OpenAPI specs with examples
- **Backstage Catalog** - Service discovery and metadata
- **Architecture Decision Records** - Design decisions
- **Runbooks** - Operational procedures

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Make changes and test (`make test lint scan`)
4. Commit changes (`git commit -m 'Add amazing feature'`)
5. Push to branch (`git push origin feature/amazing-feature`)
6. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.