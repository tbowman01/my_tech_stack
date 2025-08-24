# =============================================================================
# 🎨 Color & Visual Theme System
# =============================================================================
# Enhanced visual system for improved developer experience

# Color Definitions
COLOR_RESET := \033[0m
COLOR_BOLD := \033[1m
COLOR_DIM := \033[2m

# Primary Colors
COLOR_PRIMARY := \033[0;34m    # Blue - Information
COLOR_SUCCESS := \033[0;32m    # Green - Success  
COLOR_WARNING := \033[0;33m    # Yellow - Warnings
COLOR_ERROR := \033[0;31m      # Red - Errors
COLOR_ACCENT := \033[0;35m     # Magenta - Highlights

# Semantic Colors
COLOR_QUEST := \033[0;36m      # Cyan - Quests/Tasks
COLOR_ACHIEVEMENT := \033[1;33m # Bold Yellow - Achievements
COLOR_PROGRESS := \033[0;92m   # Light Green - Progress
COLOR_XP := \033[1;35m         # Bold Magenta - XP
COLOR_BADGE := \033[1;36m      # Bold Cyan - Badges
COLOR_LEVEL := \033[1;34m      # Bold Blue - Level

# Background Colors
BG_SUCCESS := \033[42m
BG_WARNING := \033[43m
BG_ERROR := \033[41m
BG_INFO := \033[44m

# Emoji & Icon Definitions
ICON_SUCCESS := ✅
ICON_ERROR := ❌
ICON_WARNING := ⚠️
ICON_INFO := ℹ️
ICON_QUEST := 🎯
ICON_ACHIEVEMENT := 🏆
ICON_XP := ⭐
ICON_PROGRESS := 📊
ICON_ROCKET := 🚀
ICON_GEAR := ⚙️
ICON_SHIELD := 🛡️
ICON_FIRE := 🔥
ICON_SPARKLES := ✨
ICON_TARGET := 🎯
ICON_CROWN := 👑
ICON_MEDAL := 🥇

# Category Icons
ICON_DEV := 💻
ICON_DOCKER := 🐳
ICON_INFRA := 🏗️
ICON_TEST := 🧪
ICON_MONITOR := 📊
ICON_SECURITY := 🔒
ICON_DEPLOY := 🚀
ICON_DOCS := 📚

# Progress Bar Characters
PROGRESS_FULL := █
PROGRESS_EMPTY := ░
PROGRESS_PARTIAL := ▓

# Visual Functions
define print_header
	@echo ""
	@echo "$(COLOR_BOLD)$(COLOR_PRIMARY)════════════════════════════════════════════════════════$(COLOR_RESET)"
	@echo "$(COLOR_BOLD)$(COLOR_PRIMARY)  $(1)$(COLOR_RESET)"
	@echo "$(COLOR_BOLD)$(COLOR_PRIMARY)════════════════════════════════════════════════════════$(COLOR_RESET)"
	@echo ""
endef

define print_section
	@echo ""
	@echo "$(COLOR_BOLD)$(COLOR_ACCENT)┌─ $(1) ─$(COLOR_RESET)"
	@echo ""
endef

define print_success
	@echo "$(COLOR_SUCCESS)$(ICON_SUCCESS) $(1)$(COLOR_RESET)"
endef

define print_error
	@echo "$(COLOR_ERROR)$(ICON_ERROR) $(1)$(COLOR_RESET)"
endef

define print_warning
	@echo "$(COLOR_WARNING)$(ICON_WARNING) $(1)$(COLOR_RESET)"
endef

define print_info
	@echo "$(COLOR_PRIMARY)$(ICON_INFO) $(1)$(COLOR_RESET)"
endef

define print_achievement
	@echo ""
	@echo "$(COLOR_ACHIEVEMENT)$(BG_WARNING) $(ICON_ACHIEVEMENT) ACHIEVEMENT UNLOCKED! $(COLOR_RESET)"
	@echo "$(COLOR_ACHIEVEMENT)$(ICON_SPARKLES) $(1) $(ICON_SPARKLES)$(COLOR_RESET)"
	@echo "$(COLOR_XP)$(ICON_XP) +$(2) XP$(COLOR_RESET)"
	@echo ""
endef

define print_quest
	@echo "$(COLOR_QUEST)$(ICON_QUEST) $(1)$(COLOR_RESET)"
endef

define print_progress_start
	@echo "$(COLOR_PROGRESS)$(ICON_PROGRESS) $(1)...$(COLOR_RESET)"
endef

define print_level_up
	@echo ""
	@echo "$(COLOR_LEVEL)$(BG_INFO) $(ICON_CROWN) LEVEL UP! $(COLOR_RESET)"
	@echo "$(COLOR_LEVEL)$(ICON_SPARKLES) You are now Level $(1)! $(ICON_SPARKLES)$(COLOR_RESET)"
	@echo ""
endef