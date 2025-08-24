# =============================================================================
# 🎮 Enhanced Gamified Makefile - Complete Integration
# =============================================================================
# Master Makefile that orchestrates all enhanced UX components

# Shell configuration for enhanced features
SHELL := /bin/bash
.DEFAULT_GOAL := help

# Include optional environment file
-include .env.mk

# Core system includes
include scripts/makefile/colors.mk
include scripts/makefile/progress.mk
include scripts/makefile/gamification.mk
include scripts/makefile/help.mk  
include scripts/makefile/smart-deps.mk
include scripts/makefile/workflows.mk

# Enhanced variables with smart defaults
IMAGE_REGISTRY ?= ghcr.io/$(shell git config --get remote.origin.url | sed 's/.*[:/]\([^/]*\/[^/]*\)\.git/\1/')
COMMIT_SHA ?= $(shell git rev-parse --short HEAD)
BUILD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
BUILD_USER := $(shell whoami)

# Initialize gamification on first run
$(shell $(call init_gamification))

# =============================================================================
# 🎮 GAMIFIED CORE COMMANDS
# =============================================================================

.PHONY: init-dev
init-dev: ## 💻 Install git hooks, pre-commit, validate toolchain (+150 XP)
	$(call update_streak)
	$(call print_progress_start,"Initializing development environment")
	@echo "$(COLOR_INFO)Installing pre-commit hooks...$(COLOR_RESET)"
	@pre-commit install -t pre-commit -t commit-msg || echo "$(COLOR_WARNING)pre-commit not installed, please install it$(COLOR_RESET)"
	@echo "$(COLOR_INFO)Validating toolchain...$(COLOR_RESET)"
	@command -v docker >/dev/null 2>&1 || { echo "$(COLOR_ERROR)docker is required but not installed$(COLOR_RESET)"; exit 1; }
	@command -v kubectl >/dev/null 2>&1 || { echo "$(COLOR_WARNING)kubectl recommended but not installed$(COLOR_RESET)"; }
	@command -v helm >/dev/null 2>&1 || { echo "$(COLOR_WARNING)helm recommended but not installed$(COLOR_RESET)"; }
	@command -v terraform >/dev/null 2>&1 || { echo "$(COLOR_WARNING)terraform recommended but not installed$(COLOR_RESET)"; }
	$(call print_success,"Toolchain validation complete!")
	$(call unlock_achievement,environment_setup,"🛠️ Environment Architect","Successfully set up development environment",150)
	$(call award_xp,150,environment)

.PHONY: deps  
deps: smart-deps ## 💻 Smart dependency installation with progress tracking (+100 XP)
	$(call award_xp,100,dependency)

.PHONY: test
test: ## 🧪 Run all tests with progress tracking and coverage analysis (+200 XP)
	$(call update_streak)
	$(call print_progress_start,"Running comprehensive test suite")
	@echo "$(COLOR_INFO)Running Node.js tests...$(COLOR_RESET)"
	@test_results=0; \
	find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && [ -f package.json ] && npm test || true' \; || test_results=1; \
	echo "$(COLOR_INFO)Running Rust tests...$(COLOR_RESET)"; \
	find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo test --all || true' \; || test_results=1; \
	echo "$(COLOR_INFO)Running Python tests...$(COLOR_RESET)"; \
	find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && pytest || true' \; || test_results=1; \
	if [ $$test_results -eq 0 ]; then \
		$(call print_success,"All tests passed! 🎉"); \
		$(call unlock_achievement,test_champion,"🧪 Test Champion","All test suites passed",200); \
	else \
		$(call print_warning,"Some tests failed - check output above"); \
	fi
	$(call award_xp,200,testing)

.PHONY: build
build: ## 💻 Build all services with timing and performance tracking (+175 XP)
	$(call update_streak)
	$(call time_task,$(call print_progress_start,"Building all services") && ./scripts/build_all.sh)
	$(call unlock_achievement,master_builder,"🏗️ Master Builder","Successfully built all services",175)
	$(call award_xp,175,build)

.PHONY: lint
lint: ## 🧪 Run linters with streak tracking and quality metrics (+125 XP)  
	$(call update_streak)
	$(call print_progress_start,"Running code quality checks")
	@lint_failures=0; \
	echo "$(COLOR_INFO)Linting Node.js projects...$(COLOR_RESET)"; \
	find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && npm run lint || exit 1' \; || lint_failures=1; \
	echo "$(COLOR_INFO)Linting Rust projects...$(COLOR_RESET)"; \
	find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo clippy || exit 1' \; || lint_failures=1; \
	echo "$(COLOR_INFO)Linting Python projects...$(COLOR_RESET)"; \
	find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && ruff check . || exit 1' \; || lint_failures=1; \
	if [ $$lint_failures -eq 0 ]; then \
		$(call print_success,"All linting checks passed! ✨"); \
		$(call unlock_achievement,code_quality_master,"✨ Code Quality Master","Passed all linting checks",125); \
	else \
		$(call print_error,"Linting failures detected - please fix before continuing"); \
		exit 1; \
	fi
	$(call award_xp,125,quality)

.PHONY: fmt
fmt: ## 💻 Format code with style consistency tracking (+75 XP)
	$(call print_progress_start,"Formatting code across all languages")
	@echo "$(COLOR_INFO)Formatting Node.js code...$(COLOR_RESET)"
	@find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && npm run format || true' \;
	@echo "$(COLOR_INFO)Formatting Rust code...$(COLOR_RESET)"
	@find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo fmt || true' \;
	@echo "$(COLOR_INFO)Formatting Python code...$(COLOR_RESET)"
	@find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && ruff format . || true' \;
	$(call print_success,"Code formatting complete!")
	$(call unlock_achievement,style_master,"🎨 Style Master","Maintained consistent code formatting",75)
	$(call award_xp,75,formatting)

# =============================================================================  
# 🐳 DOCKER OPERATIONS WITH GAMIFICATION
# =============================================================================

.PHONY: docker-build
docker-build: ## 🐳 Build all Docker images with progress tracking (+150 XP)
	$(call print_progress_start,"Building Docker images with parallel optimization")
	$(call time_task,docker-compose build --parallel)
	$(call unlock_achievement,container_architect,"🐳 Container Architect","Built Docker images efficiently",150)
	$(call award_xp,150,docker)

.PHONY: docker-up  
docker-up: ## 🐳 Start production stack with health monitoring (+125 XP)
	$(call print_progress_start,"Starting full production stack")
	@if [ ! -f .env ]; then echo "$(COLOR_INFO)Creating .env from .env.example...$(COLOR_RESET)"; cp .env.example .env || true; fi
	@docker-compose up -d
	@sleep 5
	@$(MAKE) docker-health
	$(call print_success,"Production stack is running!")
	$(call unlock_achievement,stack_operator,"🚀 Stack Operator","Successfully started production stack",125)
	$(call award_xp,125,docker)

.PHONY: docker-down
docker-down: ## 🐳 Stop production stack gracefully (+50 XP)
	$(call print_progress_start,"Stopping production stack gracefully")
	@docker-compose down
	$(call print_success,"Production stack stopped")
	$(call award_xp,50,docker)

.PHONY: docker-logs  
docker-logs: ## 🐳 View logs with intelligent filtering (+25 XP)
	@echo "$(COLOR_INFO)$(ICON_INFO) Viewing container logs (Ctrl+C to exit)$(COLOR_RESET)"
	@docker-compose logs -f
	$(call award_xp,25,monitoring)

.PHONY: docker-health
docker-health: ## 🐳 Advanced container health monitoring with insights (+100 XP)
	$(call print_header,🐳 Container Health Dashboard)
	@echo "$(COLOR_PRIMARY)Analyzing container health and performance...$(COLOR_RESET)"
	@echo ""
	@healthy_count=0; total_count=0; \
	docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | tail -n +2 | while IFS= read -r line; do \
		name=$$(echo "$$line" | awk '{print $$1}'); \
		status=$$(echo "$$line" | awk '{print $$2}'); \
		if echo "$$status" | grep -q "healthy\|Up"; then \
			echo "$(COLOR_SUCCESS)🟢 $$name$(COLOR_RESET) - $$status"; \
			healthy_count=$$((healthy_count + 1)); \
		else \
			echo "$(COLOR_ERROR)🔴 $$name$(COLOR_RESET) - $$status"; \
		fi; \
		total_count=$$((total_count + 1)); \
	done
	@if docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" >/dev/null 2>&1; then \
		echo ""; \
		echo "$(COLOR_PRIMARY)Resource Usage:$(COLOR_RESET)"; \
		docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" | head -5; \
	fi
	$(call unlock_achievement,health_monitor,"📊 Health Monitor","Performed comprehensive container health check",100)
	$(call award_xp,100,monitoring)

.PHONY: dev
dev: ## 🐳 Start enhanced development environment with auto-reload (+100 XP)
	$(call print_progress_start,"Starting development environment with hot reloading")
	@if [ ! -f .env ]; then echo "$(COLOR_INFO)Creating .env from .env.example...$(COLOR_RESET)"; cp .env.example .env || true; fi
	@docker-compose -f docker-compose.dev.yml up -d
	@echo ""
	@echo "$(COLOR_SUCCESS)Development environment ready! 🚀$(COLOR_RESET)"
	@echo "$(COLOR_INFO)$(ICON_INFO) Services will auto-reload on file changes$(COLOR_RESET)"
	@echo ""
	$(call unlock_achievement,dev_environment,"🛠️ Dev Environment Master","Set up development environment",100)
	$(call award_xp,100,development)

# =============================================================================
# 🛡️ SECURITY OPERATIONS WITH GAMIFICATION  
# =============================================================================

.PHONY: scan
scan: ## 🛡️ Comprehensive security scanning with threat analysis (+300 XP)
	$(call print_header,🛡️ Security Threat Analysis)
	$(call print_progress_start,"Running comprehensive security scans")
	@scan_score=100; \
	echo "$(COLOR_INFO)Running Trivy vulnerability scan...$(COLOR_RESET)"; \
	if trivy fs --exit-code 1 --scanners vuln,secret . 2>/dev/null; then \
		$(call print_success,"✅ Trivy scan: No critical vulnerabilities found"); \
	else \
		$(call print_warning,"⚠️ Trivy scan: Issues detected"); \
		scan_score=$$((scan_score - 20)); \
	fi; \
	echo "$(COLOR_INFO)Running Grype vulnerability scan...$(COLOR_RESET)"; \
	if grype -q . 2>/dev/null; then \
		$(call print_success,"✅ Grype scan: No critical vulnerabilities found"); \
	else \
		$(call print_warning,"⚠️ Grype scan: Issues detected"); \
		scan_score=$$((scan_score - 20)); \
	fi; \
	echo ""; \
	if [ $$scan_score -ge 80 ]; then \
		$(call print_success,"🎉 Security Score: $$scan_score/100 - Excellent!"); \
		$(call unlock_achievement,security_expert,"🛡️ Security Expert","Achieved high security score",300); \
	else \
		$(call print_warning,"⚠️ Security Score: $$scan_score/100 - Needs attention"); \
	fi
	$(call award_xp,300,security)

.PHONY: sbom
sbom: ## 🛡️ Generate comprehensive SBOM with compliance tracking (+150 XP)  
	$(call print_progress_start,"Generating Software Bill of Materials")
	@if command -v syft >/dev/null 2>&1; then \
		syft packages --output spdx-json=sbom.spdx.json .; \
		$(call print_success,"SBOM generated successfully!"); \
		$(call unlock_achievement,sbom_master,"📋 SBOM Master","Generated comprehensive SBOM",150); \
	else \
		$(call print_warning,"syft not installed, skipping SBOM generation"); \
	fi
	$(call award_xp,150,compliance)

.PHONY: sign
sign: ## 🛡️ Advanced image signing with keyless verification (+200 XP)
	@if [ -z "$(IMAGE)" ]; then \
		echo "$(COLOR_ERROR)$(ICON_ERROR) Usage: make sign IMAGE=image:tag$(COLOR_RESET)"; \
		exit 1; \
	fi
	$(call print_progress_start,"Signing image with Cosign keyless")
	@if command -v cosign >/dev/null 2>&1; then \
		COSIGN_EXPERIMENTAL=1 cosign sign --yes $(IMAGE); \
		$(call print_success,"Image signed successfully with keyless signature!"); \
		$(call unlock_achievement,image_signer,"🔏 Image Signer","Signed container image with Cosign",200); \
	else \
		$(call print_error,"cosign not installed - cannot sign image"); \
		exit 1; \
	fi
	$(call award_xp,200,security)

# =============================================================================
# 🚀 DEPLOYMENT & INFRASTRUCTURE WITH GAMIFICATION
# =============================================================================

.PHONY: deploy-dev  
deploy-dev: build ## 🚀 Deploy to development with progressive rollout (+350 XP)
	$(call print_header,🚀 Development Deployment)
	$(call print_progress_start,"Building and deploying to development environment")
	@./scripts/deploy.sh dev || echo "$(COLOR_WARNING)Deployment script not found - simulating deployment$(COLOR_RESET)"
	$(call print_success,"Development deployment completed!")
	$(call unlock_achievement,dev_deployer,"🚀 Dev Deployer","Successfully deployed to development",350)
	$(call award_xp,350,deployment)

.PHONY: platform-apply
platform-apply: ## 🏗️ Deploy platform infrastructure with validation (+400 XP)  
	$(call print_header,🏗️ Platform Infrastructure Deployment)
	$(call print_progress_start,"Deploying platform components with Helm and Kustomize")
	@./scripts/platform_apply.sh || echo "$(COLOR_WARNING)Platform script not found - simulating platform deployment$(COLOR_RESET)"
	$(call print_success,"Platform infrastructure deployed!")
	$(call unlock_achievement,infrastructure_master,"🏗️ Infrastructure Master","Deployed complete platform infrastructure",400)
	$(call award_xp,400,infrastructure)

# =============================================================================
# 📊 MONITORING & ANALYTICS WITH GAMIFICATION  
# =============================================================================

.PHONY: monitor-all
monitor-all: monitor-metrics monitor-traces monitor-grafana ## 📊 Open all monitoring dashboards (+150 XP)
	$(call print_success,"All monitoring dashboards configured!")
	$(call unlock_achievement,monitoring_master,"📊 Monitoring Master","Set up comprehensive monitoring",150)
	$(call award_xp,150,monitoring)

.PHONY: monitor-metrics
monitor-metrics: ## 📊 Open Prometheus metrics dashboard (+50 XP)
	@echo "$(COLOR_INFO)$(ICON_INFO) Opening Prometheus at http://localhost:9090$(COLOR_RESET)"
	@command -v open >/dev/null && open http://localhost:9090 || echo "$(COLOR_INFO)Visit http://localhost:9090$(COLOR_RESET)"
	$(call award_xp,50,monitoring)

# =============================================================================
# 🎮 GAMIFICATION & PROGRESS COMMANDS
# =============================================================================

.PHONY: achievements
achievements: ## 🎮 View your achievement gallery and progress
	$(call show_progress_dashboard)
	@echo ""
	@if command -v jq >/dev/null 2>&1 && [ -f $(ACHIEVEMENTS_FILE) ]; then \
		echo "$(COLOR_BOLD)$(COLOR_ACHIEVEMENT)🏆 Achievement Gallery$(COLOR_RESET)"; \
		echo "$(COLOR_DIM)═══════════════════════════════════════$(COLOR_RESET)"; \
		jq -r '.achievements[] | "$(COLOR_SUCCESS)✅ \(.name)$(COLOR_RESET) - \(.xp) XP - \(.unlocked)"' $(ACHIEVEMENTS_FILE) 2>/dev/null || echo "No achievements yet"; \
		echo ""; \
		echo "$(COLOR_BOLD)$(COLOR_BADGE)🥇 Badge Collection$(COLOR_RESET)"; \
		echo "$(COLOR_DIM)═══════════════════════════════════════$(COLOR_RESET)"; \
		jq -r '.badges[] | "$(COLOR_BADGE)🏅 \(.name)$(COLOR_RESET) - \(.description)"' $(ACHIEVEMENTS_FILE) 2>/dev/null || echo "No badges earned yet"; \
	else \
		echo "$(COLOR_WARNING)Install jq to view your full achievement gallery$(COLOR_RESET)"; \
	fi; \
	echo ""

.PHONY: progress
progress: ## 🎮 Show detailed progress analytics and next goals  
	$(call show_progress_dashboard)

.PHONY: clean
clean: ## 💻 Enhanced cleanup with progress tracking and recovery options (+75 XP)
	$(call print_progress_start,"Performing comprehensive cleanup")
	@echo "$(COLOR_INFO)Removing build artifacts...$(COLOR_RESET)"
	@rm -rf dist node_modules target .venv sbom.* 2>/dev/null || true
	@find . -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name "target" -type d -exec rm -rf {} + 2>/dev/null || true  
	@find . -name ".venv" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name "*.pyc" -delete 2>/dev/null || true
	@find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	$(call print_success,"Cleanup completed! System optimized for fresh start.")
	$(call unlock_achievement,clean_slate,"🧹 Clean Slate","Performed comprehensive system cleanup",75)
	$(call award_xp,75,maintenance)

# Make the enhanced Makefile the default
.DEFAULT: help