import os
import time
from datetime import datetime
from typing import Dict, Any, Optional

import structlog
from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field
from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

# Configure structured logging
structlog.configure(
    processors=[
        structlog.stdlib.filter_by_level,
        structlog.stdlib.add_logger_name,
        structlog.stdlib.add_log_level,
        structlog.stdlib.PositionalArgumentsFormatter(),
        structlog.processors.TimeStamper(fmt="iso"),
        structlog.processors.StackInfoRenderer(),
        structlog.processors.format_exc_info,
        structlog.processors.UnicodeDecoder(),
        structlog.processors.JSONRenderer()
    ],
    context_class=dict,
    logger_factory=structlog.stdlib.LoggerFactory(),
    wrapper_class=structlog.stdlib.BoundLogger,
    cache_logger_on_first_use=True,
)

logger = structlog.get_logger()

# Initialize OpenTelemetry
def init_tracing():
    otlp_endpoint = os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT", "http://otel-collector:4317")
    service_name = os.getenv("OTEL_SERVICE_NAME", "ai-inference")
    service_version = os.getenv("OTEL_SERVICE_VERSION", "0.1.0")
    
    # Create tracer provider
    trace.set_tracer_provider(TracerProvider())
    tracer = trace.get_tracer(__name__)
    
    # Create OTLP exporter
    otlp_exporter = OTLPSpanExporter(endpoint=otlp_endpoint)
    span_processor = BatchSpanProcessor(otlp_exporter)
    trace.get_tracer_provider().add_span_processor(span_processor)
    
    return tracer

tracer = init_tracing()

# Prometheus metrics
REQUEST_COUNT = Counter('ai_inference_requests_total', 'Total inference requests', ['method', 'endpoint'])
REQUEST_DURATION = Histogram('ai_inference_request_duration_seconds', 'Request duration')
INFERENCE_COUNT = Counter('ai_inference_predictions_total', 'Total predictions made', ['model'])

# Pydantic models
class HealthResponse(BaseModel):
    status: str = "ok"
    timestamp: datetime
    service: str = "ai-inference"
    version: str = "0.1.0"

class InferenceRequest(BaseModel):
    prompt: str = Field(..., min_length=1, max_length=10000)
    model: Optional[str] = Field(default="default", description="Model to use for inference")
    max_tokens: Optional[int] = Field(default=100, ge=1, le=2048)
    temperature: Optional[float] = Field(default=0.7, ge=0.0, le=2.0)
    
class InferenceResponse(BaseModel):
    response: str
    model: str
    tokens_used: int
    inference_time_ms: float
    request_id: str

class EmbeddingRequest(BaseModel):
    text: str = Field(..., min_length=1, max_length=10000)
    model: Optional[str] = Field(default="default", description="Embedding model to use")

class EmbeddingResponse(BaseModel):
    embedding: list[float]
    model: str
    dimension: int
    request_id: str

# Create FastAPI app
app = FastAPI(
    title="AI Inference Service",
    description="Enterprise AI Platform - Inference Service",
    version="0.1.0",
    docs_url="/docs",
    redoc_url="/redoc",
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure appropriately for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Instrument FastAPI with OpenTelemetry
FastAPIInstrumentor.instrument_app(app)
RequestsInstrumentor().instrument()

@app.middleware("http")
async def logging_middleware(request: Request, call_next):
    start_time = time.time()
    
    # Log request
    logger.info(
        "Request started",
        method=request.method,
        url=str(request.url),
        client_ip=request.client.host if request.client else None
    )
    
    # Process request
    response = await call_next(request)
    
    # Calculate duration
    duration = time.time() - start_time
    
    # Update metrics
    REQUEST_COUNT.labels(method=request.method, endpoint=request.url.path).inc()
    REQUEST_DURATION.observe(duration)
    
    # Log response
    logger.info(
        "Request completed",
        method=request.method,
        url=str(request.url),
        status_code=response.status_code,
        duration_seconds=duration
    )
    
    return response

@app.get("/healthz", response_model=HealthResponse)
async def health_check():
    """Health check endpoint for Kubernetes liveness probe"""
    return HealthResponse(timestamp=datetime.utcnow())

@app.get("/readyz", response_model=HealthResponse) 
async def readiness_check():
    """Readiness check endpoint for Kubernetes readiness probe"""
    # In production, check model availability, database connections, etc.
    return HealthResponse(timestamp=datetime.utcnow())

@app.get("/metrics")
async def metrics():
    """Prometheus metrics endpoint"""
    return JSONResponse(
        content=generate_latest().decode('utf-8'),
        media_type=CONTENT_TYPE_LATEST
    )

@app.post("/infer", response_model=InferenceResponse)
async def infer(request: InferenceRequest):
    """Generate text inference using AI models"""
    with tracer.start_as_current_span("ai_inference") as span:
        start_time = time.time()
        request_id = f"req_{int(start_time * 1000000)}"
        
        span.set_attributes({
            "ai.model": request.model,
            "ai.prompt_length": len(request.prompt),
            "ai.max_tokens": request.max_tokens,
            "ai.temperature": request.temperature,
            "request.id": request_id
        })
        
        logger.info(
            "Starting inference",
            request_id=request_id,
            model=request.model,
            prompt_length=len(request.prompt)
        )
        
        try:
            # Mock inference - in production, integrate with vLLM/Ollama/OpenAI API
            inference_start = time.time()
            
            # Simulate processing time
            import asyncio
            await asyncio.sleep(0.1)  # Remove in production
            
            # Mock response generation
            mock_response = f"This is a mock response to: '{request.prompt[:50]}...'"
            mock_tokens = len(mock_response.split())
            
            inference_time = (time.time() - inference_start) * 1000
            
            # Update metrics
            INFERENCE_COUNT.labels(model=request.model).inc()
            
            logger.info(
                "Inference completed",
                request_id=request_id,
                model=request.model,
                tokens_generated=mock_tokens,
                inference_time_ms=inference_time
            )
            
            return InferenceResponse(
                response=mock_response,
                model=request.model,
                tokens_used=mock_tokens,
                inference_time_ms=inference_time,
                request_id=request_id
            )
            
        except Exception as e:
            logger.error(
                "Inference failed",
                request_id=request_id,
                error=str(e),
                exc_info=True
            )
            raise HTTPException(status_code=500, detail=f"Inference failed: {str(e)}")

@app.post("/embed", response_model=EmbeddingResponse)
async def embed(request: EmbeddingRequest):
    """Generate embeddings for text"""
    with tracer.start_as_current_span("ai_embedding") as span:
        start_time = time.time()
        request_id = f"emb_{int(start_time * 1000000)}"
        
        span.set_attributes({
            "ai.model": request.model,
            "ai.text_length": len(request.text),
            "request.id": request_id
        })
        
        logger.info(
            "Starting embedding generation",
            request_id=request_id,
            model=request.model,
            text_length=len(request.text)
        )
        
        try:
            # Mock embedding generation - in production, integrate with embedding models
            import random
            mock_embedding = [random.uniform(-1, 1) for _ in range(384)]  # Mock 384-dim embedding
            
            logger.info(
                "Embedding completed",
                request_id=request_id,
                model=request.model,
                dimension=len(mock_embedding)
            )
            
            return EmbeddingResponse(
                embedding=mock_embedding,
                model=request.model,
                dimension=len(mock_embedding),
                request_id=request_id
            )
            
        except Exception as e:
            logger.error(
                "Embedding failed",
                request_id=request_id,
                error=str(e),
                exc_info=True
            )
            raise HTTPException(status_code=500, detail=f"Embedding failed: {str(e)}")

@app.get("/")
async def root():
    """Root endpoint with service information"""
    return {
        "service": "ai-inference",
        "version": "0.1.0",
        "description": "Enterprise AI Platform - Inference Service",
        "endpoints": {
            "inference": "/infer",
            "embedding": "/embed",
            "health": "/healthz",
            "readiness": "/readyz",
            "metrics": "/metrics",
            "docs": "/docs"
        }
    }

if __name__ == "__main__":
    import uvicorn
    
    port = int(os.getenv("PORT", "8080"))
    host = os.getenv("HOST", "0.0.0.0")
    
    logger.info(
        "Starting AI Inference Service",
        host=host,
        port=port,
        service="ai-inference",
        version="0.1.0"
    )
    
    uvicorn.run(
        "main:app",
        host=host,
        port=port,
        reload=False,
        log_config=None,  # We handle logging with structlog
    )