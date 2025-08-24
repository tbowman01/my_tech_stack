# =============================================================================
# 📊 Progress Tracking & Visual Indicators
# =============================================================================
# Smart progress bars and status indicators for enhanced UX

# Include colors
include scripts/makefile/colors.mk

# Progress bar generation function
define progress_bar
	$(eval current := $(1))
	$(eval total := $(2))
	$(eval width := $(or $(3),40))
	$(eval percent := $(shell echo "scale=0; $(current) * 100 / $(total)" | bc -l 2>/dev/null || echo "0"))
	$(eval filled := $(shell echo "scale=0; $(current) * $(width) / $(total)" | bc -l 2>/dev/null || echo "0"))
	$(eval empty := $(shell echo "$(width) - $(filled)" | bc -l 2>/dev/null || echo "$(width)"))
	@printf "$(COLOR_PROGRESS)[$(COLOR_RESET)"
	@printf "%*s" $(filled) | tr ' ' '$(PROGRESS_FULL)'
	@printf "$(COLOR_DIM)%*s$(COLOR_RESET)" $(empty) | tr ' ' '$(PROGRESS_EMPTY)'
	@printf "$(COLOR_PROGRESS)] $(percent)%% ($(current)/$(total))$(COLOR_RESET)\n"
endef

# Animated spinner for long-running tasks
define show_spinner
	@echo "$(COLOR_PROGRESS)$(1)$(COLOR_RESET)"
	@for i in 1 2 3 4 5; do \
		printf "$(COLOR_ACCENT)⠋$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
		printf "$(COLOR_ACCENT)⠙$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
		printf "$(COLOR_ACCENT)⠹$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
		printf "$(COLOR_ACCENT)⠸$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
		printf "$(COLOR_ACCENT)⠼$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
		printf "$(COLOR_ACCENT)⠴$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
		printf "$(COLOR_ACCENT)⠦$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
		printf "$(COLOR_ACCENT)⠧$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
		printf "$(COLOR_ACCENT)⠇$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
		printf "$(COLOR_ACCENT)⠏$(COLOR_RESET) Processing...\\r"; sleep 0.1; \
	done
	@echo "$(COLOR_SUCCESS)$(ICON_SUCCESS) Complete!$(COLOR_RESET)    "
endef

# Status indicator for tools/dependencies
define check_tool_status
	@if command -v $(1) >/dev/null 2>&1; then \
		echo "$(COLOR_SUCCESS)🟢 $(1)$(COLOR_RESET) - Ready"; \
	else \
		echo "$(COLOR_ERROR)🔴 $(1)$(COLOR_RESET) - Missing"; \
	fi
endef

# Multi-step progress tracker
define track_workflow_progress
	$(eval steps := $(words $(1)))
	$(eval current_step := $(2))
	@echo ""
	@echo "$(COLOR_BOLD)$(COLOR_PRIMARY)📋 Workflow Progress$(COLOR_RESET)"
	@echo "$(COLOR_DIM)═══════════════════════════════════════$(COLOR_RESET)"
	$(call progress_bar,$(current_step),$(steps),30)
	@echo ""
	@for i in $(shell seq 1 $(steps)); do \
		step=$$(echo "$(1)" | cut -d' ' -f$$i); \
		if [ $$i -lt $(current_step) ]; then \
			echo "$(COLOR_SUCCESS)✅ $$step$(COLOR_RESET)"; \
		elif [ $$i -eq $(current_step) ]; then \
			echo "$(COLOR_WARNING)⚡ $$step$(COLOR_RESET) $(COLOR_DIM)(current)$(COLOR_RESET)"; \
		else \
			echo "$(COLOR_DIM)⏸️  $$step$(COLOR_RESET) $(COLOR_DIM)(pending)$(COLOR_RESET)"; \
		fi; \
	done
	@echo ""
endef

# Task timing and performance tracking
define time_task
	@start_time=$$(date +%s); \
	$(1); \
	end_time=$$(date +%s); \
	duration=$$((end_time - start_time)); \
	if [ $$duration -lt 10 ]; then \
		echo "$(COLOR_SUCCESS)$(ICON_FIRE) Lightning fast! Completed in $${duration}s$(COLOR_RESET)"; \
	elif [ $$duration -lt 30 ]; then \
		echo "$(COLOR_SUCCESS)$(ICON_SUCCESS) Good performance! Completed in $${duration}s$(COLOR_RESET)"; \
	elif [ $$duration -lt 60 ]; then \
		echo "$(COLOR_WARNING)$(ICON_WARNING) Moderate performance. Completed in $${duration}s$(COLOR_RESET)"; \
	else \
		echo "$(COLOR_ERROR)$(ICON_ERROR) Slow execution. Completed in $${duration}s - Consider optimization$(COLOR_RESET)"; \
	fi
endef

# Resource usage indicator
define show_system_status
	@echo ""
	@echo "$(COLOR_BOLD)$(COLOR_PRIMARY)💻 System Status$(COLOR_RESET)"
	@echo "$(COLOR_DIM)═══════════════════════════════════════$(COLOR_RESET)"
	@if command -v free >/dev/null 2>&1; then \
		memory_usage=$$(free | awk 'NR==2{printf "%.0f", $$3*100/$$2}'); \
		if [ $$memory_usage -lt 60 ]; then \
			echo "$(COLOR_SUCCESS)🟢 Memory: $${memory_usage}%$(COLOR_RESET) - Excellent"; \
		elif [ $$memory_usage -lt 80 ]; then \
			echo "$(COLOR_WARNING)🟡 Memory: $${memory_usage}%$(COLOR_RESET) - Good"; \
		else \
			echo "$(COLOR_ERROR)🔴 Memory: $${memory_usage}%$(COLOR_RESET) - High usage"; \
		fi; \
	fi
	@if command -v df >/dev/null 2>&1; then \
		disk_usage=$$(df . | awk 'NR==2{print $$5}' | sed 's/%//'); \
		if [ $$disk_usage -lt 70 ]; then \
			echo "$(COLOR_SUCCESS)🟢 Disk: $${disk_usage}%$(COLOR_RESET) - Plenty of space"; \
		elif [ $$disk_usage -lt 90 ]; then \
			echo "$(COLOR_WARNING)🟡 Disk: $${disk_usage}%$(COLOR_RESET) - Monitor usage"; \
		else \
			echo "$(COLOR_ERROR)🔴 Disk: $${disk_usage}%$(COLOR_RESET) - Low space!"; \
		fi; \
	fi
	@echo ""
endef