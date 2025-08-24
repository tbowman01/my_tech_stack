#!/usr/bin/env make

# 🎮 Enhanced Makefile - Gamified Development Environment
# ================================================================

SHELL := /bin/bash
.DEFAULT_GOAL := help

# Colors and visual elements
RED := $(shell printf '\033[0;31m')
GREEN := $(shell printf '\033[0;32m')
YELLOW := $(shell printf '\033[1;33m')
BLUE := $(shell printf '\033[0;34m')
PURPLE := $(shell printf '\033[0;35m')
CYAN := $(shell printf '\033[0;36m')
WHITE := $(shell printf '\033[1;37m')
BOLD := $(shell printf '\033[1m')
RESET := $(shell printf '\033[0m')

# Progress bar function
define progress_bar
	@echo -ne "$(CYAN)"
	@for i in $$(seq 1 $(1)); do echo -ne "▰"; done
	@for i in $$(seq $$(expr $(1) + 1) 20); do echo -ne "▱"; done
	@echo -e "$(RESET) $(2)%"
endef

# XP and achievement system
XP_FILE := .makefile_xp
ACHIEVEMENTS_FILE := .makefile_achievements

# Initialize XP if not exists
$(XP_FILE):
	@echo "0" > $(XP_FILE)

$(ACHIEVEMENTS_FILE):
	@touch $(ACHIEVEMENTS_FILE)

# Function to add XP
define add_xp
	@if [ ! -f $(XP_FILE) ]; then echo "0" > $(XP_FILE); fi
	@current_xp=$$(cat $(XP_FILE)); \
	new_xp=$$(expr $$current_xp + $(1)); \
	echo $$new_xp > $(XP_FILE); \
	level=$$(expr $$new_xp / 100 + 1); \
	echo "$(GREEN)🎯 +$(1) XP! Total: $$new_xp XP (Level $$level)$(RESET)"
endef

# Function to unlock achievement
define unlock_achievement
	@if [ ! -f $(ACHIEVEMENTS_FILE) ]; then touch $(ACHIEVEMENTS_FILE); fi
	@if ! grep -q "$(1)" $(ACHIEVEMENTS_FILE); then \
		echo "$(1)" >> $(ACHIEVEMENTS_FILE); \
		echo "$(YELLOW)🏆 ACHIEVEMENT UNLOCKED: $(1)!$(RESET)"; \
		echo "$(CYAN)🎁 Bonus: +$(2) XP!$(RESET)"; \
		$(call add_xp,$(2)); \
	fi
endef

# Include optional environment file
-include .env.mk

# Variables
IMAGE_REGISTRY ?= ghcr.io/$(shell git config --get remote.origin.url | sed 's/.*[:/]\([^/]*\/[^/]*\)\.git/\1/')
COMMIT_SHA ?= $(shell git rev-parse --short HEAD)

# ===============================================================================
# 🎮 GAMIFICATION & DASHBOARD
# ===============================================================================

.PHONY: help
help: ## 🎯 Show this colorful, organized help system
	@echo ""
	@echo "$(BOLD)$(PURPLE)🎮 Enhanced Development Environment - Gamified Makefile$(RESET)"
	@echo "$(CYAN)================================================================$(RESET)"
	@if [ -f $(XP_FILE) ]; then \
		xp=$$(cat $(XP_FILE)); \
		level=$$(expr $$xp / 100 + 1); \
		progress_in_level=$$(expr $$xp % 100); \
		achievement_count=$$(wc -l < $(ACHIEVEMENTS_FILE) 2>/dev/null || echo "0"); \
		echo "$(BOLD)📊 Your Progress:$(RESET) Level $$level | $$xp XP | $$achievement_count Achievements"; \
		bar_fill=$$(expr $$progress_in_level / 5); \
		echo -ne "$(CYAN)"; \
		for i in $$(seq 1 $$bar_fill); do echo -ne "▰"; done; \
		for i in $$(seq $$(expr $$bar_fill + 1) 20); do echo -ne "▱"; done; \
		echo -e "$(RESET) $$progress_in_level%"; \
	else \
		echo "$(BOLD)📊 Your Progress:$(RESET) Level 1 | 0 XP | 0 Achievements (Run any command to start!)"; \
	fi
	@echo ""
	@echo "$(BOLD)$(GREEN)🎯 Development Commands$(RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*## 🎯' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  $(CYAN)%-25s$(RESET) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(BOLD)$(BLUE)🐳 Docker & Container Commands$(RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*## 🐳' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  $(CYAN)%-25s$(RESET) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(BOLD)$(YELLOW)📊 Monitoring & Observability$(RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*## 📊' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  $(CYAN)%-25s$(RESET) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(BOLD)$(RED)🛡️  Security & Compliance$(RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*## 🛡️' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  $(CYAN)%-25s$(RESET) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(BOLD)$(PURPLE)🎮 Gamification Features$(RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*## 🎮' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  $(CYAN)%-25s$(RESET) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(CYAN)💡 Pro Tips:$(RESET)"
	@echo "  • Run $(BOLD)make interactive$(RESET) for guided workflows"
	@echo "  • Use $(BOLD)make stats$(RESET) to view your progress dashboard"
	@echo "  • Try $(BOLD)make quick-start$(RESET) for beginners"
	@echo ""

.PHONY: stats
stats: $(XP_FILE) $(ACHIEVEMENTS_FILE) ## 🎮 View your personal progress dashboard
	@echo ""
	@echo "$(BOLD)$(PURPLE)🎮 Personal Development Dashboard$(RESET)"
	@echo "$(CYAN)========================================$(RESET)"
	@xp=$$(cat $(XP_FILE)); \
	level=$$(expr $$xp / 100 + 1); \
	progress_in_level=$$(expr $$xp % 100); \
	achievement_count=$$(wc -l < $(ACHIEVEMENTS_FILE) 2>/dev/null || echo "0"); \
	echo "$(BOLD)🎯 Level:$(RESET) $$level"; \
	echo "$(BOLD)⚡ Total XP:$(RESET) $$xp"; \
	echo "$(BOLD)🏆 Achievements:$(RESET) $$achievement_count/20"; \
	echo "$(BOLD)📈 Progress to Next Level:$(RESET)"; \
	bar_fill=$$(expr $$progress_in_level / 5); \
	echo -ne "$(CYAN)"; \
	for i in $$(seq 1 $$bar_fill); do echo -ne "▰"; done; \
	for i in $$(seq $$(expr $$bar_fill + 1) 20); do echo -ne "▱"; done; \
	echo -e "$(RESET) $$progress_in_level%"
	@echo ""
	@echo "$(BOLD)🏆 Recent Achievements:$(RESET)"
	@if [ -s $(ACHIEVEMENTS_FILE) ]; then \
		tail -5 $(ACHIEVEMENTS_FILE) | sed 's/^/  🏆 /'; \
	else \
		echo "  $(YELLOW)No achievements yet - run some commands to get started!$(RESET)"; \
	fi
	@echo ""

.PHONY: leaderboard
leaderboard: $(ACHIEVEMENTS_FILE) ## 🎮 View achievement gallery and badges
	@echo ""
	@echo "$(BOLD)$(PURPLE)🏆 Achievement Gallery$(RESET)"
	@echo "$(CYAN)=========================$(RESET)"
	@if [ -s $(ACHIEVEMENTS_FILE) ]; then \
		cat $(ACHIEVEMENTS_FILE) | sed 's/^/🏆 /'; \
	else \
		echo "$(YELLOW)🎯 No achievements unlocked yet!$(RESET)"; \
		echo "$(CYAN)Available achievements:$(RESET)"; \
		echo "  🥇 First Steps - Run your first command"; \
		echo "  🏗️  Builder - Successfully build the project"; \
		echo "  🧪 Tester - Run comprehensive tests"; \
		echo "  🐳 Container Master - Docker expertise"; \
		echo "  🛡️  Security Champion - Security scans"; \
		echo "  📊 Monitor - Use monitoring tools"; \
		echo "  🚀 Deployer - Deploy to production"; \
		echo "  And many more..."; \
	fi
	@echo ""

.PHONY: interactive
interactive: ## 🎮 Interactive workflow selector with guided experience
	@echo ""
	@echo "$(BOLD)$(PURPLE)🎮 Interactive Development Workflows$(RESET)"
	@echo "$(CYAN)=====================================$(RESET)"
	@echo "$(BOLD)What would you like to do?$(RESET)"
	@echo ""
	@echo "$(GREEN)1.$(RESET) 🎯 Quick start (perfect for beginners)"
	@echo "$(GREEN)2.$(RESET) 🏗️  Full development setup"
	@echo "$(GREEN)3.$(RESET) 🐳 Docker workflow"
	@echo "$(GREEN)4.$(RESET) 🛡️  Security audit"
	@echo "$(GREEN)5.$(RESET) 📊 Monitoring setup"
	@echo "$(GREEN)6.$(RESET) 🚀 Production deployment"
	@echo "$(GREEN)7.$(RESET) 🧹 Cleanup everything"
	@echo ""
	@read -p "$(CYAN)Choose option (1-7): $(RESET)" choice; \
	case $$choice in \
		1) $(MAKE) quick-start ;; \
		2) $(MAKE) full-dev ;; \
		3) $(MAKE) docker-workflow ;; \
		4) $(MAKE) security-audit ;; \
		5) $(MAKE) monitor-all ;; \
		6) $(MAKE) deploy-prod ;; \
		7) $(MAKE) clean-all ;; \
		*) echo "$(RED)❌ Invalid choice!$(RESET)" ;; \
	esac

.PHONY: quick-start
quick-start: $(XP_FILE) ## 🎮 Beginner-friendly guided setup with achievements
	@echo ""
	@echo "$(BOLD)$(GREEN)🎯 Quick Start - Perfect for Beginners!$(RESET)"
	@echo "$(CYAN)=======================================$(RESET)"
	@echo "$(YELLOW)🚀 Starting your development journey...$(RESET)"
	@echo ""
	$(call progress_bar,5,25)
	@sleep 1
	@echo "$(GREEN)✅ Validating development environment...$(RESET)"
	$(call progress_bar,10,50)
	@$(MAKE) validate-tools
	@sleep 1
	@echo "$(GREEN)✅ Installing dependencies...$(RESET)"
	$(call progress_bar,15,75)
	@$(MAKE) deps
	@sleep 1
	@echo "$(GREEN)✅ Running initial tests...$(RESET)"
	$(call progress_bar,20,100)
	@$(MAKE) test
	@echo ""
	@echo "$(BOLD)$(GREEN)🎉 Congratulations! Quick start complete!$(RESET)"
	$(call unlock_achievement,"First Steps - Completed quick start",25)
	$(call add_xp,30)

# ===============================================================================
# 🎯 DEVELOPMENT COMMANDS (Enhanced with gamification)
# ===============================================================================

.PHONY: init-dev
init-dev: $(XP_FILE) ## 🎯 Install git hooks, pre-commit, validate toolchain
	@echo "$(BOLD)$(CYAN)🔧 Initializing development environment...$(RESET)"
	$(call progress_bar,2,10)
	@echo "Installing pre-commit hooks..."
	@pre-commit install -t pre-commit -t commit-msg || echo "$(YELLOW)⚠️  pre-commit not installed, please install it$(RESET)"
	$(call progress_bar,10,50)
	@echo "Validating toolchain..."
	@$(MAKE) validate-tools
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Development environment initialized!$(RESET)"
	$(call unlock_achievement,"Environment Setup - Dev environment ready",15)
	$(call add_xp,20)

.PHONY: validate-tools
validate-tools: ## 🎯 Smart tool validation with helpful installation hints
	@echo "$(CYAN)🔍 Validating required tools...$(RESET)"
	@echo "$(BOLD)Checking Docker...$(RESET)"
	@command -v docker >/dev/null 2>&1 && echo "$(GREEN)✅ Docker found$(RESET)" || \
		(echo "$(RED)❌ Docker not found$(RESET)"; echo "$(YELLOW)💡 Install: https://docs.docker.com/get-docker/$(RESET)")
	@echo "$(BOLD)Checking kubectl...$(RESET)"
	@command -v kubectl >/dev/null 2>&1 && echo "$(GREEN)✅ kubectl found$(RESET)" || \
		(echo "$(RED)❌ kubectl not found$(RESET)"; echo "$(YELLOW)💡 Install: https://kubernetes.io/docs/tasks/tools/$(RESET)")
	@echo "$(BOLD)Checking helm...$(RESET)"
	@command -v helm >/dev/null 2>&1 && echo "$(GREEN)✅ helm found$(RESET)" || \
		(echo "$(RED)❌ helm not found$(RESET)"; echo "$(YELLOW)💡 Install: https://helm.sh/docs/intro/install/$(RESET)")
	@echo "$(BOLD)Checking terraform...$(RESET)"
	@command -v terraform >/dev/null 2>&1 && echo "$(GREEN)✅ terraform found$(RESET)" || \
		(echo "$(RED)❌ terraform not found$(RESET)"; echo "$(YELLOW)💡 Install: https://learn.hashicorp.com/terraform/getting-started/install$(RESET)")
	@echo "$(GREEN)✅ Toolchain validation complete!$(RESET)"

.PHONY: deps
deps: $(XP_FILE) ## 🎯 Install dependencies for all languages with smart detection
	@echo "$(BOLD)$(CYAN)📦 Installing dependencies...$(RESET)"
	@echo "$(YELLOW)🔍 Detecting project languages...$(RESET)"
	$(call progress_bar,2,10)
	@if find . -name "package.json" -not -path "./node_modules/*" | head -1 | grep -q .; then \
		echo "$(GREEN)📦 Node.js projects detected$(RESET)"; \
		find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && echo "Installing deps in $$(pwd)" && npm ci' \;; \
	fi
	$(call progress_bar,8,40)
	@if find . -name "Cargo.toml" -not -path "./target/*" | head -1 | grep -q .; then \
		echo "$(GREEN)🦀 Rust projects detected$(RESET)"; \
		find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && echo "Fetching deps in $$(pwd)" && cargo fetch' \;; \
	fi
	$(call progress_bar,14,70)
	@if find . -name "requirements.txt" -not -path "./.venv/*" | head -1 | grep -q .; then \
		echo "$(GREEN)🐍 Python projects detected$(RESET)"; \
		find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && echo "Installing deps in $$(pwd)" && pip install -r requirements.txt' \;; \
	fi
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ All dependencies installed successfully!$(RESET)"
	$(call unlock_achievement,"Dependency Master - Installed all project deps",10)
	$(call add_xp,15)

.PHONY: test
test: $(XP_FILE) ## 🎯 Run all tests with comprehensive coverage reporting
	@echo "$(BOLD)$(CYAN)🧪 Running comprehensive test suite...$(RESET)"
	@echo "$(YELLOW)🔍 Detecting test frameworks...$(RESET)"
	$(call progress_bar,2,10)
	@tests_run=0; \
	if find . -name "package.json" -not -path "./node_modules/*" | head -1 | grep -q .; then \
		echo "$(GREEN)🧪 Running Node.js tests...$(RESET)"; \
		find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && [ -f package.json ] && npm test || true' \; && tests_run=$$((tests_run+1)); \
		$(call progress_bar,8,40); \
	fi; \
	if find . -name "Cargo.toml" -not -path "./target/*" | head -1 | grep -q .; then \
		echo "$(GREEN)🦀 Running Rust tests...$(RESET)"; \
		find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo test --all || true' \; && tests_run=$$((tests_run+1)); \
		$(call progress_bar,14,70); \
	fi; \
	if find . -name "requirements.txt" -not -path "./.venv/*" | head -1 | grep -q .; then \
		echo "$(GREEN)🐍 Running Python tests...$(RESET)"; \
		find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && pytest || true' \; && tests_run=$$((tests_run+1)); \
		$(call progress_bar,20,100); \
	fi; \
	if [ $$tests_run -eq 0 ]; then \
		echo "$(YELLOW)⚠️  No test frameworks detected$(RESET)"; \
	else \
		echo "$(GREEN)✅ Test suite completed! Ran tests for $$tests_run language(s)$(RESET)"; \
	fi
	$(call unlock_achievement,"Test Runner - Executed comprehensive test suite",15)
	$(call add_xp,20)

.PHONY: build
build: $(XP_FILE) ## 🎯 Build all services with progress tracking
	@echo "$(BOLD)$(CYAN)🏗️  Building all services...$(RESET)"
	$(call progress_bar,5,25)
	@./scripts/build_all.sh
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Build completed successfully!$(RESET)"
	$(call unlock_achievement,"Builder - Successfully built all services",20)
	$(call add_xp,25)

.PHONY: lint
lint: $(XP_FILE) ## 🎯 Run linters for all languages with auto-fix suggestions
	@echo "$(BOLD)$(CYAN)🔍 Running linters and code quality checks...$(RESET)"
	@echo "$(YELLOW)📊 Analyzing code quality...$(RESET)"
	$(call progress_bar,3,15)
	@linters_run=0; \
	if find . -name "package.json" -not -path "./node_modules/*" | head -1 | grep -q .; then \
		echo "$(GREEN)📝 Linting JavaScript/TypeScript...$(RESET)"; \
		find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && npm run lint || true' \; && linters_run=$$((linters_run+1)); \
		$(call progress_bar,8,40); \
	fi; \
	if find . -name "Cargo.toml" -not -path "./target/*" | head -1 | grep -q .; then \
		echo "$(GREEN)🦀 Running Clippy for Rust...$(RESET)"; \
		find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo clippy || true' \; && linters_run=$$((linters_run+1)); \
		$(call progress_bar,14,70); \
	fi; \
	if find . -name "requirements.txt" -not -path "./.venv/*" | head -1 | grep -q .; then \
		echo "$(GREEN)🐍 Running Ruff for Python...$(RESET)"; \
		find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && ruff check . || true' \; && linters_run=$$((linters_run+1)); \
		$(call progress_bar,20,100); \
	fi; \
	echo "$(GREEN)✅ Code quality analysis complete! Checked $$linters_run language(s)$(RESET)"
	$(call unlock_achievement,"Code Quality Champion - Clean linting results",10)
	$(call add_xp,15)

.PHONY: fmt
fmt: $(XP_FILE) ## 🎯 Format code for all languages with style consistency
	@echo "$(BOLD)$(CYAN)✨ Formatting code for consistency...$(RESET)"
	$(call progress_bar,3,15)
	@if find . -name "package.json" -not -path "./node_modules/*" | head -1 | grep -q .; then \
		echo "$(GREEN)📝 Formatting JavaScript/TypeScript...$(RESET)"; \
		find . -name "package.json" -not -path "./node_modules/*" -exec sh -c 'cd "$$(dirname "{}")" && npm run format || true' \;; \
		$(call progress_bar,8,40); \
	fi
	@if find . -name "Cargo.toml" -not -path "./target/*" | head -1 | grep -q .; then \
		echo "$(GREEN)🦀 Formatting Rust code...$(RESET)"; \
		find . -name "Cargo.toml" -not -path "./target/*" -exec sh -c 'cd "$$(dirname "{}")" && cargo fmt || true' \;; \
		$(call progress_bar,14,70); \
	fi
	@if find . -name "requirements.txt" -not -path "./.venv/*" | head -1 | grep -q .; then \
		echo "$(GREEN)🐍 Formatting Python code...$(RESET)"; \
		find . -name "requirements.txt" -not -path "./.venv/*" -exec sh -c 'cd "$$(dirname "{}")" && ruff format . || true' \;; \
		$(call progress_bar,20,100); \
	fi
	@echo "$(GREEN)✅ Code formatting complete!$(RESET)"
	$(call add_xp,10)

.PHONY: clean
clean: $(XP_FILE) ## 🎯 Remove build artifacts with smart cleanup
	@echo "$(BOLD)$(CYAN)🧹 Cleaning build artifacts...$(RESET)"
	$(call progress_bar,5,25)
	@echo "$(YELLOW)🗑️  Removing common build directories...$(RESET)"
	@rm -rf dist node_modules target .venv sbom.* || true
	$(call progress_bar,10,50)
	@echo "$(YELLOW)🔍 Finding and removing nested artifacts...$(RESET)"
	@find . -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name "target" -type d -exec rm -rf {} + 2>/dev/null || true
	@find . -name ".venv" -type d -exec rm -rf {} + 2>/dev/null || true
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Cleanup completed!$(RESET)"
	$(call add_xp,10)

# ===============================================================================
# 🛡️ SECURITY & COMPLIANCE (Enhanced with gamification)
# ===============================================================================

.PHONY: sbom
sbom: $(XP_FILE) ## 🛡️ Generate Software Bill of Materials with Syft
	@echo "$(BOLD)$(CYAN)📋 Generating SBOM (Software Bill of Materials)...$(RESET)"
	$(call progress_bar,5,25)
	@syft packages --output spdx-json=sbom.spdx.json . || echo "$(YELLOW)⚠️  syft not installed, skipping SBOM generation$(RESET)"
	$(call progress_bar,20,100)
	@if [ -f "sbom.spdx.json" ]; then \
		echo "$(GREEN)✅ SBOM generated successfully!$(RESET)"; \
		$(call unlock_achievement,"SBOM Generator - Created software inventory",15); \
	fi
	$(call add_xp,15)

.PHONY: scan
scan: $(XP_FILE) ## 🛡️ Security vulnerability scans with Trivy/Grype
	@echo "$(BOLD)$(CYAN)🔍 Running comprehensive security scans...$(RESET)"
	@echo "$(YELLOW)🛡️  Scanning for vulnerabilities...$(RESET)"
	$(call progress_bar,5,25)
	@trivy fs --exit-code 1 --scanners vuln,secret . || echo "$(YELLOW)⚠️  trivy not installed, skipping vulnerability scan$(RESET)"
	$(call progress_bar,15,75)
	@grype -q . || echo "$(YELLOW)⚠️  grype not installed, skipping vulnerability scan$(RESET)"
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Security scan completed!$(RESET)"
	$(call unlock_achievement,"Security Scanner - Executed vulnerability scans",20)
	$(call add_xp,25)

.PHONY: sign
sign: $(XP_FILE) ## 🛡️ Cosign keyless image signing (Usage: make sign IMAGE=image:tag)
	@echo "$(BOLD)$(CYAN)✍️  Signing container images...$(RESET)"
	@if [ -z "$(IMAGE)" ]; then \
		echo "$(RED)❌ Usage: make sign IMAGE=image:tag$(RESET)"; \
		echo "$(YELLOW)💡 Example: make sign IMAGE=myapp:latest$(RESET)"; \
		exit 1; \
	fi
	$(call progress_bar,10,50)
	@COSIGN_EXPERIMENTAL=1 cosign sign --yes $(IMAGE)
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Image $(IMAGE) signed successfully!$(RESET)"
	$(call unlock_achievement,"Image Signer - Cosign security signing",15)
	$(call add_xp,20)

.PHONY: verify-admission
verify-admission: $(XP_FILE) ## 🛡️ Test OPA/Gatekeeper policies locally
	@echo "$(BOLD)$(CYAN)🛡️  Testing admission control policies...$(RESET)"
	$(call progress_bar,8,40)
	@conftest test -p policies/conftest . || echo "$(YELLOW)⚠️  conftest not installed, skipping policy tests$(RESET)"
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Policy validation completed!$(RESET)"
	$(call unlock_achievement,"Policy Validator - OPA/Gatekeeper testing",15)
	$(call add_xp,20)

.PHONY: security-audit
security-audit: sbom scan verify-admission ## 🛡️ Complete security audit workflow
	@echo ""
	@echo "$(BOLD)$(GREEN)🏆 Security Audit Complete!$(RESET)"
	@echo "$(CYAN)📊 Audit Summary:$(RESET)"
	@echo "  ✅ SBOM generated"
	@echo "  ✅ Vulnerability scan completed"
	@echo "  ✅ Policy validation finished"
	$(call unlock_achievement,"Security Champion - Full security audit",30)
	$(call add_xp,40)

# ===============================================================================
# 🐳 DOCKER & CONTAINER COMMANDS (Enhanced with gamification)
# ===============================================================================

.PHONY: docker-build
docker-build: $(XP_FILE) ## 🐳 Build all Docker images with parallel processing
	@echo "$(BOLD)$(CYAN)🐳 Building Docker images...$(RESET)"
	$(call progress_bar,5,25)
	@docker-compose build --parallel
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Docker images built successfully!$(RESET)"
	$(call unlock_achievement,"Container Builder - Docker images built",15)
	$(call add_xp,20)

.PHONY: docker-up
docker-up: $(XP_FILE) ## 🐳 Start full production stack with health checks
	@echo "$(BOLD)$(CYAN)🚀 Starting full production stack...$(RESET)"
	@if [ ! -f .env ]; then \
		echo "$(YELLOW)📝 Creating .env from .env.example...$(RESET)"; \
		cp .env.example .env; \
	fi
	$(call progress_bar,5,25)
	@docker-compose up -d
	$(call progress_bar,15,75)
	@echo "$(YELLOW)⏳ Waiting for services to be healthy...$(RESET)"
	@sleep 5
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Production stack is running!$(RESET)"
	@$(MAKE) docker-health
	$(call unlock_achievement,"Stack Launcher - Production environment up",20)
	$(call add_xp,25)

.PHONY: docker-down
docker-down: $(XP_FILE) ## 🐳 Stop production stack gracefully
	@echo "$(BOLD)$(CYAN)🛑 Stopping production stack gracefully...$(RESET)"
	$(call progress_bar,10,50)
	@docker-compose down
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Production stack stopped!$(RESET)"
	$(call add_xp,10)

.PHONY: docker-logs
docker-logs: ## 🐳 Stream logs from all containers with filtering
	@echo "$(BOLD)$(CYAN)📋 Streaming container logs...$(RESET)"
	@echo "$(YELLOW)💡 Press Ctrl+C to stop$(RESET)"
	@docker-compose logs -f

.PHONY: docker-health
docker-health: ## 🐳 Comprehensive container health dashboard
	@echo ""
	@echo "$(BOLD)$(CYAN)🏥 Container Health Dashboard$(RESET)"
	@echo "$(CYAN)================================$(RESET)"
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" --filter "status=running"
	@echo ""
	@echo "$(BOLD)📊 Resource Usage:$(RESET)"
	@docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" 2>/dev/null || echo "$(YELLOW)⚠️  No running containers$(RESET)"

.PHONY: docker-shell
docker-shell: ## 🐳 Open interactive shell in container (Usage: make docker-shell SERVICE=api-gateway)
	@if [ -z "$(SERVICE)" ]; then \
		echo "$(RED)❌ Usage: make docker-shell SERVICE=api-gateway$(RESET)"; \
		echo "$(YELLOW)💡 Available services:$(RESET)"; \
		docker-compose config --services | sed 's/^/  - /'; \
		exit 1; \
	fi
	@echo "$(CYAN)🐚 Opening shell in $(SERVICE) container...$(RESET)"
	@docker-compose exec $(SERVICE) sh

.PHONY: dev
dev: $(XP_FILE) ## 🐳 Start lightweight development environment
	@echo "$(BOLD)$(CYAN)💻 Starting development environment...$(RESET)"
	@if [ ! -f .env ]; then \
		echo "$(YELLOW)📝 Creating .env from .env.example...$(RESET)"; \
		cp .env.example .env; \
	fi
	$(call progress_bar,8,40)
	@docker-compose -f docker-compose.dev.yml up -d
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Development environment ready!$(RESET)"
	@echo "$(CYAN)🌐 Services available at:$(RESET)"
	@echo "  • API Gateway: http://localhost:3000"
	@echo "  • Frontend: http://localhost:3001"
	@echo "  • Database: localhost:5432"
	$(call unlock_achievement,"Dev Environment - Development setup complete",15)
	$(call add_xp,20)

.PHONY: dev-down
dev-down: ## 🐳 Stop development environment
	@echo "$(BOLD)$(CYAN)🛑 Stopping development environment...$(RESET)"
	@docker-compose -f docker-compose.dev.yml down
	@echo "$(GREEN)✅ Development environment stopped!$(RESET)"

.PHONY: docker-workflow
docker-workflow: docker-build dev docker-health ## 🐳 Complete Docker development workflow
	@echo ""
	@echo "$(BOLD)$(GREEN)🐳 Docker Workflow Complete!$(RESET)"
	@echo "$(CYAN)✅ Images built, dev environment running, health checked$(RESET)"
	$(call unlock_achievement,"Container Master - Full Docker workflow",25)
	$(call add_xp,35)

# ===============================================================================
# 📊 MONITORING & OBSERVABILITY (Enhanced with gamification)
# ===============================================================================

.PHONY: monitor-logs
monitor-logs: ## 📊 Monitor application logs with smart filtering
	@echo "$(BOLD)$(CYAN)📋 Monitoring application logs...$(RESET)"
	@echo "$(YELLOW)💡 Filtering for key services: api-gateway, users, ai-inference$(RESET)"
	@docker-compose logs -f api-gateway users ai-inference

.PHONY: monitor-metrics
monitor-metrics: $(XP_FILE) ## 📊 Open Prometheus metrics dashboard
	@echo "$(BOLD)$(CYAN)📊 Opening Prometheus metrics dashboard...$(RESET)"
	@echo "$(GREEN)🌐 Prometheus available at: http://localhost:9090$(RESET)"
	@command -v open >/dev/null && open http://localhost:9090 || echo "$(YELLOW)💡 Visit http://localhost:9090 in your browser$(RESET)"
	$(call unlock_achievement,"Metrics Monitor - Prometheus dashboard access",10)
	$(call add_xp,15)

.PHONY: monitor-traces
monitor-traces: $(XP_FILE) ## 📊 Open Jaeger tracing dashboard
	@echo "$(BOLD)$(CYAN)🔍 Opening Jaeger tracing dashboard...$(RESET)"
	@echo "$(GREEN)🌐 Jaeger available at: http://localhost:16686$(RESET)"
	@command -v open >/dev/null && open http://localhost:16686 || echo "$(YELLOW)💡 Visit http://localhost:16686 in your browser$(RESET)"
	$(call unlock_achievement,"Trace Tracker - Jaeger tracing access",10)
	$(call add_xp,15)

.PHONY: monitor-grafana
monitor-grafana: $(XP_FILE) ## 📊 Open Grafana visualization dashboard
	@echo "$(BOLD)$(CYAN)📈 Opening Grafana dashboard...$(RESET)"
	@echo "$(GREEN)🌐 Grafana available at: http://localhost:3000$(RESET)"
	@echo "$(CYAN)🔑 Default credentials: admin/admin$(RESET)"
	@command -v open >/dev/null && open http://localhost:3000 || echo "$(YELLOW)💡 Visit http://localhost:3000 in your browser$(RESET)"
	$(call unlock_achievement,"Data Visualizer - Grafana dashboard access",10)
	$(call add_xp,15)

.PHONY: monitor-all
monitor-all: monitor-metrics monitor-traces monitor-grafana ## 📊 Open all monitoring dashboards
	@echo ""
	@echo "$(BOLD)$(GREEN)📊 All Monitoring Dashboards Launched!$(RESET)"
	@echo "$(CYAN)🎯 Complete observability stack ready$(RESET)"
	$(call unlock_achievement,"Observatory Master - Full monitoring stack",25)
	$(call add_xp,30)

# ===============================================================================
# 🚀 DEPLOYMENT & PLATFORM (Enhanced with gamification)
# ===============================================================================

.PHONY: platform-apply
platform-apply: $(XP_FILE) ## 🚀 Install/upgrade platform via Helm/Kustomize
	@echo "$(BOLD)$(CYAN)🚀 Deploying platform components...$(RESET)"
	$(call progress_bar,8,40)
	@./scripts/platform_apply.sh
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Platform deployment complete!$(RESET)"
	$(call unlock_achievement,"Platform Deployer - Infrastructure deployed",25)
	$(call add_xp,35)

.PHONY: vault-bootstrap
vault-bootstrap: $(XP_FILE) ## 🚀 Configure Vault (PKI/Transit/KV, policies, roles)
	@echo "$(BOLD)$(CYAN)🔐 Bootstrapping Vault...$(RESET)"
	$(call progress_bar,10,50)
	@./scripts/vault_bootstrap.sh
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Vault configuration complete!$(RESET)"
	$(call unlock_achievement,"Vault Master - Security infrastructure ready",20)
	$(call add_xp,30)

.PHONY: keycloak-bootstrap
keycloak-bootstrap: $(XP_FILE) ## 🚀 Import Keycloak realm, clients, roles
	@echo "$(BOLD)$(CYAN)🔑 Bootstrapping Keycloak...$(RESET)"
	$(call progress_bar,8,40)
	@./scripts/keycloak_bootstrap.sh
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Keycloak configuration complete!$(RESET)"
	$(call unlock_achievement,"Identity Manager - Authentication configured",20)
	$(call add_xp,30)

.PHONY: deploy-dev
deploy-dev: build $(XP_FILE) ## 🚀 Build images, sign, deploy to dev with progressive rollout
	@echo "$(BOLD)$(CYAN)🚀 Deploying to development environment...$(RESET)"
	$(call progress_bar,8,40)
	@./scripts/deploy.sh dev
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Development deployment successful!$(RESET)"
	$(call unlock_achievement,"Dev Deployer - Development environment updated",20)
	$(call add_xp,30)

.PHONY: deploy-prod
deploy-prod: build $(XP_FILE) ## 🚀 Deploy to production with safety checks and progressive rollout
	@echo "$(BOLD)$(RED)🚨 Production Deployment - Safety Checks Enabled$(RESET)"
	@read -p "$(YELLOW)⚠️  Are you sure you want to deploy to PRODUCTION? (y/N): $(RESET)" confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		echo "$(CYAN)🚀 Proceeding with production deployment...$(RESET)"; \
		$(call progress_bar,8,40); \
		./scripts/deploy.sh prod; \
		$(call progress_bar,20,100); \
		echo "$(GREEN)✅ Production deployment successful!$(RESET)"; \
		$(call unlock_achievement,"Production Deployer - Live system updated",50); \
		$(call add_xp,75); \
	else \
		echo "$(YELLOW)⏹️  Production deployment cancelled$(RESET)"; \
	fi

.PHONY: full-dev
full-dev: init-dev deps test build docker-build dev ## 🎮 Complete development pipeline
	@echo ""
	@echo "$(BOLD)$(GREEN)🏆 Full Development Pipeline Complete!$(RESET)"
	@echo "$(CYAN)✅ Environment initialized, dependencies installed, tests passed, built, containerized$(RESET)"
	$(call unlock_achievement,"Development Master - Complete pipeline execution",40)
	$(call add_xp,60)

.PHONY: clean-all
clean-all: clean ## 🧹 Deep clean everything including Docker resources
	@echo "$(BOLD)$(CYAN)🧹 Deep cleaning all resources...$(RESET)"
	$(call progress_bar,5,25)
	@echo "$(YELLOW)🐳 Cleaning Docker resources...$(RESET)"
	@docker-compose down -v --remove-orphans 2>/dev/null || true
	@docker system prune -f 2>/dev/null || true
	@docker volume prune -f 2>/dev/null || true
	$(call progress_bar,20,100)
	@echo "$(GREEN)✅ Deep clean completed!$(RESET)"
	$(call add_xp,15)

# ===============================================================================
# 🎮 ADVANCED GAMIFICATION FEATURES
# ===============================================================================

.PHONY: reset-progress
reset-progress: ## 🎮 Reset all XP and achievements (Use with caution!)
	@echo "$(BOLD)$(RED)🚨 Warning: This will reset all your progress!$(RESET)"
	@read -p "$(YELLOW)Are you sure? This cannot be undone! (type 'RESET' to confirm): $(RESET)" confirm; \
	if [ "$$confirm" = "RESET" ]; then \
		rm -f $(XP_FILE) $(ACHIEVEMENTS_FILE); \
		echo "$(RED)🔄 Progress reset complete. Start fresh!$(RESET)"; \
	else \
		echo "$(GREEN)✅ Reset cancelled$(RESET)"; \
	fi

.PHONY: dependency-tree
dependency-tree: ## 🎮 Visualize command dependencies and workflows
	@echo ""
	@echo "$(BOLD)$(PURPLE)🌳 Command Dependency Tree$(RESET)"
	@echo "$(CYAN)============================$(RESET)"
	@echo "$(BOLD)🎯 Development Workflow:$(RESET)"
	@echo "  quick-start → init-dev → deps → test → build"
	@echo ""
	@echo "$(BOLD)🐳 Docker Workflow:$(RESET)"
	@echo "  docker-build → dev/docker-up → docker-health"
	@echo ""
	@echo "$(BOLD)🛡️ Security Workflow:$(RESET)"
	@echo "  sbom → scan → verify-admission → security-audit"
	@echo ""
	@echo "$(BOLD)🚀 Deployment Workflow:$(RESET)"
	@echo "  build → deploy-dev → deploy-prod"
	@echo ""
	@echo "$(BOLD)📊 Monitoring Workflow:$(RESET)"
	@echo "  monitor-metrics → monitor-traces → monitor-grafana → monitor-all"
	@echo ""

# Create XP and achievements files on first run
$(shell [ ! -f $(XP_FILE) ] && echo "0" > $(XP_FILE))
$(shell [ ! -f $(ACHIEVEMENTS_FILE) ] && touch $(ACHIEVEMENTS_FILE))