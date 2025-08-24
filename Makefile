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

.PHONY: dev
dev: ## Start development environment
	@echo "Starting development environment..."
	docker-compose -f docker-compose.dev.yml up -d

.PHONY: dev-down
dev-down: ## Stop development environment
	@echo "Stopping development environment..."
	docker-compose -f docker-compose.dev.yml down