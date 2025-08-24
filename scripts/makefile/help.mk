# =============================================================================
# 📚 Enhanced Interactive Help System 
# =============================================================================
# Multi-level help with visual categorization and examples

# Include required modules
include scripts/makefile/colors.mk
include scripts/makefile/gamification.mk

# Help categories and their commands
HELP_CATEGORIES := dev docker infra test monitor security deploy gamification

# Help system
.PHONY: help
help: ## 🏠 Show this enhanced help menu with categories
	$(call show_progress_dashboard)
	$(call print_header,🎮 Enhanced Makefile - Gamified Developer Experience)
	@echo "$(COLOR_PRIMARY)Welcome to the Enhanced Development Environment!$(COLOR_RESET)"
	@echo "$(COLOR_DIM)Complete tasks to earn XP, unlock achievements, and level up your skills!$(COLOR_RESET)"
	@echo ""
	
	@echo "$(COLOR_BOLD)$(ICON_DEV) DEVELOPMENT COMMANDS$(COLOR_RESET)"
	@echo "$(COLOR_DIM)────────────────────────────$(COLOR_RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## 💻' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(COLOR_SUCCESS)%-24s$(COLOR_RESET) %s\n", $$1, $$2}'
	@echo ""
	
	@echo "$(COLOR_BOLD)$(ICON_DOCKER) DOCKER OPERATIONS$(COLOR_RESET)"
	@echo "$(COLOR_DIM)────────────────────────────$(COLOR_RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## 🐳' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(COLOR_SUCCESS)%-24s$(COLOR_RESET) %s\n", $$1, $$2}'
	@echo ""
	
	@echo "$(COLOR_BOLD)$(ICON_INFRA) INFRASTRUCTURE$(COLOR_RESET)"
	@echo "$(COLOR_DIM)────────────────────────────$(COLOR_RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## 🏗️' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(COLOR_SUCCESS)%-24s$(COLOR_RESET) %s\n", $$1, $$2}'
	@echo ""
	
	@echo "$(COLOR_BOLD)$(ICON_TEST) TESTING & QUALITY$(COLOR_RESET)"
	@echo "$(COLOR_DIM)────────────────────────────$(COLOR_RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## 🧪' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(COLOR_SUCCESS)%-24s$(COLOR_RESET) %s\n", $$1, $$2}'
	@echo ""
	
	@echo "$(COLOR_BOLD)$(ICON_SECURITY) SECURITY$(COLOR_RESET)"  
	@echo "$(COLOR_DIM)────────────────────────────$(COLOR_RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## 🛡️' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(COLOR_SUCCESS)%-24s$(COLOR_RESET) %s\n", $$1, $$2}'
	@echo ""
	
	@echo "$(COLOR_BOLD)$(ICON_MONITOR) MONITORING$(COLOR_RESET)"
	@echo "$(COLOR_DIM)────────────────────────────$(COLOR_RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## 📊' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(COLOR_SUCCESS)%-24s$(COLOR_RESET) %s\n", $$1, $$2}'
	@echo ""
	
	@echo "$(COLOR_BOLD)$(ICON_QUEST) GAMIFICATION$(COLOR_RESET)"
	@echo "$(COLOR_DIM)────────────────────────────$(COLOR_RESET)"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## 🎮' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(COLOR_SUCCESS)%-24s$(COLOR_RESET) %s\n", $$1, $$2}'
	@echo ""
	
	@echo "$(COLOR_ACCENT)$(ICON_SPARKLES) Pro Tips:$(COLOR_RESET)"
	@echo "  • Use $(COLOR_BOLD)'make help-<category>'$(COLOR_RESET) for detailed help (e.g., make help-docker)"
	@echo "  • Use $(COLOR_BOLD)'make quests'$(COLOR_RESET) to see available achievement quests"
	@echo "  • Use $(COLOR_BOLD)'make status'$(COLOR_RESET) to check system health and your progress"
	@echo "  • Use $(COLOR_BOLD)'make quick-start'$(COLOR_RESET) for guided setup experience"
	@echo ""

.PHONY: help-dev
help-dev: ## 💻 Detailed help for development commands
	$(call print_header,💻 Development Commands - Detailed Guide)
	@echo "$(COLOR_PRIMARY)Master the development workflow and earn achievements!$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_BOLD)Basic Development Cycle:$(COLOR_RESET)"
	@echo "  1. $(COLOR_SUCCESS)make init-dev$(COLOR_RESET)     - Set up development environment"
	@echo "  2. $(COLOR_SUCCESS)make deps$(COLOR_RESET)         - Install all dependencies" 
	@echo "  3. $(COLOR_SUCCESS)make lint$(COLOR_RESET)         - Check code quality"
	@echo "  4. $(COLOR_SUCCESS)make test$(COLOR_RESET)         - Run test suite"
	@echo "  5. $(COLOR_SUCCESS)make build$(COLOR_RESET)        - Build all services"
	@echo ""
	@echo "$(COLOR_ACHIEVEMENT)$(ICON_ACHIEVEMENT) Achievements available:$(COLOR_RESET)"
	@echo "  • First successful build: +150 XP"
	@echo "  • Clean code streak (5x): +200 XP"  
	@echo "  • Test coverage >90%: +300 XP"
	@echo ""
	@echo "$(COLOR_QUEST)$(ICON_TARGET) Try the 'Getting Started Quest' for +500 XP!$(COLOR_RESET)"

.PHONY: help-docker  
help-docker: ## 🐳 Detailed help for Docker operations
	$(call print_header,🐳 Docker Operations - Detailed Guide)
	@echo "$(COLOR_PRIMARY)Master containerization and earn the Container Expert badge!$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_BOLD)Development Environment:$(COLOR_RESET)"
	@echo "  $(COLOR_SUCCESS)make dev$(COLOR_RESET)             - Start lightweight dev environment"
	@echo "  $(COLOR_SUCCESS)make dev-logs$(COLOR_RESET)        - Follow development logs"
	@echo "  $(COLOR_SUCCESS)make dev-down$(COLOR_RESET)        - Stop development environment"
	@echo ""
	@echo "$(COLOR_BOLD)Production Environment:$(COLOR_RESET)"
	@echo "  $(COLOR_SUCCESS)make docker-up$(COLOR_RESET)       - Start full production stack"
	@echo "  $(COLOR_SUCCESS)make docker-logs$(COLOR_RESET)     - View all container logs"
	@echo "  $(COLOR_SUCCESS)make docker-health$(COLOR_RESET)   - Check container health"
	@echo "  $(COLOR_SUCCESS)make docker-down$(COLOR_RESET)     - Stop production stack"
	@echo ""
	@echo "$(COLOR_BOLD)Utilities:$(COLOR_RESET)"
	@echo "  $(COLOR_SUCCESS)make docker-shell SERVICE=api$(COLOR_RESET) - Open shell in container"
	@echo "  $(COLOR_SUCCESS)make docker-clean$(COLOR_RESET)    - Clean up all Docker resources"
	@echo ""
	@echo "$(COLOR_ACHIEVEMENT)$(ICON_ACHIEVEMENT) Container Achievements:$(COLOR_RESET)"
	@echo "  • Docker Ninja: Complete docker operations quest (+250 XP)"
	@echo "  • Container Expert Badge: Master all Docker workflows"

.PHONY: help-security
help-security: ## 🛡️ Detailed help for security operations  
	$(call print_header,🛡️ Security Operations - Detailed Guide)
	@echo "$(COLOR_PRIMARY)Secure your applications and earn the Security Champion badge!$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_BOLD)Security Scanning:$(COLOR_RESET)"
	@echo "  $(COLOR_SUCCESS)make scan$(COLOR_RESET)            - Run vulnerability scans with Trivy/Grype"
	@echo "  $(COLOR_SUCCESS)make sbom$(COLOR_RESET)            - Generate Software Bill of Materials"
	@echo "  $(COLOR_SUCCESS)make verify-admission$(COLOR_RESET) - Test admission control policies"
	@echo ""  
	@echo "$(COLOR_BOLD)Image Security:$(COLOR_RESET)"
	@echo "  $(COLOR_SUCCESS)make sign IMAGE=myapp:v1$(COLOR_RESET) - Sign container images with Cosign"
	@echo ""
	@echo "$(COLOR_WARNING)$(ICON_WARNING) Security Best Practices:$(COLOR_RESET)"
	@echo "  • Always scan images before deployment"
	@echo "  • Generate SBOM for compliance requirements"
	@echo "  • Sign critical production images"
	@echo "  • Test admission policies in CI/CD"
	@echo ""
	@echo "$(COLOR_ACHIEVEMENT)$(ICON_ACHIEVEMENT) Security Champion Quest: +600 XP$(COLOR_RESET)"

.PHONY: quick-start
quick-start: ## 🚀 Interactive quick start guide with gamification
	$(call print_header,🚀 Quick Start Guide - Gamified Setup Experience)
	@echo "$(COLOR_PRIMARY)Welcome! Let's get you up and running with achievements along the way!$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_QUEST)$(ICON_TARGET) Starting 'Getting Started Quest' (+500 XP potential)$(COLOR_RESET)"
	@echo ""
	
	$(call print_section,Step 1: Environment Setup)
	@echo "$(COLOR_INFO)Running: make init-dev$(COLOR_RESET)"
	@$(MAKE) init-dev
	$(call unlock_achievement,first_init,"🎬 First Steps","Completed initial setup",100)
	@echo ""
	
	$(call print_section,Step 2: Dependencies)  
	@echo "$(COLOR_INFO)Running: make deps$(COLOR_RESET)"
	@$(MAKE) deps
	$(call unlock_achievement,deps_master,"📦 Dependency Master","Successfully installed all dependencies",125)
	@echo ""
	
	$(call print_section,Step 3: Code Quality Check)
	@echo "$(COLOR_INFO)Running: make lint$(COLOR_RESET)"
	@$(MAKE) lint
	$(call unlock_achievement,clean_code,"✨ Clean Coder","Passed all linting checks",150)
	@echo ""
	
	$(call print_section,Step 4: Test Suite)
	@echo "$(COLOR_INFO)Running: make test$(COLOR_RESET)"
	@$(MAKE) test  
	$(call unlock_achievement,test_runner,"🧪 Test Runner","Successfully ran test suite",150)
	@echo ""
	
	@echo "$(COLOR_SUCCESS)$(ICON_SUCCESS) Quick start complete! You're ready to develop!$(COLOR_RESET)"
	$(call unlock_achievement,getting_started,"🏁 Getting Started Champion","Completed the full quick start process",500)
	$(call award_badge,foundation_builder,"🏗️ Foundation Builder","Successfully set up complete development environment")
	@echo ""
	@echo "$(COLOR_QUEST)$(ICON_TARGET) Next quest: Try 'make docker-mastery-quest'$(COLOR_RESET)"

.PHONY: status  
status: ## 📊 System status with gamification dashboard
	$(call show_system_status)
	$(call show_progress_dashboard)
	@echo ""
	$(call print_section,🔧 Tool Status)
	$(call check_tool_status,docker)
	$(call check_tool_status,kubectl) 
	$(call check_tool_status,helm)
	$(call check_tool_status,terraform)
	$(call check_tool_status,jq)
	$(call check_tool_status,trivy)
	$(call check_tool_status,cosign)
	@echo ""

.PHONY: quests
quests: ## 🎯 Show available achievement quests  
	$(call show_available_quests)
	$(call award_xp,25,quest_viewing)

# Context-sensitive help based on project state
.PHONY: help-context
help-context: ## 🤖 Smart contextual help based on current project state
	@echo ""
	$(call print_header,🤖 Smart Context Help)
	@if [ ! -d node_modules ] && [ -f package.json ]; then \
		echo "$(COLOR_WARNING)$(ICON_WARNING) Detected Node.js project without installed dependencies$(COLOR_RESET)"; \
		echo "$(COLOR_INFO)$(ICON_INFO) Suggested next step: make deps$(COLOR_RESET)"; \
	fi
	@if [ ! -f .env ] && [ -f .env.example ]; then \
		echo "$(COLOR_WARNING)$(ICON_WARNING) Missing .env file but .env.example exists$(COLOR_RESET)"; \
		echo "$(COLOR_INFO)$(ICON_INFO) Suggested: Copy .env.example to .env and configure$(COLOR_RESET)"; \
	fi
	@if ! docker ps >/dev/null 2>&1; then \
		echo "$(COLOR_ERROR)$(ICON_ERROR) Docker daemon not running$(COLOR_RESET)"; \
		echo "$(COLOR_INFO)$(ICON_INFO) Start Docker to use containerized workflows$(COLOR_RESET)"; \
	fi
	@echo ""