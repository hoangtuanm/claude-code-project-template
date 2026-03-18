## Context

The template was bootstrapped with a dual-agent architecture: Antigravity held the primary role (IDE-integrated, holistic changes) and Claude Code was the fallback (CLI/extension, focused tasks). The `skills/shared/` + symlink pattern, `openspec/` SSOT, and all five conventions were designed to work for both. Antigravity is no longer part of the workflow. The template now needs to be self-consistent for Claude Code alone, without leaving scaffolding that confuses developers starting a new project from it.

## Goals / Non-Goals

**Goals:**
- Remove every file, directory, and config value that references Antigravity
- Rename `AGENTS_SSYNC_RULES.md` → `SYNC_RULES.md` and update all internal references
- Simplify `scripts/setup-symlinks.sh` to Claude-only (single target: `.claude/skills/`)
- Update `openspec/config.yaml` agent block to reflect single-agent reality
- Keep all 5 conventions, the modular monolith architecture spec, and the OpenSpec workflow completely intact

**Non-Goals:**
- Changing the OpenSpec workflow (spec-driven, proposal → design → specs → tasks)
- Changing skill definitions in `skills/shared/`
- Touching archived changes (historical record — keep as-is)
- Adding any new capability or feature beyond cleanup

## Decisions

**Decision 1: Delete `.agent/` entirely, not archive it**
- The `.agent/` directory contains only Antigravity symlinks and workflow `.md` files. These have no value for a Claude Code–only project. Keeping them would mislead new project maintainers into thinking a second agent is in use.
- *Alternative considered*: Move to an `archive/` directory at root. Rejected — this is not project history, it's dead scaffolding.

**Decision 2: Rename `AGENTS_SSYNC_RULES.md` → `SYNC_RULES.md`**
- The filename `AGENTS_SSYNC_RULES.md` implies multiple agents. The content (keep `openspec/` as SSOT, always read before modifying, synchronize after changes) is entirely valid for a single-agent setup.
- The rename signals to future developers that sync rules are for the agent (Claude), not multiple agents.
- `CLAUDE.md` instruction #1 must be updated to reference the new filename.
- *Alternative considered*: Keep the filename and only edit content. Rejected — the filename creates a false impression at a glance.

**Decision 3: Remove `agents.fallback` from `openspec/config.yaml` entirely**
- A `fallback` key implies a second agent exists. With only one agent, the concept of fallback is meaningless. Leaving a commented-out or empty value would still create ambiguity.
- The `agents` block after this change becomes: `primary: "claude-code"`, `strict_sync: true`.

**Decision 4: Keep `scripts/setup-symlinks.sh` but simplify**
- The script is still useful: after `openspec init` regenerates `.claude/skills/` as real directories (overwriting symlinks), this script restores the symlinks to `skills/shared/`. This is still referenced in Convention #2.
- The migration block (moving skills from `.agent/skills/` to `skills/shared/`) is removed since `.agent/` no longer exists.
- The `.agent/skills/` symlink creation loop is removed.
- *Alternative considered*: Delete the script entirely. Rejected — Convention #2 references it and the `openspec init` recovery scenario is still valid.

**Decision 5: Preserve all archived changes as historical record**
- `openspec/changes/archive/2026-03-07-unified-dir-structure/` documents the original dual-agent design decision. It is truth-in-time, not dead configuration.

## Risks / Trade-offs

- **[Risk] External references to `AGENTS_SSYNC_RULES.md`** → Low probability — this file is only referenced in `CLAUDE.md` instruction #1, which is updated as part of this change. No other files link to it.
- **[Risk] Developer forks this template and runs `setup-symlinks.sh` expecting `.agent/` support** → Mitigation: Update the script's output message and comments to make Claude-only scope explicit.
- **[Risk] Deleting `.agent/` removes workflow `.md` files that document Antigravity commands** → Acceptable. Those commands (`/opsx:` Antigravity variants) have no meaning in a Claude Code–only context.

## Migration Plan

No running system — this is a template. No migration is required. Changes are purely file edits, deletions, and renames within the repository.

Rollback: `git checkout` to any prior commit restores the full dual-agent state instantly.

## Open Questions

None. All decisions are resolved.
