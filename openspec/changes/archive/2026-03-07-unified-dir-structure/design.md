## Context

The project is moving to a dual-agent workflow with Antigravity as the primary IDE-integrated agent and Claude Code as an auxiliary CLI/Extension agent. To maintain continuity between these models, we need a unified directory structure where both AI agents can seamlessly read and share identical configurations and skill definitions without file duplication or context divergence.

## Goals / Non-Goals

**Goals:**
- Unify AI skill definitions into a single source truth (`skills/shared/`).
- Force both Antigravity and Claude Code to parse project rules using an overarching directory structure managed via OpenSpec (`openspec/config.yaml` and `openspec/specs/`).
- Establish `setup-symlinks.sh` as the standard initialization script to hydrate each model's independent skill directory from the common source.

**Non-Goals:**
- Merging model-specific system prompts (which are maintained internally by each agent platform).
- Attempting to force both agents to use the exact same directory (e.g., getting Claude to read directly out of `.agent/` without symlinks, as Claude explicitly expects `.claude/`).

## Decisions

**Decision 1: Use Symlinks for Skills**
- *Rationale*: Antigravity expects skills in `.agent/skills/` and Claude Code expects them in `.claude/skills/`. To avoid duplicating definitions, a neutral directory (`skills/shared/`) acts as the origin point, with symlinks directing each model to the source.
- *Alternatives considered*: Writing a git pre-commit hook or file-watcher to sync actual files between `.agent` and `.claude`. Symlinks are universally supported on modern operating systems without background daemons.

**Decision 2: OpenSpec as the Single Source of Truth (SSOT)**
- *Rationale*: OpenSpec naturally isolates project metadata, configurations, and active architectures away from the implementation logic. Instructing both agents via `AGENTS.md` and `CLAUDE.md` to prioritize loading `openspec/` guarantees an overlap in mental context.
- *Alternatives considered*: Instructing the user to copy-paste context between prompts manually, which defeats the purpose of autonomous agents.

## Risks / Trade-offs

- **[Risk] Windows Compatibility with Symlinks** → Mitigation: `setup-symlinks.sh` is written in bash. If Windows compatibility is required later, we can implement an equivalent PowerShell script or configure Git to automatically handle symlink emulation.
- **[Risk] Accidental Deletion of SSOT logic** → Mitigation: Documenting the strict rules in `AGENTS_SSYNC_RULES.md` and explicitly telling both models never to delete or orphan the `openspec/` state.
