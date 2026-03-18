## MODIFIED Requirements

### Requirement: Agent Collaboration Model
This project uses a **single-agent workflow** with Claude Code as the sole AI agent. Claude Code handles all tasks: IDE-centric refactors, system planning, holistic cross-file changes, CLI-based iterations, and focused file edits.

#### Scenario: Claude Code is the only agent
- **WHEN** a developer opens the project
- **THEN** only `CLAUDE.md` exists as an agent boot context file
- **THEN** Claude Code loads `openspec/config.yaml`, `openspec/CONVENTIONS.md`, and `SYNC_RULES.md` on startup

#### Scenario: OpenSpec continuity without handoff
- **WHEN** Claude Code completes a significant task
- **THEN** the corresponding `openspec/changes/` or `openspec/specs/` artifacts MUST be updated
- **THEN** the working state is fully recoverable from `openspec/` in any future session without additional prompting

### Requirement: SSOT Governance
All project context SHALL reside in `openspec/config.yaml` and `openspec/specs/`. Claude Code SHALL parse `openspec/` before beginning any task. There are no handoffs between agents — `openspec/` is the continuity mechanism for Claude across sessions.

#### Scenario: Mandatory SSOT load
- **WHEN** Claude Code begins any user request
- **THEN** it MUST load `openspec/config.yaml`, `openspec/CONVENTIONS.md`, and `SYNC_RULES.md` before proceeding

#### Scenario: No unofficial state
- **WHEN** Claude Code tracks implementation progress
- **THEN** all progress MUST reside in `openspec/changes/<name>/tasks.md`
- **THEN** no ad-hoc markdown files outside `openspec/` SHALL be created for task tracking
