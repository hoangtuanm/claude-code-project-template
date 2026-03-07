# Specification: Directory Layout (Delta)

## ADDED
#### Scenario: Agent Symlink Directories
- `skills/shared/`: The central repository for all AI agent skills. Avoids duplication between Antigravity and Claude.
- `src/`: The main source code directory.
- `.claude/skills/`: Directory for Claude Code skills (populated via symlinks).

## MODIFIED
#### Scenario: Antigravity Skill Path
- `.agent/skills/`: Upgraded from holding actual skill files to containing symlinks pointing to `../../skills/shared/<skill>`.

## SSOT Mandate
The `openspec/` directory is the immutable Single Source of Truth.
- Configuration: `openspec/config.yaml`
- Specifications: `openspec/specs/`
- Changes: `openspec/changes/`
Agents are strictly prohibited from storing persistent project tracking data outside of `openspec/`.
