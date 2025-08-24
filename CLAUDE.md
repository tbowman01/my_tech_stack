# 🎮 Claude Code Configuration - SPARC Gamified Development Environment

> **🏆 ACHIEVEMENT UNLOCKED!** You've discovered the SPARC development methodology!

## 🚨 CRITICAL: CONCURRENT EXECUTION & FILE MANAGEMENT

## 🎯 SPARC Mastery Quest Chain

### 🌟 Current Quest: SPARC Development Master
**Objective**: Master the SPARC methodology for enterprise development  
**Reward**: 🏆 **Development Methodology Expert Badge** + 500 XP  
**Progress**: Reading documentation (25% complete)

### 🚀 Quest Checkpoints:
- [ ] **📋 Learn SPARC Principles** (100 XP)
- [ ] **🔧 Master Concurrent Execution** (150 XP)  
- [ ] **🛠️ Practice Agent Coordination** (200 XP)
- [ ] **🎮 Complete Advanced Challenges** (300 XP)

---

**ABSOLUTE RULES** (Achievement Triggers):
1. ⚡ **Concurrency Master**: ALL operations MUST be concurrent/parallel in a single message (+50 XP bonus)
2. 📁 **Organization Expert**: **NEVER save working files to root folder** (+25 XP bonus)
3. 🗂️ **Structure Guardian**: ALWAYS organize files in appropriate subdirectories (+25 XP bonus)
4. 🤖 **Agent Commander**: **USE CLAUDE CODE'S TASK TOOL** for spawning agents (+75 XP bonus)

### ⚡ GOLDEN RULE: "1 MESSAGE = ALL RELATED OPERATIONS"

**MANDATORY PATTERNS:**
- **TodoWrite**: ALWAYS batch ALL todos in ONE call (5-10+ todos minimum)
- **Task tool (Claude Code)**: ALWAYS spawn ALL agents in ONE message with full instructions
- **File operations**: ALWAYS batch ALL reads/writes/edits in ONE message
- **Bash commands**: ALWAYS batch ALL terminal operations in ONE message
- **Memory operations**: ALWAYS batch ALL memory store/retrieve in ONE message

### 🎯 CRITICAL: Claude Code Task Tool for Agent Execution

**Claude Code's Task tool is the PRIMARY way to spawn agents:**
```javascript
// ✅ CORRECT: Use Claude Code's Task tool for parallel agent execution
[Single Message]:
  Task("Research agent", "Analyze requirements and patterns...", "researcher")
  Task("Coder agent", "Implement core features...", "coder")
  Task("Tester agent", "Create comprehensive tests...", "tester")
  Task("Reviewer agent", "Review code quality...", "reviewer")
  Task("Architect agent", "Design system architecture...", "system-architect")
```

**MCP tools are ONLY for coordination setup:**
- `mcp__claude-flow__swarm_init` - Initialize coordination topology
- `mcp__claude-flow__agent_spawn` - Define agent types for coordination
- `mcp__claude-flow__task_orchestrate` - Orchestrate high-level workflows

### 📁 File Organization Rules

**NEVER save to root folder. Use these directories:**
- `/src` - Source code files
- `/tests` - Test files
- `/docs` - Documentation and markdown files
- `/config` - Configuration files
- `/scripts` - Utility scripts
- `/examples` - Example code

## Project Overview

This project uses SPARC (Specification, Pseudocode, Architecture, Refinement, Completion) methodology with Claude-Flow orchestration for systematic Test-Driven Development.

## 🎮 SPARC Gamified Commands

### 🌟 Core Commands (Achievement Unlocks!)
- `npx claude-flow sparc modes` - List available modes [🎯 **Explorer Badge** +50 XP]
- `npx claude-flow sparc run <mode> "<task>"` - Execute specific mode [🎯 **Executor Badge** +100 XP]
- `npx claude-flow sparc tdd "<feature>"` - Run complete TDD workflow [🎯 **TDD Master Badge** +200 XP]
- `npx claude-flow sparc info <mode>` - Get mode details [🎯 **Information Seeker Badge** +25 XP]

### ⚡ Batchtools Commands (Advanced Achievements!)
- `npx claude-flow sparc batch <modes> "<task>"` - Parallel execution [🎯 **Batch Master Badge** +150 XP]
- `npx claude-flow sparc pipeline "<task>"` - Full pipeline processing [🎯 **Pipeline Expert Badge** +200 XP]
- `npx claude-flow sparc concurrent <mode> "<tasks-file>"` - Multi-task processing [🎯 **Concurrency Champion Badge** +250 XP]

### 🔨 Build Commands (Quality Achievements!)
- `npm run build` - Build project [🎯 **Builder Badge** +75 XP]
- `npm run test` - Run tests [🎯 **Testing Hero Badge** +100 XP]
- `npm run lint` - Linting [🎯 **Code Quality Badge** +50 XP]
- `npm run typecheck` - Type checking [🎯 **Type Safety Badge** +75 XP]

## 🎯 SPARC Workflow Quest Chain

### 🌟 Complete All 5 Phases for **SPARC Grandmaster Badge** (1000 XP)!

1. **🔍 Specification Quest** - Requirements analysis (`sparc run spec-pseudocode`) [+150 XP]
2. **💭 Pseudocode Quest** - Algorithm design (`sparc run spec-pseudocode`) [+150 XP]
3. **🏗️ Architecture Quest** - System design (`sparc run architect`) [+200 XP]
4. **⚡ Refinement Quest** - TDD implementation (`sparc tdd`) [+250 XP]
5. **🏆 Completion Quest** - Integration (`sparc run integration`) [+250 XP]

**Bonus**: Complete all phases in under 2 hours for **Speed Demon Badge** (+500 XP)

## Code Style & Best Practices

- **Modular Design**: Files under 500 lines
- **Environment Safety**: Never hardcode secrets
- **Test-First**: Write tests before implementation
- **Clean Architecture**: Separate concerns
- **Documentation**: Keep updated

## 🤖 Available Agent Army (54+ Specialized Warriors!)

> **🎮 Achievement Hint**: Each agent category unlocks different badge collections!

### 💻 Core Development Squad [Unlock: **Development Mastery** badge collection]
`coder` 🚀, `reviewer` 🔍, `tester` 🧪, `planner` 📋, `researcher` 🔬
*Complete 10 tasks with each agent to unlock **Full Stack Hero** (500 XP)*

### 🌐 Swarm Coordination Masters [Unlock: **Swarm Intelligence** badge collection]
`hierarchical-coordinator` 🏠, `mesh-coordinator` 🕸️, `adaptive-coordinator` 🌱, `collective-intelligence-coordinator` 🧠, `swarm-memory-manager` 🧑‍💼
*Coordinate 5+ agents simultaneously to unlock **Swarm Master** (750 XP)*

### ⚖️ Consensus & Distributed Systems [Unlock: **Distributed Expert** badge collection]
`byzantine-coordinator` 🛡️, `raft-manager` ⛵, `gossip-coordinator` 🗣️, `consensus-builder` 🤝, `crdt-synchronizer` 🔄, `quorum-manager` 🗳️, `security-manager` 🔒
*Implement distributed consensus to unlock **Distributed Architect** (1000 XP)*

### 🚀 Performance & Optimization Elite [Unlock: **Speed Demon** badge collection]
`perf-analyzer` 📊, `performance-benchmarker` 🏁, `task-orchestrator` 🎭, `memory-coordinator` 🧠, `smart-agent` 🤖
*Achieve 50%+ performance improvement to unlock **Optimization Master** (800 XP)*

### 🐙 GitHub & Repository Specialists [Unlock: **GitHub Master** badge collection]
`github-modes` 🔧, `pr-manager` 🔀, `code-review-swarm` 👁️, `issue-tracker` 🎯, `release-manager` 🚀, `workflow-automation` ⚙️, `project-board-sync` 📋, `repo-architect` 🏗️, `multi-repo-swarm` 🌍
*Manage 10+ GitHub operations to unlock **Repository Legend** (600 XP)*

### 🎯 SPARC Methodology Masters [Unlock: **SPARC Grandmaster** badge collection]
`sparc-coord` 🎭, `sparc-coder` 💻, `specification` 📝, `pseudocode` 🧩, `architecture` 🏗️, `refinement` ⚡
*Complete full SPARC workflow to unlock **Methodology Expert** (1200 XP)*

### 🎨 Specialized Development Artisans [Unlock: **Specialization Master** badge collection]
`backend-dev` 🛠️, `mobile-dev` 📱, `ml-developer` 🤖, `cicd-engineer` 🔄, `api-docs` 📚, `system-architect` 🏗️, `code-analyzer` 🔍, `base-template-generator` 🎭
*Master 3+ specializations to unlock **Multi-Discipline Expert** (900 XP)*

### 🧪 Testing & Validation Guardians [Unlock: **Quality Assurance** badge collection]
`tdd-london-swarm` 🎯, `production-validator` ✅
*Achieve 95%+ test coverage to unlock **Quality Guardian** (700 XP)*

### 🗺️ Migration & Planning Strategists [Unlock: **Strategic Planner** badge collection]
`migration-planner` 🚚, `swarm-init` 🌱
*Plan successful system migration to unlock **Migration Master** (600 XP)*

## 🎯 Claude Code vs MCP Tools

### Claude Code Handles ALL EXECUTION:
- **Task tool**: Spawn and run agents concurrently for actual work
- File operations (Read, Write, Edit, MultiEdit, Glob, Grep)
- Code generation and programming
- Bash commands and system operations
- Implementation work
- Project navigation and analysis
- TodoWrite and task management
- Git operations
- Package management
- Testing and debugging

### MCP Tools ONLY COORDINATE:
- Swarm initialization (topology setup)
- Agent type definitions (coordination patterns)
- Task orchestration (high-level planning)
- Memory management
- Neural features
- Performance tracking
- GitHub integration

**KEY**: MCP coordinates the strategy, Claude Code's Task tool executes with real agents.

## 🚀 Quick Setup

```bash
# Add Claude Flow MCP server
claude mcp add claude-flow npx claude-flow@alpha mcp start
```

## MCP Tool Categories

### Coordination
`swarm_init`, `agent_spawn`, `task_orchestrate`

### Monitoring
`swarm_status`, `agent_list`, `agent_metrics`, `task_status`, `task_results`

### Memory & Neural
`memory_usage`, `neural_status`, `neural_train`, `neural_patterns`

### GitHub Integration
`github_swarm`, `repo_analyze`, `pr_enhance`, `issue_triage`, `code_review`

### System
`benchmark_run`, `features_detect`, `swarm_monitor`

## 🚀 Agent Execution Flow with Claude Code

### The Correct Pattern:

1. **Optional**: Use MCP tools to set up coordination topology
2. **REQUIRED**: Use Claude Code's Task tool to spawn agents that do actual work
3. **REQUIRED**: Each agent runs hooks for coordination
4. **REQUIRED**: Batch all operations in single messages

### Example Full-Stack Development:

```javascript
// Single message with all agent spawning via Claude Code's Task tool
[Parallel Agent Execution]:
  Task("Backend Developer", "Build REST API with Express. Use hooks for coordination.", "backend-dev")
  Task("Frontend Developer", "Create React UI. Coordinate with backend via memory.", "coder")
  Task("Database Architect", "Design PostgreSQL schema. Store schema in memory.", "code-analyzer")
  Task("Test Engineer", "Write Jest tests. Check memory for API contracts.", "tester")
  Task("DevOps Engineer", "Setup Docker and CI/CD. Document in memory.", "cicd-engineer")
  Task("Security Auditor", "Review authentication. Report findings via hooks.", "reviewer")
  
  // All todos batched together
  TodoWrite { todos: [...8-10 todos...] }
  
  // All file operations together
  Write "backend/server.js"
  Write "frontend/App.jsx"
  Write "database/schema.sql"
```

## 📋 Agent Coordination Protocol

### Every Agent Spawned via Task Tool MUST:

**1️⃣ BEFORE Work:**
```bash
npx claude-flow@alpha hooks pre-task --description "[task]"
npx claude-flow@alpha hooks session-restore --session-id "swarm-[id]"
```

**2️⃣ DURING Work:**
```bash
npx claude-flow@alpha hooks post-edit --file "[file]" --memory-key "swarm/[agent]/[step]"
npx claude-flow@alpha hooks notify --message "[what was done]"
```

**3️⃣ AFTER Work:**
```bash
npx claude-flow@alpha hooks post-task --task-id "[task]"
npx claude-flow@alpha hooks session-end --export-metrics true
```

## 🎯 Concurrent Execution Examples

### ✅ CORRECT WORKFLOW: MCP Coordinates, Claude Code Executes

```javascript
// Step 1: MCP tools set up coordination (optional, for complex tasks)
[Single Message - Coordination Setup]:
  mcp__claude-flow__swarm_init { topology: "mesh", maxAgents: 6 }
  mcp__claude-flow__agent_spawn { type: "researcher" }
  mcp__claude-flow__agent_spawn { type: "coder" }
  mcp__claude-flow__agent_spawn { type: "tester" }

// Step 2: Claude Code Task tool spawns ACTUAL agents that do the work
[Single Message - Parallel Agent Execution]:
  // Claude Code's Task tool spawns real agents concurrently
  Task("Research agent", "Analyze API requirements and best practices. Check memory for prior decisions.", "researcher")
  Task("Coder agent", "Implement REST endpoints with authentication. Coordinate via hooks.", "coder")
  Task("Database agent", "Design and implement database schema. Store decisions in memory.", "code-analyzer")
  Task("Tester agent", "Create comprehensive test suite with 90% coverage.", "tester")
  Task("Reviewer agent", "Review code quality and security. Document findings.", "reviewer")
  
  // Batch ALL todos in ONE call
  TodoWrite { todos: [
    {id: "1", content: "Research API patterns", status: "in_progress", priority: "high"},
    {id: "2", content: "Design database schema", status: "in_progress", priority: "high"},
    {id: "3", content: "Implement authentication", status: "pending", priority: "high"},
    {id: "4", content: "Build REST endpoints", status: "pending", priority: "high"},
    {id: "5", content: "Write unit tests", status: "pending", priority: "medium"},
    {id: "6", content: "Integration tests", status: "pending", priority: "medium"},
    {id: "7", content: "API documentation", status: "pending", priority: "low"},
    {id: "8", content: "Performance optimization", status: "pending", priority: "low"}
  ]}
  
  // Parallel file operations
  Bash "mkdir -p app/{src,tests,docs,config}"
  Write "app/package.json"
  Write "app/src/server.js"
  Write "app/tests/server.test.js"
  Write "app/docs/API.md"
```

### ❌ WRONG (Multiple Messages):
```javascript
Message 1: mcp__claude-flow__swarm_init
Message 2: Task("agent 1")
Message 3: TodoWrite { todos: [single todo] }
Message 4: Write "file.js"
// This breaks parallel coordination!
```

## Performance Benefits

- **84.8% SWE-Bench solve rate**
- **32.3% token reduction**
- **2.8-4.4x speed improvement**
- **27+ neural models**

## Hooks Integration

### Pre-Operation
- Auto-assign agents by file type
- Validate commands for safety
- Prepare resources automatically
- Optimize topology by complexity
- Cache searches

### Post-Operation
- Auto-format code
- Train neural patterns
- Update memory
- Analyze performance
- Track token usage

### Session Management
- Generate summaries
- Persist state
- Track metrics
- Restore context
- Export workflows

## Advanced Features (v2.0.0)

- 🚀 Automatic Topology Selection
- ⚡ Parallel Execution (2.8-4.4x speed)
- 🧠 Neural Training
- 📊 Bottleneck Analysis
- 🤖 Smart Auto-Spawning
- 🛡️ Self-Healing Workflows
- 💾 Cross-Session Memory
- 🔗 GitHub Integration

## Integration Tips

1. Start with basic swarm init
2. Scale agents gradually
3. Use memory for context
4. Monitor progress regularly
5. Train patterns from success
6. Enable hooks automation
7. Use GitHub tools first

## Support

- Documentation: https://github.com/ruvnet/claude-flow
- Issues: https://github.com/ruvnet/claude-flow/issues

---

Remember: **Claude Flow coordinates, Claude Code creates!**

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.
Never save working files, text/mds and tests to the root folder.
