# Claude Code Context Loading

## Instructions for Claude Code

1. **Mandatory SSOT Load**: IMMEDIATELY load and review `./openspec/config.yaml` and `./openspec/CONVENTIONS.md` before processing any user requests globally or within subdirectories.
2. **Shared Skills**: Your skills are available at `./.claude/skills/`.
3. **Feature Scoping**: When working in subdirectories, scope your file editing to the relevant features but ALWAYS update the global OpenSpec artifacts at the root.

## OpenSpec Rules

**The `openspec/` directory is the single source of truth (SSOT) for this project.**

1. **Always Read First**: Before modifying any architecture or proposing large changes, always read `./openspec/config.yaml` and relevant specifications in `./openspec/specs/`.
2. **Synchronize Changes**: Whenever a significant implementation is completed, the corresponding OpenSpec artifacts MUST be updated to reflect the new reality.
3. **No Unofficial State**: Do not keep mental state or ad-hoc markdown files outside of the OpenSpec framework for tracking project progress.
4. **Maintain Continuity**: Leaving a trace of your work in `openspec/changes/` or `openspec/specs/` is the ONLY way future Claude sessions will know what was done. OpenSpec is the cross-session memory.
