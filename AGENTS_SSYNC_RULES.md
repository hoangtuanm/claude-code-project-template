# Agent OpenSpec Synchronization Rules

### THE GOLDEN RULE
**The `openspec/` directory is the single source of truth (SSOT) for this project.**

Both Antigravity and Claude Code MUST adhere to the following strict rules:

1. **Always Read First**: Before modifying any architecture or proposing large changes, always read `./openspec/config.yaml` and relevant specifications in `./openspec/specs/`.
2. **Synchronize Changes**: Whenever a significant implementation is completed, the corresponding OpenSpec artifacts MUST be updated to reflect the new reality.
3. **No Unofficial State**: Do not keep mental state or ad-hoc markdown files outside of the OpenSpec framework for tracking project progress.
4. **Maintain Continuity**: Since the user frequently switches between Antigravity and Claude, leaving a trace of your work in `openspec/changes/` or `openspec/specs/` is the ONLY way the other model will know what you did.
