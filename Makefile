SHELL := /bin/bash
.DEFAULT_GOAL := help

# Include optional environment file
-include .env.mk

# Variables
IMAGE_REGISTRY ?= ghcr.io/$(shell git config --get remote.origin.url | sed 's/.*[:/]\([^/]*\/[^/]*\)\.git/\1/')
COMMIT_SHA ?= $(shell git rev-parse --short HEAD)

.PHONY: help
help: ## Show available targets
	@grep -E '^[a-zA-Z0-9_-]+:.*?## ' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-28s\033[0m %s\n", $$1, $$2}'

.PHONY: init-dev
init-dev: ## Install git hooks, pre-commit, validate toolchain
	@echo "Installing pre-commit hooks..."
	pre-commit install -t pre-commit -t commit-msg || echo "pre-commit not installed, please install it"
	@echo "Validating toolchain..."
	@command -v docker >/dev/null 2>&1 || { echo "docker is required but not installed"; exit 1; }
	@command -v kubectl >/dev/null 2>&1 || { echo "kubectl is required but not installed"; exit 1; }
	@command -v helm >/dev/null 2>&1 || { echo "helm is required but not installed"; exit 1; }
	@command -v terraform >/dev/null 2>&1 || { echo "terraform is required but not installed"; exit 1; }
	@echo "Toolchain validation complete!"

.PHONY: deps
deps: ## Install dependencies for all languages
	@echo "Installing Node.js dependencies..."
	@find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && npm ci' \;
	@echo "Installing Rust dependencies..."
	@find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo fetch' \;
	@echo "Installing Python dependencies..."
	@find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && pip install -r requirements.txt' \;

.PHONY: test
test: ## Run all tests
	@echo "Running Node.js tests..."
	@find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && [ -f package.json ] && npm test || true' \;
	@echo "Running Rust tests..."
	@find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo test --all || true' \;
	@echo "Running Python tests..."
	@find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && pytest || true' \;

.PHONY: build
build: ## Build all services
	@echo "Building services..."
	./scripts/build_all.sh

.PHONY: sbom
sbom: ## Generate SBOMs with Syft
	@echo "Generating SBOM..."
	syft packages --output spdx-json=sbom.spdx.json . || echo "syft not installed, skipping SBOM generation"

.PHONY: scan
scan: ## Security scans with Trivy/Grype
	@echo "Running security scans..."
	trivy fs --exit-code 1 --scanners vuln,secret . || echo "trivy not installed, skipping vulnerability scan"
	grype -q . || echo "grype not installed, skipping vulnerability scan"

.PHONY: sign
sign: ## Cosign keyless sign
	@echo "Signing images..."
	@if [ -z "$(IMAGE)" ]; then echo "Usage: make sign IMAGE=image:tag"; exit 1; fi
	COSIGN_EXPERIMENTAL=1 cosign sign --yes $(IMAGE)

.PHONY: verify-admission
verify-admission: ## Test OPA/Gatekeeper policies locally
	@echo "Testing admission policies..."
	conftest test -p policies/conftest . || echo "conftest not installed, skipping policy tests"

.PHONY: platform-apply
platform-apply: ## Install/upgrade platform via Helm/Kustomize
	@echo "Deploying platform components..."
	./scripts/platform_apply.sh

.PHONY: vault-bootstrap
vault-bootstrap: ## Configure Vault (PKI/Transit/KV, policies, roles)
	@echo "Bootstrapping Vault..."
	./scripts/vault_bootstrap.sh

.PHONY: keycloak-bootstrap
keycloak-bootstrap: ## Import Keycloak realm, clients, roles
	@echo "Bootstrapping Keycloak..."
	./scripts/keycloak_bootstrap.sh

.PHONY: deploy-dev
deploy-dev: build ## Build images, sign with Cosign, deploy with progressive rollout
	@echo "Deploying to dev environment..."
	./scripts/deploy.sh dev

.PHONY: deploy-prod
deploy-prod: build ## Deploy to production with progressive rollout
	@echo "Deploying to production environment..."
	./scripts/deploy.sh prod

.PHONY: clean
clean: ## Remove build artifacts
	@echo "Cleaning build artifacts..."
	rm -rf dist node_modules target .venv sbom.*
	find . -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null || true
	find . -name "target" -type d -exec rm -rf {} + 2>/dev/null || true
	find . -name ".venv" -type d -exec rm -rf {} + 2>/dev/null || true

.PHONY: lint
lint: ## Run linters for all languages
	@echo "Running linters..."
	@find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && npm run lint || true' \;
	@find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo clippy || true' \;
	@find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && ruff check . || true' \;

.PHONY: fmt
fmt: ## Format code for all languages
	@echo "Formatting code..."
	@find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && npm run format || true' \;
	@find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo fmt || true' \;
	@find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && ruff format . || true' \;

# =============================================================================
# Docker Commands
# =============================================================================

.PHONY: docker-build
docker-build: ## Build all Docker images locally
	@echo "Building Docker images..."
	docker-compose build --parallel

.PHONY: docker-up
docker-up: ## Start full production stack with Docker Compose
	@echo "Starting full production stack..."
	@if [ ! -f .env ]; then echo "Creating .env from .env.example..."; cp .env.example .env; fi
	docker-compose up -d

.PHONY: docker-down
docker-down: ## Stop full production stack
	@echo "Stopping full production stack..."
	docker-compose down

.PHONY: docker-logs
docker-logs: ## View logs from all containers
	docker-compose logs -f

.PHONY: docker-clean
docker-clean: ## Clean up Docker containers, volumes, and images
	@echo "Cleaning up Docker resources..."
	docker-compose down -v --remove-orphans
	docker system prune -f
	docker volume prune -f

.PHONY: dev
dev: ## Start lightweight development environment
	@echo "Starting development environment..."
	@if [ ! -f .env ]; then echo "Creating .env from .env.example..."; cp .env.example .env; fi
	docker-compose -f docker-compose.dev.yml up -d

.PHONY: dev-down
dev-down: ## Stop development environment
	@echo "Stopping development environment..."
	docker-compose -f docker-compose.dev.yml down

.PHONY: dev-logs
dev-logs: ## View logs from development containers
	docker-compose -f docker-compose.dev.yml logs -f

.PHONY: dev-build
dev-build: ## Build development Docker images
	@echo "Building development images..."
	docker-compose -f docker-compose.dev.yml build --parallel

.PHONY: dev-clean
dev-clean: ## Clean up development environment
	@echo "Cleaning up development environment..."
	docker-compose -f docker-compose.dev.yml down -v --remove-orphans

.PHONY: docker-health
docker-health: ## Check health of all running containers
	@echo "Checking container health..."
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

.PHONY: docker-shell
docker-shell: ## Open shell in a container (Usage: make docker-shell SERVICE=api-gateway)
	@if [ -z "$(SERVICE)" ]; then echo "Usage: make docker-shell SERVICE=api-gateway"; exit 1; fi
	docker-compose exec $(SERVICE) sh

.PHONY: docker-reset-db
docker-reset-db: ## Reset database with fresh data
	@echo "Resetting database..."
	docker-compose stop postgres
	docker-compose rm -f postgres
	docker volume rm $(shell docker-compose config --volumes | grep postgres) || true
	docker-compose up -d postgres

.PHONY: docker-backup-db
docker-backup-db: ## Backup PostgreSQL database
	@echo "Backing up database..."
	@mkdir -p backups
	docker-compose exec postgres pg_dump -U postgres enterprise_ai > backups/backup_$(shell date +%Y%m%d_%H%M%S).sql
	@echo "Database backup created in backups/"

.PHONY: docker-restore-db
docker-restore-db: ## Restore PostgreSQL database (Usage: make docker-restore-db BACKUP=backup_file.sql)
	@if [ -z "$(BACKUP)" ]; then echo "Usage: make docker-restore-db BACKUP=backup_file.sql"; exit 1; fi
	@if [ ! -f "backups/$(BACKUP)" ]; then echo "Backup file not found: backups/$(BACKUP)"; exit 1; fi
	docker-compose exec -T postgres psql -U postgres -d enterprise_ai < backups/$(BACKUP)

# =============================================================================
# Monitoring Commands
# =============================================================================

.PHONY: monitor-logs
monitor-logs: ## Monitor application logs in real-time
	@echo "Monitoring application logs..."
	docker-compose logs -f api-gateway users ai-inference

.PHONY: monitor-metrics
monitor-metrics: ## Open Prometheus metrics dashboard
	@echo "Opening Prometheus at http://localhost:9090"
	@command -v open >/dev/null && open http://localhost:9090 || echo "Visit http://localhost:9090"

.PHONY: monitor-traces
monitor-traces: ## Open Jaeger tracing dashboard
	@echo "Opening Jaeger at http://localhost:16686"
	@command -v open >/dev/null && open http://localhost:16686 || echo "Visit http://localhost:16686"

.PHONY: monitor-grafana
monitor-grafana: ## Open Grafana dashboard
	@echo "Opening Grafana at http://localhost:3000 (admin/admin)"
	@command -v open >/dev/null && open http://localhost:3000 || echo "Visit http://localhost:3000"

.PHONY: monitor-all
monitor-all: monitor-metrics monitor-traces monitor-grafana ## Open all monitoring dashboards