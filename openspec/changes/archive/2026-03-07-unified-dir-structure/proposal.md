# Unified Directory Structure for Antigravity & Claude Code

## Why
Bootstrap the project with a unified directory structure that supports both Antigravity (primary IDE) and Claude Code (extension) using OpenSpec as the Single Source of Truth (SSOT). Ensure context and task continuity when switching models.

## What Changes
We will create a unified `skills/shared` directory and symlink the models to it. We will also introduce project-level contextual instructions (`AGENTS.md` and `CLAUDE.md`).

## Proposed Structure
1. **Root Directories**: 
   - `openspec/`: The SSOT for all project context, configurations, specs, and changes.
   - `src/`: Application source code.
   - `skills/shared/`: Actual files for shared agent skills.
   - `.agent/skills/`: Symlinks pointing to `../../skills/shared/<skill>`.
   - `.claude/skills/`: Symlinks pointing to `../../skills/shared/<skill>`.

2. **Skill Synchronization**:
   - Skills are defined once in `skills/shared/`.
   - Symlinks are created in both `.agent/skills/` and `.claude/skills/` to prevent duplication.

3. **Context & Continuity**:
   - `AGENTS.md` and `CLAUDE.md` at the project root ensure both AI agents load the correct SSOT (`openspec/config.yaml`), shared skills, and enforce cross-agent project synchronization.
   - `AGENTS_SSYNC_RULES.md` explicitly defines the strict SSOT maintenance rules.
   - `openspec/specs/project.md` defines Antigravity-first rules with Claude fallback.

## OpenSpec Sync Requirements
Both Antigravity and Claude agents MUST keep `openspec/config.yaml` and `openspec/` folders synchronized with ALL project changes to enforce SSOT.
