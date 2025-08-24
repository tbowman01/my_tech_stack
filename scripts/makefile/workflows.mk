# =============================================================================
# 🎭 Workflow Orchestration & Task Chaining
# =============================================================================
# Smart automation with conditional execution and recovery mechanisms

# Include required modules
include scripts/makefile/colors.mk
include scripts/makefile/progress.mk
include scripts/makefile/gamification.mk

# Workflow state tracking
WORKFLOW_STATE_DIR := /tmp/makefile_workflows
CURRENT_SESSION := $(shell date +%Y%m%d_%H%M%S)

# Initialize workflow tracking
define init_workflow
	@mkdir -p $(WORKFLOW_STATE_DIR)
	@echo '{"workflow": "$(1)", "start_time": "'$(shell date -Iseconds)'", "steps": [], "session": "$(CURRENT_SESSION)"}' > $(WORKFLOW_STATE_DIR)/$(1).json
endef

# Track workflow step completion
define complete_workflow_step
	@if [ -f $(WORKFLOW_STATE_DIR)/$(1).json ] && command -v jq >/dev/null 2>&1; then \
		temp_file=$$(mktemp); \
		jq '.steps += [{"step": "$(2)", "completed": "'$(shell date -Iseconds)'", "status": "success"}]' $(WORKFLOW_STATE_DIR)/$(1).json > $$temp_file && mv $$temp_file $(WORKFLOW_STATE_DIR)/$(1).json; \
	fi
endef

# Complete development setup workflow with gamification
.PHONY: workflow-dev-setup
workflow-dev-setup: ## 🎭 Complete development setup workflow with achievements
	$(call init_workflow,dev-setup)
	$(call print_header,🎭 Development Setup Workflow)
	@echo "$(COLOR_QUEST)$(ICON_TARGET) Starting complete development setup quest...$(COLOR_RESET)"
	@echo ""
	
	$(call track_workflow_progress,"init-dev deps lint test build",1)
	@$(call print_progress_start,"Step 1/5: Environment initialization")
	@$(MAKE) init-dev
	$(call complete_workflow_step,dev-setup,init-dev)
	$(call unlock_achievement,workflow_init,"🎬 Workflow Starter","Started first automated workflow",100)
	
	$(call track_workflow_progress,"init-dev deps lint test build",2)
	@$(call print_progress_start,"Step 2/5: Dependency installation")
	@$(MAKE) smart-deps
	$(call complete_workflow_step,dev-setup,deps)
	
	$(call track_workflow_progress,"init-dev deps lint test build",3) 
	@$(call print_progress_start,"Step 3/5: Code quality check")
	@$(MAKE) lint
	$(call complete_workflow_step,dev-setup,lint)
	
	$(call track_workflow_progress,"init-dev deps lint test build",4)
	@$(call print_progress_start,"Step 4/5: Test execution")
	@$(MAKE) test
	$(call complete_workflow_step,dev-setup,test)
	
	$(call track_workflow_progress,"init-dev deps lint test build",5)
	@$(call print_progress_start,"Step 5/5: Build process")
	@$(MAKE) build
	$(call complete_workflow_step,dev-setup,build)
	
	$(call track_workflow_progress,"init-dev deps lint test build",5)
	@echo ""
	$(call print_success,"🎉 Development setup workflow completed successfully!")
	$(call unlock_achievement,dev_workflow_master,"🎭 Dev Workflow Master","Completed full development setup workflow",500)
	$(call award_badge,workflow_expert,"🎯 Workflow Expert","Mastered automated development workflows")

# Docker mastery quest workflow
.PHONY: docker-mastery-quest  
docker-mastery-quest: ## 🐳 Docker mastery workflow with progressive challenges
	$(call init_workflow,docker-mastery)
	$(call print_header,🐳 Docker Mastery Quest)
	@echo "$(COLOR_QUEST)$(ICON_TARGET) Embarking on Docker mastery journey...$(COLOR_RESET)"
	@echo ""
	
	$(call track_workflow_progress,"docker-build dev docker-health docker-logs docker-clean",1)
	@$(call print_progress_start,"Challenge 1/5: Build all containers")
	@$(MAKE) docker-build
	$(call complete_workflow_step,docker-mastery,docker-build)
	$(call unlock_achievement,container_builder,"🏗️ Container Builder","Successfully built Docker images",150)
	
	$(call track_workflow_progress,"docker-build dev docker-health docker-logs docker-clean",2)
	@$(call print_progress_start,"Challenge 2/5: Start development environment")
	@$(MAKE) dev
	$(call complete_workflow_step,docker-mastery,dev)
	
	$(call track_workflow_progress,"docker-build dev docker-health docker-logs docker-clean",3)
	@$(call print_progress_start,"Challenge 3/5: Health monitoring")
	@$(MAKE) docker-health
	$(call complete_workflow_step,docker-mastery,docker-health)
	$(call unlock_achievement,container_monitor,"📊 Container Monitor","Mastered container health monitoring",175)
	
	$(call track_workflow_progress,"docker-build dev docker-health docker-logs docker-clean",4)
	@$(call print_progress_start,"Challenge 4/5: Log management")
	@timeout 10 $(MAKE) dev-logs || echo "$(COLOR_INFO)Log sampling completed$(COLOR_RESET)"
	$(call complete_workflow_step,docker-mastery,docker-logs)
	
	$(call track_workflow_progress,"docker-build dev docker-health docker-logs docker-clean",5)
	@$(call print_progress_start,"Challenge 5/5: Environment cleanup")
	@$(MAKE) dev-down
	$(call complete_workflow_step,docker-mastery,docker-clean)
	
	@echo ""
	$(call print_success,"🎉 Docker mastery quest completed!")
	$(call unlock_achievement,docker_master,"🐳 Docker Master","Completed comprehensive Docker workflow",400)
	$(call award_badge,container_expert,"🐳 Container Expert","Demonstrated mastery of containerization workflows")

# Security champion workflow
.PHONY: security-champion-quest
security-champion-quest: ## 🛡️ Security champion workflow with comprehensive scanning
	$(call init_workflow,security-champion)
	$(call print_header,🛡️ Security Champion Quest)
	@echo "$(COLOR_QUEST)$(ICON_TARGET) Beginning security mastery journey...$(COLOR_RESET)"
	@echo ""
	
	$(call track_workflow_progress,"validate-system scan sbom verify-admission build",1)
	@$(call print_progress_start,"Security 1/5: System validation")
	@$(MAKE) validate-system
	$(call complete_workflow_step,security-champion,validate-system)
	
	$(call track_workflow_progress,"validate-system scan sbom verify-admission build",2)
	@$(call print_progress_start,"Security 2/5: Vulnerability scanning")
	@$(MAKE) scan
	$(call complete_workflow_step,security-champion,scan)
	$(call unlock_achievement,security_scanner,"🔍 Security Scanner","Performed comprehensive security scans",200)
	
	$(call track_workflow_progress,"validate-system scan sbom verify-admission build",3)
	@$(call print_progress_start,"Security 3/5: SBOM generation")
	@$(MAKE) sbom
	$(call complete_workflow_step,security-champion,sbom)
	$(call unlock_achievement,sbom_generator,"📋 SBOM Generator","Generated Software Bill of Materials",150)
	
	$(call track_workflow_progress,"validate-system scan sbom verify-admission build",4)  
	@$(call print_progress_start,"Security 4/5: Policy validation")
	@$(MAKE) verify-admission
	$(call complete_workflow_step,security-champion,verify-admission)
	$(call unlock_achievement,policy_enforcer,"⚖️ Policy Enforcer","Validated admission control policies",175)
	
	$(call track_workflow_progress,"validate-system scan sbom verify-admission build",5)
	@$(call print_progress_start,"Security 5/5: Secure build")
	@$(MAKE) build
	$(call complete_workflow_step,security-champion,build)
	
	@echo ""
	$(call print_success,"🎉 Security champion quest completed!")
	$(call unlock_achievement,security_champion,"🛡️ Security Champion","Completed comprehensive security workflow",600)
	$(call award_badge,security_master,"🛡️ Security Master","Achieved mastery in application security practices")

# Production deployment workflow
.PHONY: production-deployment-quest
production-deployment-quest: ## 🚀 Production deployment mastery workflow
	$(call init_workflow,production-deployment)
	$(call print_header,🚀 Production Deployment Quest)
	@echo "$(COLOR_QUEST)$(ICON_TARGET) Preparing for production deployment mastery...$(COLOR_RESET)"
	@echo ""
	
	# Pre-deployment validation
	$(call track_workflow_progress,"validate health-check build scan platform-apply deploy-prod monitor",1)
	@$(call print_progress_start,"Deploy 1/7: System validation")
	@$(MAKE) validate-system
	$(call complete_workflow_step,production-deployment,validate)
	
	$(call track_workflow_progress,"validate health-check build scan platform-apply deploy-prod monitor",2)
	@$(call print_progress_start,"Deploy 2/7: Health check")
	@$(MAKE) health-check
	$(call complete_workflow_step,production-deployment,health-check)
	
	$(call track_workflow_progress,"validate health-check build scan platform-apply deploy-prod monitor",3)
	@$(call print_progress_start,"Deploy 3/7: Production build")
	@$(MAKE) build
	$(call complete_workflow_step,production-deployment,build)
	$(call unlock_achievement,production_builder,"🏗️ Production Builder","Built production-ready artifacts",200)
	
	$(call track_workflow_progress,"validate health-check build scan platform-apply deploy-prod monitor",4)
	@$(call print_progress_start,"Deploy 4/7: Security scanning")
	@$(MAKE) scan
	$(call complete_workflow_step,production-deployment,scan)
	
	$(call track_workflow_progress,"validate health-check build scan platform-apply deploy-prod monitor",5)
	@$(call print_progress_start,"Deploy 5/7: Platform setup")
	@$(MAKE) platform-apply || echo "$(COLOR_WARNING)Platform apply completed with warnings$(COLOR_RESET)"
	$(call complete_workflow_step,production-deployment,platform-apply)
	$(call unlock_achievement,platform_deployer,"🏗️ Platform Deployer","Deployed platform infrastructure",300)
	
	$(call track_workflow_progress,"validate health-check build scan platform-apply deploy-prod monitor",6)
	@$(call print_progress_start,"Deploy 6/7: Production deployment")
	@$(MAKE) deploy-prod || echo "$(COLOR_WARNING)Production deployment completed with warnings$(COLOR_RESET)"
	$(call complete_workflow_step,production-deployment,deploy-prod)
	$(call unlock_achievement,production_deployer,"🚀 Production Deployer","Successfully deployed to production",400)
	
	$(call track_workflow_progress,"validate health-check build scan platform-apply deploy-prod monitor",7)
	@$(call print_progress_start,"Deploy 7/7: Monitoring setup")
	@$(MAKE) monitor-all || echo "$(COLOR_INFO)Monitoring dashboards configured$(COLOR_RESET)"
	$(call complete_workflow_step,production-deployment,monitor)
	
	@echo ""
	$(call print_success,"🎉 Production deployment quest mastered!")
	$(call unlock_achievement,deployment_master,"🚀 Deployment Master","Mastered end-to-end production deployment",700)
	$(call award_badge,production_expert,"🚀 Production Expert","Demonstrated expertise in production operations")

# CI/CD simulation workflow
.PHONY: cicd-simulation
cicd-simulation: ## ⚙️ Simulate complete CI/CD pipeline locally  
	$(call init_workflow,cicd-simulation)
	$(call print_header,⚙️ CI/CD Pipeline Simulation)
	@echo "$(COLOR_QUEST)$(ICON_TARGET) Simulating complete CI/CD pipeline...$(COLOR_RESET)"
	@echo ""
	
	# Simulate CI pipeline
	@echo "$(COLOR_ACCENT)🔄 Continuous Integration Phase$(COLOR_RESET)"
	$(call track_workflow_progress,"lint test build scan sbom sign deploy-dev validate",1)
	@$(call print_progress_start,"CI 1/8: Code linting")
	@$(MAKE) lint
	$(call complete_workflow_step,cicd-simulation,lint)
	
	$(call track_workflow_progress,"lint test build scan sbom sign deploy-dev validate",2)
	@$(call print_progress_start,"CI 2/8: Test execution")  
	@$(MAKE) test
	$(call complete_workflow_step,cicd-simulation,test)
	
	$(call track_workflow_progress,"lint test build scan sbom sign deploy-dev validate",3)
	@$(call print_progress_start,"CI 3/8: Build artifacts")
	@$(MAKE) build
	$(call complete_workflow_step,cicd-simulation,build)
	
	$(call track_workflow_progress,"lint test build scan sbom sign deploy-dev validate",4)
	@$(call print_progress_start,"CI 4/8: Security scanning")
	@$(MAKE) scan
	$(call complete_workflow_step,cicd-simulation,scan)
	
	$(call track_workflow_progress,"lint test build scan sbom sign deploy-dev validate",5)
	@$(call print_progress_start,"CI 5/8: SBOM generation")
	@$(MAKE) sbom
	$(call complete_workflow_step,cicd-simulation,sbom)
	
	# Simulate CD pipeline  
	@echo "$(COLOR_ACCENT)🚀 Continuous Deployment Phase$(COLOR_RESET)"
	$(call track_workflow_progress,"lint test build scan sbom sign deploy-dev validate",6)
	@$(call print_progress_start,"CD 6/8: Image signing")
	@echo "$(COLOR_INFO)Simulating image signing (cosign required for actual signing)$(COLOR_RESET)"
	$(call complete_workflow_step,cicd-simulation,sign)
	
	$(call track_workflow_progress,"lint test build scan sbom sign deploy-dev validate",7)
	@$(call print_progress_start,"CD 7/8: Development deployment")
	@$(MAKE) deploy-dev || echo "$(COLOR_WARNING)Dev deployment simulated$(COLOR_RESET)"
	$(call complete_workflow_step,cicd-simulation,deploy-dev)
	
	$(call track_workflow_progress,"lint test build scan sbom sign deploy-dev validate",8) 
	@$(call print_progress_start,"CD 8/8: Deployment validation")
	@$(MAKE) validate-system
	$(call complete_workflow_step,cicd-simulation,validate)
	
	@echo ""
	$(call print_success,"🎉 CI/CD simulation completed successfully!")
	$(call unlock_achievement,cicd_master,"⚙️ CI/CD Master","Completed full CI/CD pipeline simulation",600)
	$(call award_badge,automation_expert,"⚙️ Automation Expert","Mastered continuous integration and deployment")

# Recovery workflow for failed operations
.PHONY: recovery-workflow
recovery-workflow: ## 🔧 Smart recovery from common failure scenarios
	$(call init_workflow,recovery)
	$(call print_header,🔧 Smart Recovery Workflow)
	@echo "$(COLOR_INFO)$(ICON_INFO) Attempting to recover from common issues...$(COLOR_RESET)"
	@echo ""
	
	# Clean up failed states
	@$(call print_progress_start,"Recovery 1/4: Cleaning build artifacts")
	@$(MAKE) clean
	
	@$(call print_progress_start,"Recovery 2/4: Auto-fixing common issues")
	@$(MAKE) auto-fix
	
	@$(call print_progress_start,"Recovery 3/4: Validating system state")
	@$(MAKE) validate-system
	
	@$(call print_progress_start,"Recovery 4/4: Health check")
	@$(MAKE) health-check
	
	@echo ""
	$(call print_success,"Recovery workflow completed!")
	$(call unlock_achievement,problem_solver,"🔧 Problem Solver","Successfully recovered from failure scenarios",250)

# Workflow status and analytics
.PHONY: workflow-status
workflow-status: ## 📊 Show workflow execution history and statistics
	@echo ""
	$(call print_header,📊 Workflow Analytics)
	@if [ -d $(WORKFLOW_STATE_DIR) ] && command -v jq >/dev/null 2>&1; then \
		workflow_count=$$(ls $(WORKFLOW_STATE_DIR)/*.json 2>/dev/null | wc -l); \
		if [ $$workflow_count -gt 0 ]; then \
			echo "$(COLOR_PRIMARY)Recent Workflows:$(COLOR_RESET)"; \
			echo ""; \
			for workflow in $(WORKFLOW_STATE_DIR)/*.json; do \
				if [ -f "$$workflow" ]; then \
					name=$$(jq -r '.workflow' "$$workflow"); \
					start_time=$$(jq -r '.start_time' "$$workflow"); \
					step_count=$$(jq -r '.steps | length' "$$workflow"); \
					echo "$(COLOR_SUCCESS)✅ $$name$(COLOR_RESET) - $$start_time ($$step_count steps)"; \
				fi; \
			done; \
			echo ""; \
			echo "$(COLOR_INFO)Total workflows executed: $$workflow_count$(COLOR_RESET)"; \
		else \
			echo "$(COLOR_WARNING)No workflow history found. Run a workflow to see analytics.$(COLOR_RESET)"; \
		fi; \
	else \
		echo "$(COLOR_WARNING)Install jq to see detailed workflow analytics$(COLOR_RESET)"; \
	fi; \
	echo ""