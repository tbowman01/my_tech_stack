# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an enterprise AI platform scaffold designed around modern cloud-native architecture. It's a comprehensive monorepo that implements a production-ready stack with Kubernetes, service mesh, AI/ML capabilities, and enterprise security patterns.

## Architecture & Technology Stack

### Core Infrastructure
- **Orchestration**: Kubernetes with Cilium CNI & service mesh, Envoy Gateway (Gateway API)
- **Security**: SPIRE (SPIFFE IDs), Vault + SOPS for secrets, Keycloak (OIDC), OPA/Gatekeeper policies
- **Data Layer**: PostgreSQL + Redis + ClickHouse + Qdrant (vectors) + OpenSearch + S3-compatible storage
- **Messaging**: NATS JetStream
- **Observability**: OpenTelemetry → Prometheus/Loki/Tempo/Grafana stack

### Application Services
- **Languages**: Rust (Axum/Tonic), TypeScript/Node.js (Fastify), Python (FastAPI)
- **Patterns**: Microservices, REST + gRPC, event-driven architecture
- **AI/ML**: MLflow, Feast, RAG implementation, vLLM/Ollama integration

### Development & Operations
- **IaC**: Terraform (cloud-agnostic), Helm charts, Kustomize overlays
- **CI/CD**: GitHub Actions, Argo Rollouts + Flagger (progressive delivery)
- **Documentation**: Docusaurus v2, Backstage IDP
- **Supply Chain Security**: Syft (SBOM), Trivy/Grype scanning, Cosign keyless signing

## Development Commands

### Core Make Targets
```bash
make init-dev          # Install git hooks, pre-commit, validate toolchain
make deps              # Install dependencies for all languages (JS/Go/Rust/Python)
make platform-apply    # Install/upgrade platform via Helm/Kustomize
make vault-bootstrap   # Configure Vault (PKI/Transit/KV, policies, roles)
make keycloak-bootstrap # Import Keycloak realm, clients, roles
make deploy-dev        # Build images, sign with Cosign, deploy with progressive rollout
make clean             # Remove build artifacts
make sbom              # Generate SBOMs with Syft
make scan              # Security scans with Trivy/Grype
make verify-admission  # Test OPA/Gatekeeper policies locally
```

### Language-Specific Commands
```bash
# Node.js services (apps/api-gateway/, apps/web/)
npm ci && npm test
npm run dev            # Development server with watch mode

# Rust services (services/users/, apps/stream-ingest/)
cargo test --all
cargo build --release

# Python AI services (apps/ai/inference/)
pip install -r requirements.txt
pytest
uvicorn main:app --reload
```

### Infrastructure Commands
```bash
# Terraform
cd infra/terraform/envs/dev && terraform init && terraform apply

# Helm operations
helm upgrade --install <service> infra/helm/charts/svc-template

# Container operations
docker build -t <service> .
cosign sign --yes <image>  # Keyless signing
```

## Repository Structure

The monorepo follows a domain-driven structure:

- `apps/` - User-facing applications (web UI, API gateway, BFF, AI services)
- `services/` - Business domain services (users, analytics)
- `libs/` - Shared libraries and contracts (OpenAPI + protobuf definitions)
- `infra/` - Infrastructure as Code (Terraform modules, Helm charts, Kustomize)
- `policies/` - Security policies (Gatekeeper, Conftest, Kyverno)
- `ops/` - Operational configurations (OpenTelemetry, NATS, Vault, Keycloak)
- `docs/` - Documentation site (Docusaurus)
- `backstage/` - Internal Developer Platform configuration

## Key Patterns & Conventions

### Service Architecture
- Each service follows the same structure: Dockerfile (multi-stage with Chainguard/Distroless), Helm chart deployment, OpenTelemetry integration
- All services expose `/healthz` endpoint and structured logging
- gRPC services use buf for schema management and code generation
- REST APIs follow OpenAPI 3.0 specifications in `libs/contracts/`

### Security Patterns
- Container images must be signed with Cosign (keyless OIDC)
- Secrets managed through Vault + External Secrets Operator
- mTLS enforced via SPIRE/SPIFFE identities
- Network policies enforce L7 rules via Cilium
- All deployments verified by Gatekeeper admission controllers

### Observability
- All services instrument with OpenTelemetry (traces, metrics, logs)
- Structured logging with correlation IDs
- Prometheus metrics with SLO/SLI definitions
- Grafana dashboards for service health and business metrics

### Data & ML Patterns
- Event sourcing via Debezium CDC → ClickHouse
- Feature store managed by Feast
- ML experiments tracked in MLflow
- Vector similarity search via Qdrant
- RAG pipelines with safety guardrails

## Development Workflow

1. **Setup**: Run `make init-dev` to configure pre-commit hooks and toolchain validation
2. **Infrastructure**: Deploy platform with `make platform-apply` after Terraform provisioning
3. **Services**: Use the Helm service template in `infra/helm/charts/svc-template/` for new services
4. **Testing**: All services follow London-style TDD with contract testing between services
5. **Deployment**: Progressive rollouts via Argo Rollouts with automatic rollback on failure
6. **Security**: Automated SBOM generation, vulnerability scanning, and policy enforcement

## CI/CD Pipeline

The GitHub Actions workflow (`ci.yaml`) implements:
- Multi-language matrix builds (Node.js, Go, Rust, Python)
- Comprehensive security scanning (Trivy, Gitleaks, Grype)
- Multi-arch container builds with BuildKit
- Keyless image signing with Cosign + SLSA attestations
- Progressive deployment to dev environment on main branch

## Prerequisites

**Required Tools**: Docker, make, direnv, kubectl, helm, terraform, cosign, sops, age, buf, protoc, node LTS, go 1.22+, rust stable, python 3.11+

**Optional**: Pre-commit for local validation, Tilt for local development orchestration

## Bootstrap Sequence

The platform must be deployed in a specific order due to dependencies:
1. Terraform (networking, compute, storage)
2. Cilium (CNI + service mesh) → Envoy Gateway
3. cert-manager → SPIRE (identity)
4. External Secrets ↔ Vault (secrets management)
5. Keycloak (authentication) → Data layer (Postgres, Redis, etc.)
6. Observability stack → Application services

Use `make platform-apply` which orchestrates this sequence via helmfile/kustomize wrappers.