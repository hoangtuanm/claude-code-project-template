## Why

This template was originally designed for a dual-agent workflow (Antigravity primary, Claude Code fallback). Antigravity is no longer in use, so all references to it create noise, confusion, and dead configuration that a developer bootstrapping a new project would need to manually strip out. Repurposing the template for Claude Code exclusively makes it a clean, self-consistent bootstrap for any new project.

## What Changes

- **DELETE** `AGENTS.md` — Antigravity's boot context file; Claude Code does not read it
- **DELETE** `.agent/` directory — Antigravity's skills symlinks and workflow files
- **DELETE** `.gitignore` entry for `.agents/` — Antigravity npx install artifact
- **EDIT** `CLAUDE.md` — Remove all Antigravity mentions; update `SYNC_RULES.md` reference (renamed file)
- **RENAME + EDIT** `AGENTS_SSYNC_RULES.md` → `SYNC_RULES.md` — Remove dual-agent language, reword as Claude-only
- **EDIT** `openspec/config.yaml` — Set `agents.primary: "claude-code"`, remove `fallback` entry
- **EDIT** `openspec/specs/project.md` — Rewrite as Claude-only agent spec (remove Antigravity-first rules, Claude fallback section)
- **EDIT** `openspec/CONVENTIONS.md` — Convention #1: remove `.agent/skills/` symlink step; Convention #2: remove `openspec init --tools antigravity` step
- **EDIT** `scripts/setup-symlinks.sh` — Remove `.agent/skills/` symlink block; Claude-only output message

## Capabilities

### New Capabilities

- `claude-code-bootstrap`: A clean Claude Code–only project bootstrap with OpenSpec SSOT, shared skills via `.claude/skills/`, and no Antigravity artifacts

### Modified Capabilities

- `project`: The agent collaboration model changes from dual-agent (Antigravity-primary) to single-agent (Claude Code only)

## Impact

- Removes `.agent/` directory and `AGENTS.md` entirely
- `AGENTS_SSYNC_RULES.md` renamed to `SYNC_RULES.md` — any external references must update
- `openspec/config.yaml` agent block changes shape (no `fallback` key)
- `scripts/setup-symlinks.sh` behavior changes: no longer manages `.agent/skills/` symlinks
- All existing conventions (#1–#5), architecture specs, and OpenSpec workflow remain intact
