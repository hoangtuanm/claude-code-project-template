## ADDED Requirements

### Requirement: Template is Claude Code–only
The template SHALL contain no files, directories, configuration values, or documentation that reference Antigravity or any second agent. A developer cloning this template SHALL encounter only Claude Code–specific scaffolding.

#### Scenario: No Antigravity files present
- **WHEN** a developer clones the template
- **THEN** no `AGENTS.md` file exists at the project root
- **THEN** no `.agent/` directory exists at the project root

#### Scenario: No Antigravity config values
- **WHEN** a developer reads `openspec/config.yaml`
- **THEN** the `agents` block contains only `primary: "claude-code"` and `strict_sync: true`
- **THEN** no `fallback` key exists in the `agents` block

#### Scenario: No Antigravity convention steps
- **WHEN** a developer reads `openspec/CONVENTIONS.md`
- **THEN** Convention #1 contains no reference to `.agent/skills/` symlinks
- **THEN** Convention #2 contains no reference to `openspec init --tools antigravity`

### Requirement: Sync rules file is named for single-agent use
The file governing OpenSpec synchronization rules SHALL be named `SYNC_RULES.md` (not `AGENTS_SSYNC_RULES.md`). All references to this file throughout the template SHALL use the new name.

#### Scenario: File exists under new name
- **WHEN** a developer looks for OpenSpec sync rules
- **THEN** `SYNC_RULES.md` exists at the project root
- **THEN** no `AGENTS_SSYNC_RULES.md` exists at the project root

#### Scenario: CLAUDE.md references correct filename
- **WHEN** a developer reads `CLAUDE.md` instruction #1
- **THEN** the instruction references `SYNC_RULES.md`, not `AGENTS_SSYNC_RULES.md`

### Requirement: Setup script is Claude-only
`scripts/setup-symlinks.sh` SHALL only create symlinks in `.claude/skills/`. It SHALL NOT attempt to create or manage `.agent/skills/` symlinks.

#### Scenario: Script creates only Claude symlinks
- **WHEN** a developer runs `./scripts/setup-symlinks.sh`
- **THEN** symlinks are created in `.claude/skills/` pointing to `../../skills/shared/<skill>`
- **THEN** no `.agent/skills/` directory or symlinks are created

#### Scenario: Script output reflects Claude-only scope
- **WHEN** the script completes successfully
- **THEN** the output message references Claude Code only (not "both agents")
