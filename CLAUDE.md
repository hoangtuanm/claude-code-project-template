# Claude Code Context Loading

## Instructions for Claude Code

1. **Mandatory SSOT Load**: IMMEDIATELY load and review `./openspec/config.yaml`, `./openspec/CONVENTIONS.md`, and `./SYNC_RULES.md` before processing any user requests globally or within subdirectories.
2. **Shared Skills**: Your skills are available at `./.claude/skills/`, which symlink to `../../skills/shared/`.
3. **OpenSpec Sync Requirement**: You MUST treat `./openspec/` as the single source of truth. Make sure to update specs and changes when modifying the codebase. This guarantees continuity across sessions.
4. **Feature Scoping**: When working in subdirectories, scope your file editing to the relevant features but ALWAYS update the global OpenSpec artifacts at the root.
