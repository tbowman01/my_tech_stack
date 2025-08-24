# =============================================================================
# 🧠 Smart Dependency Management & Validation
# =============================================================================
# Intelligent tool detection, validation, and automated suggestions

# Include required modules  
include scripts/makefile/colors.mk
include scripts/makefile/progress.mk

# Tool definitions with installation commands
REQUIRED_TOOLS := docker kubectl helm terraform
OPTIONAL_TOOLS := jq trivy cosign syft grype ruff pre-commit
LANGUAGE_TOOLS := node npm cargo python pip

# Smart tool validation with suggestions
define validate_tool
	@if command -v $(1) >/dev/null 2>&1; then \
		version=$$($(1) --version 2>/dev/null | head -1 || echo "unknown"); \
		echo "$(COLOR_SUCCESS)✅ $(1)$(COLOR_RESET) - $$version"; \
		return 0; \
	else \
		echo "$(COLOR_ERROR)❌ $(1)$(COLOR_RESET) - Not installed"; \
		$(call suggest_installation,$(1)); \
		return 1; \
	fi
endef

# Installation suggestions based on OS detection
define suggest_installation
	@echo "$(COLOR_INFO)   💡 Install suggestion:$(COLOR_RESET)"
	@case $(1) in \
		docker) \
			if command -v brew >/dev/null 2>&1; then \
				echo "$(COLOR_DIM)      brew install --cask docker$(COLOR_RESET)"; \
			elif command -v apt-get >/dev/null 2>&1; then \
				echo "$(COLOR_DIM)      sudo apt-get install docker.io$(COLOR_RESET)"; \
			elif command -v yum >/dev/null 2>&1; then \
				echo "$(COLOR_DIM)      sudo yum install docker$(COLOR_RESET)"; \
			else \
				echo "$(COLOR_DIM)      Visit: https://docs.docker.com/get-docker/$(COLOR_RESET)"; \
			fi ;; \
		kubectl) \
			echo "$(COLOR_DIM)      curl -LO https://dl.k8s.io/release/stable.txt$(COLOR_RESET)"; \
			echo "$(COLOR_DIM)      Or: brew install kubectl$(COLOR_RESET)" ;; \
		helm) \
			echo "$(COLOR_DIM)      curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash$(COLOR_RESET)"; \
			echo "$(COLOR_DIM)      Or: brew install helm$(COLOR_RESET)" ;; \
		terraform) \
			echo "$(COLOR_DIM)      Download from: https://www.terraform.io/downloads.html$(COLOR_RESET)"; \
			echo "$(COLOR_DIM)      Or: brew install terraform$(COLOR_RESET)" ;; \
		jq) \
			echo "$(COLOR_DIM)      brew install jq  OR  sudo apt-get install jq$(COLOR_RESET)" ;; \
		trivy) \
			echo "$(COLOR_DIM)      brew install trivy  OR  https://aquasecurity.github.io/trivy/$(COLOR_RESET)" ;; \
		cosign) \
			echo "$(COLOR_DIM)      brew install cosign  OR  https://docs.sigstore.dev/cosign/installation/$(COLOR_RESET)" ;; \
		node) \
			echo "$(COLOR_DIM)      https://nodejs.org/  OR  nvm install node$(COLOR_RESET)" ;; \
		*) \
			echo "$(COLOR_DIM)      Search package manager or official website$(COLOR_RESET)" ;; \
	esac
endef

# Comprehensive system validation
.PHONY: validate-system
validate-system: ## 🧠 Smart system validation with installation suggestions
	$(call print_header,🧠 Smart System Validation)
	@echo "$(COLOR_PRIMARY)Checking required tools...$(COLOR_RESET)"
	@echo ""
	
	@failed_count=0; \
	for tool in $(REQUIRED_TOOLS); do \
		if ! $(call validate_tool,$$tool); then \
			failed_count=$$((failed_count + 1)); \
		fi; \
	done; \
	echo ""; \
	
	@echo "$(COLOR_PRIMARY)Checking optional tools (recommended)...$(COLOR_RESET)"; \
	@echo ""; \
	@for tool in $(OPTIONAL_TOOLS); do \
		$(call validate_tool,$$tool) || true; \
	done; \
	echo ""; \
	
	@echo "$(COLOR_PRIMARY)Checking language environments...$(COLOR_RESET)"; \
	@echo ""; \
	@for tool in $(LANGUAGE_TOOLS); do \
		$(call validate_tool,$$tool) || true; \
	done; \
	echo ""; \
	
	@if [ $$failed_count -eq 0 ]; then \
		$(call print_success,"All required tools are installed! 🎉"); \
		$(call unlock_achievement,tool_master,"🔧 Tool Master","All required development tools installed",200); \
	else \
		$(call print_error,"$$failed_count required tools missing. Please install them to continue."); \
		echo "$(COLOR_INFO)💡 Run 'make install-missing' for automated installation (where possible)$(COLOR_RESET)"; \
	fi

# Smart dependency detection and installation
.PHONY: smart-deps  
smart-deps: ## 🧠 Intelligent dependency management across all languages
	$(call print_header,🧠 Smart Dependency Installation)
	@total_steps=0; current_step=0; \
	
	# Count total steps
	@if [ -d "." ]; then \
		package_json_count=$$(find . -name "package.json" -not -path "./node_modules/*" | wc -l); \
		cargo_toml_count=$$(find . -name "Cargo.toml" -not -path "./target/*" | wc -l); \
		requirements_txt_count=$$(find . -name "requirements.txt" -not -path "./.venv/*" | wc -l); \
		total_steps=$$((package_json_count + cargo_toml_count + requirements_txt_count)); \
	fi; \
	
	@echo "$(COLOR_INFO)$(ICON_INFO) Found projects requiring dependency installation$(COLOR_RESET)"; \
	@echo ""; \
	
	# Node.js projects
	@if find . -name "package.json" -not -path "./node_modules/*" | head -1 >/dev/null 2>&1; then \
		$(call print_progress_start,"Installing Node.js dependencies"); \
		find . -name "package.json" -not -path "./node_modules/*" -print0 | while IFS= read -r -d '' package; do \
			dir=$$(dirname "$$package"); \
			echo "$(COLOR_PROGRESS)  📦 Processing: $$dir$(COLOR_RESET)"; \
			cd "$$dir" && npm ci --silent && cd - >/dev/null || { \
				echo "$(COLOR_ERROR)    ❌ Failed to install dependencies in $$dir$(COLOR_RESET)"; \
				cd - >/dev/null; \
			}; \
			current_step=$$((current_step + 1)); \
			$(call progress_bar,$$current_step,$$total_steps,30); \
		done; \
	fi; \
	
	# Rust projects  
	@if find . -name "Cargo.toml" -not -path "./target/*" | head -1 >/dev/null 2>&1; then \
		$(call print_progress_start,"Installing Rust dependencies"); \
		find . -name "Cargo.toml" -not -path "./target/*" -print0 | while IFS= read -r -d '' cargo; do \
			dir=$$(dirname "$$cargo"); \
			echo "$(COLOR_PROGRESS)  🦀 Processing: $$dir$(COLOR_RESET)"; \
			cd "$$dir" && cargo fetch --quiet && cd - >/dev/null || { \
				echo "$(COLOR_ERROR)    ❌ Failed to fetch dependencies in $$dir$(COLOR_RESET)"; \
				cd - >/dev/null; \
			}; \
			current_step=$$((current_step + 1)); \
			$(call progress_bar,$$current_step,$$total_steps,30); \
		done; \
	fi; \
	
	# Python projects
	@if find . -name "requirements.txt" -not -path "./.venv/*" | head -1 >/dev/null 2>&1; then \
		$(call print_progress_start,"Installing Python dependencies"); \
		find . -name "requirements.txt" -not -path "./.venv/*" -print0 | while IFS= read -r -d '' requirements; do \
			dir=$$(dirname "$$requirements"); \
			echo "$(COLOR_PROGRESS)  🐍 Processing: $$dir$(COLOR_RESET)"; \
			cd "$$dir"; \
			if [ ! -d ".venv" ]; then \
				python -m venv .venv; \
			fi; \
			source .venv/bin/activate && pip install -r requirements.txt --quiet && cd - >/dev/null || { \
				echo "$(COLOR_ERROR)    ❌ Failed to install Python dependencies in $$dir$(COLOR_RESET)"; \
				cd - >/dev/null; \
			}; \
			current_step=$$((current_step + 1)); \
			$(call progress_bar,$$current_step,$$total_steps,30); \
		done; \
	fi; \
	
	$(call print_success,"Smart dependency installation complete!"); \
	$(call unlock_achievement,smart_deps,"🧠 Smart Dependency Master","Used intelligent dependency management",175)

# Environment-specific optimization suggestions
.PHONY: optimize-environment
optimize-environment: ## 🚀 Performance optimization suggestions
	$(call print_header,🚀 Environment Optimization)
	
	# Check system resources
	@echo "$(COLOR_PRIMARY)Analyzing system performance...$(COLOR_RESET)"; \
	echo ""; \
	
	# Memory optimization
	@if command -v free >/dev/null 2>&1; then \
		available_memory=$$(free -m | awk 'NR==2{printf "%.0f", $$7}'); \
		if [ $$available_memory -lt 2000 ]; then \
			$(call print_warning,"Low available memory ($$available_memory MB). Consider:"); \
			echo "$(COLOR_DIM)  • Closing unused applications$(COLOR_RESET)"; \
			echo "$(COLOR_DIM)  • Using lighter development containers$(COLOR_RESET)"; \
		else \
			$(call print_success,"Memory looks good ($$available_memory MB available)"); \
		fi; \
	fi; \
	
	# Disk space check
	@disk_usage=$$(df . | awk 'NR==2{print $$5}' | sed 's/%//'); \
	if [ $$disk_usage -gt 80 ]; then \
		$(call print_warning,"Disk usage high ($$disk_usage%). Consider running 'make clean'"); \
	else \
		$(call print_success,"Disk usage healthy ($$disk_usage%)"); \
	fi; \
	
	# Docker optimization  
	@if command -v docker >/dev/null 2>&1; then \
		if docker system df >/dev/null 2>&1; then \
			docker_size=$$(docker system df --format "table {{.Type}}\t{{.Size}}" | grep -E "(Images|Containers|Volumes)" | awk '{sum += $$2} END {printf "%.1f", sum}'); \
			echo "$(COLOR_INFO)$(ICON_INFO) Docker using ~$$docker_size GB$(COLOR_RESET)"; \
			echo "$(COLOR_DIM)  Run 'make docker-clean' to reclaim space$(COLOR_RESET)"; \
		fi; \
	fi; \
	echo ""

# Auto-fix common issues
.PHONY: auto-fix
auto-fix: ## 🔧 Automatically fix common development issues  
	$(call print_header,🔧 Auto-Fix Common Issues)
	
	# Fix missing .env file
	@if [ ! -f .env ] && [ -f .env.example ]; then \
		$(call print_info,"Creating .env from .env.example"); \
		cp .env.example .env; \
		$(call print_success,"Created .env file - please configure it"); \
	fi; \
	
	# Fix Docker daemon issues
	@if ! docker ps >/dev/null 2>&1; then \
		$(call print_warning,"Docker daemon not running"); \
		if command -v systemctl >/dev/null 2>&1; then \
			echo "$(COLOR_INFO)  Try: sudo systemctl start docker$(COLOR_RESET)"; \
		else \
			echo "$(COLOR_INFO)  Start Docker Desktop or Docker daemon$(COLOR_RESET)"; \
		fi; \
	fi; \
	
	# Fix permission issues
	@if [ -d node_modules ] && [ ! -w node_modules ]; then \
		$(call print_warning,"node_modules permission issues detected"); \
		echo "$(COLOR_INFO)  Try: sudo chown -R $$USER:$$USER node_modules$(COLOR_RESET)"; \
	fi; \
	
	$(call print_success,"Auto-fix scan complete!")

# Health check with actionable insights
.PHONY: health-check
health-check: ## 🏥 Comprehensive project health check
	@$(call print_header,🏥 Project Health Check)
	@overall_score=100; issues=0; \
	
	# Code quality checks
	@if command -v git >/dev/null 2>&1 && git status >/dev/null 2>&1; then \
		uncommitted=$$(git status --porcelain | wc -l); \
		if [ $$uncommitted -gt 0 ]; then \
			$(call print_warning,"$$uncommitted uncommitted changes found"); \
			overall_score=$$((overall_score - 10)); \
			issues=$$((issues + 1)); \
		else \
			$(call print_success,"Git working directory clean"); \
		fi; \
	fi; \
	
	# Dependency freshness  
	@if [ -f package.json ]; then \
		if command -v npm >/dev/null 2>&1; then \
			outdated=$$(npm outdated --json 2>/dev/null | jq length 2>/dev/null || echo "0"); \
			if [ $$outdated -gt 0 ]; then \
				$(call print_warning,"$$outdated outdated npm packages"); \
				overall_score=$$((overall_score - 5)); \
				issues=$$((issues + 1)); \
			fi; \
		fi; \
	fi; \
	
	# Security checks
	@if [ -f package.json ] && command -v npm >/dev/null 2>&1; then \
		if npm audit --audit-level=high --silent >/dev/null 2>&1; then \
			$(call print_success,"No high-severity security vulnerabilities"); \
		else \
			$(call print_error,"Security vulnerabilities detected"); \
			overall_score=$$((overall_score - 20)); \
			issues=$$((issues + 1)); \
		fi; \
	fi; \
	
	# Final health score
	@echo ""; \
	if [ $$overall_score -ge 90 ]; then \
		$(call print_success,"🎉 Project Health Score: $$overall_score/100 - Excellent!"); \
		$(call unlock_achievement,healthy_project,"🏥 Health Champion","Maintained excellent project health",150); \
	elif [ $$overall_score -ge 70 ]; then \
		$(call print_info,"📊 Project Health Score: $$overall_score/100 - Good"); \
	else \
		$(call print_warning,"⚠️ Project Health Score: $$overall_score/100 - Needs attention"); \
	fi; \
	echo ""