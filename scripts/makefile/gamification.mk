# =============================================================================
# 🎮 Gamification System - Achievements, XP, and Progress Tracking
# =============================================================================
# Engaging developer experience through game mechanics

# Include required modules
include scripts/makefile/colors.mk
include scripts/makefile/progress.mk

# Gamification storage
PROGRESS_DIR := $(HOME)/.makefile_progress
ACHIEVEMENTS_FILE := $(PROGRESS_DIR)/achievements.json
XP_FILE := $(PROGRESS_DIR)/xp.json
SESSION_FILE := /tmp/makefile_session_$(shell date +%s).json

# Initialize gamification system
define init_gamification
	@mkdir -p $(PROGRESS_DIR)
	@if [ ! -f $(ACHIEVEMENTS_FILE) ]; then \
		echo '{"achievements": [], "total_xp": 0, "level": 1, "badges": []}' > $(ACHIEVEMENTS_FILE); \
	fi
	@if [ ! -f $(XP_FILE) ]; then \
		echo '{"xp": 0, "level": 1, "streak": 0, "last_activity": ""}' > $(XP_FILE); \
	fi
endef

# XP calculation with multipliers
define award_xp
	$(call init_gamification)
	$(eval base_xp := $(1))
	$(eval task_type := $(or $(2),"standard"))
	$(eval streak_bonus := $(shell [ -f $(XP_FILE) ] && jq -r '.streak // 0' $(XP_FILE) 2>/dev/null || echo "0"))
	$(eval multiplier := $(shell echo "1 + $(streak_bonus) * 0.1" | bc -l 2>/dev/null || echo "1"))
	$(eval total_xp := $(shell echo "$(base_xp) * $(multiplier)" | bc -l 2>/dev/null || echo "$(base_xp)"))
	$(eval current_xp := $(shell [ -f $(XP_FILE) ] && jq -r '.xp // 0' $(XP_FILE) 2>/dev/null || echo "0"))
	$(eval new_xp := $(shell echo "$(current_xp) + $(total_xp)" | bc -l 2>/dev/null || echo "$(base_xp)"))
	$(eval new_level := $(shell echo "scale=0; sqrt($(new_xp) / 100) + 1" | bc -l 2>/dev/null || echo "1"))
	$(eval old_level := $(shell [ -f $(XP_FILE) ] && jq -r '.level // 1' $(XP_FILE) 2>/dev/null || echo "1"))
	@if command -v jq >/dev/null 2>&1; then \
		echo '{"xp": $(new_xp), "level": $(new_level), "streak": $(streak_bonus), "last_activity": "'$(shell date -Iseconds)'"}' > $(XP_FILE); \
		if [ $(new_level) -gt $(old_level) ]; then \
			$(call print_level_up,$(new_level)); \
		fi; \
		echo "$(COLOR_XP)$(ICON_XP) +$(total_xp) XP$(COLOR_RESET) $(COLOR_DIM)(Total: $(new_xp) XP, Level $(new_level))$(COLOR_RESET)"; \
	else \
		echo "$(COLOR_XP)$(ICON_XP) +$(total_xp) XP$(COLOR_RESET) $(COLOR_WARNING)(Install jq for full gamification features)$(COLOR_RESET)"; \
	fi
endef

# Achievement system
define unlock_achievement
	$(call init_gamification)
	$(eval achievement_id := $(1))
	$(eval achievement_name := $(2))
	$(eval achievement_xp := $(or $(3),100))
	@if command -v jq >/dev/null 2>&1; then \
		if ! jq -e '.achievements[] | select(.id == "$(achievement_id)")' $(ACHIEVEMENTS_FILE) >/dev/null 2>&1; then \
			$(call print_achievement,$(achievement_name),$(achievement_xp)); \
			temp_file=$$(mktemp); \
			jq '.achievements += [{"id": "$(achievement_id)", "name": "$(achievement_name)", "xp": $(achievement_xp), "unlocked": "'$(shell date -Iseconds)'"}]' $(ACHIEVEMENTS_FILE) > $$temp_file && mv $$temp_file $(ACHIEVEMENTS_FILE); \
			$(call award_xp,$(achievement_xp),achievement); \
		fi; \
	else \
		echo "$(COLOR_WARNING)$(ICON_WARNING) Achievement unlocked: $(achievement_name) (+$(achievement_xp) XP)$(COLOR_RESET)"; \
	fi
endef

# Badge system for specializations
define award_badge
	$(call init_gamification)
	$(eval badge_id := $(1))
	$(eval badge_name := $(2))
	$(eval badge_description := $(3))
	@if command -v jq >/dev/null 2>&1; then \
		if ! jq -e '.badges[] | select(.id == "$(badge_id)")' $(ACHIEVEMENTS_FILE) >/dev/null 2>&1; then \
			echo ""; \
			echo "$(COLOR_BADGE)$(ICON_MEDAL) BADGE EARNED!$(COLOR_RESET)"; \
			echo "$(COLOR_BADGE)$(ICON_SPARKLES) $(badge_name)$(COLOR_RESET)"; \
			echo "$(COLOR_DIM)$(badge_description)$(COLOR_RESET)"; \
			echo ""; \
			temp_file=$$(mktemp); \
			jq '.badges += [{"id": "$(badge_id)", "name": "$(badge_name)", "description": "$(badge_description)", "earned": "'$(shell date -Iseconds)'"}]' $(ACHIEVEMENTS_FILE) > $$temp_file && mv $$temp_file $(ACHIEVEMENTS_FILE); \
		fi; \
	fi
endef

# Progress dashboard
define show_progress_dashboard
	@echo ""
	$(call print_header,🎮 Development Progress Dashboard)
	@if command -v jq >/dev/null 2>&1 && [ -f $(XP_FILE) ]; then \
		current_xp=$$(jq -r '.xp // 0' $(XP_FILE)); \
		current_level=$$(jq -r '.level // 1' $(XP_FILE)); \
		next_level_xp=$$((current_level * current_level * 100)); \
		level_progress_xp=$$((current_xp - (current_level - 1) * (current_level - 1) * 100)); \
		level_total_xp=$$((next_level_xp - (current_level - 1) * (current_level - 1) * 100)); \
		echo "$(COLOR_LEVEL)$(ICON_CROWN) Level: $$current_level$(COLOR_RESET)"; \
		echo "$(COLOR_XP)$(ICON_XP) Total XP: $$current_xp$(COLOR_RESET)"; \
		echo ""; \
		echo "$(COLOR_PROGRESS)Progress to Level $$((current_level + 1)):$(COLOR_RESET)"; \
		$(call progress_bar,$$level_progress_xp,$$level_total_xp,40); \
		echo ""; \
		achievement_count=$$(jq -r '.achievements | length' $(ACHIEVEMENTS_FILE) 2>/dev/null || echo "0"); \
		badge_count=$$(jq -r '.badges | length' $(ACHIEVEMENTS_FILE) 2>/dev/null || echo "0"); \
		echo "$(COLOR_ACHIEVEMENT)$(ICON_ACHIEVEMENT) Achievements: $$achievement_count$(COLOR_RESET)"; \
		echo "$(COLOR_BADGE)$(ICON_MEDAL) Badges: $$badge_count$(COLOR_RESET)"; \
	else \
		echo "$(COLOR_WARNING)$(ICON_WARNING) Install jq to see your full progress$(COLOR_RESET)"; \
	fi
	@echo ""
endef

# Achievement definitions
define setup_achievements
	# Development achievements
	$(call unlock_achievement,first_build,"🚀 First Steps","First successful build",150)
	$(call unlock_achievement,clean_streak_5,"🧹 Clean Code Streak","5 successful lints in a row",200)
	$(call unlock_achievement,test_master,"🧪 Test Master","Achieve 90% test coverage",300)
	$(call unlock_achievement,docker_ninja,"🐳 Container Ninja","Master Docker operations",250)
	$(call unlock_achievement,infra_wizard,"🏗️ Infrastructure Wizard","Deploy full platform",400)
	$(call unlock_achievement,security_champion,"🛡️ Security Champion","Pass all security scans",350)
	$(call unlock_achievement,speed_demon,"⚡ Speed Demon","Complete build in under 30 seconds",200)
	$(call unlock_achievement,problem_solver,"🔧 Problem Solver","Recover from 5 failed builds",300)
	
	# Badge categories
	$(call award_badge,fullstack_dev,"🎯 Full-Stack Developer","Mastered frontend, backend, and database")
	$(call award_badge,devops_master,"⚙️ DevOps Master","Expert in CI/CD, containers, and infrastructure")
	$(call award_badge,security_expert,"🛡️ Security Expert","Advanced security practices and tooling")
	$(call award_badge,performance_optimizer,"🚀 Performance Optimizer","Consistently optimizes for speed and efficiency")
endef

# Quest system for guided learning
define show_available_quests
	@echo ""
	$(call print_header,🎯 Available Quests)
	@echo "$(COLOR_QUEST)$(ICON_TARGET) 🏁 Getting Started Quest$(COLOR_RESET)"
	@echo "   $(COLOR_DIM)Complete: init-dev → deps → test → build$(COLOR_RESET)"
	@echo "   $(COLOR_XP)Reward: +500 XP + 'Foundation Builder' badge$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_QUEST)$(ICON_TARGET) 🐳 Docker Mastery Quest$(COLOR_RESET)"
	@echo "   $(COLOR_DIM)Complete: docker-build → docker-up → docker-health$(COLOR_RESET)"
	@echo "   $(COLOR_XP)Reward: +400 XP + 'Container Expert' badge$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_QUEST)$(ICON_TARGET) 🛡️ Security Champion Quest$(COLOR_RESET)"
	@echo "   $(COLOR_DIM)Complete: scan → sbom → verify-admission → sign$(COLOR_RESET)"
	@echo "   $(COLOR_XP)Reward: +600 XP + 'Security Master' badge$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_QUEST)$(ICON_TARGET) 🚀 Deployment Hero Quest$(COLOR_RESET)"
	@echo "   $(COLOR_DIM)Complete: platform-apply → deploy-dev → monitor-all$(COLOR_RESET)"
	@echo "   $(COLOR_XP)Reward: +700 XP + 'Deployment Expert' badge$(COLOR_RESET)"
	@echo ""
endef

# Streak tracking and bonus system  
define update_streak
	$(call init_gamification)
	@if command -v jq >/dev/null 2>&1; then \
		last_activity=$$(jq -r '.last_activity // ""' $(XP_FILE)); \
		today=$$(date +%Y-%m-%d); \
		if [ "$$last_activity" != "" ]; then \
			last_date=$$(echo "$$last_activity" | cut -d'T' -f1); \
			if [ "$$last_date" = "$$today" ]; then \
				echo "$(COLOR_SUCCESS)$(ICON_FIRE) Daily streak continues!$(COLOR_RESET)"; \
			else \
				echo "$(COLOR_WARNING)$(ICON_WARNING) Streak reset - new day, new opportunities!$(COLOR_RESET)"; \
			fi; \
		fi; \
	fi
endef