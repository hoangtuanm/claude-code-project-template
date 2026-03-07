# Tasks: Unified Directory Structure

- [x] Create base directories: `src/`, `skills/shared/`, `.claude/skills/`.
- [x] Move existing skills from `.agent/skills/` to `skills/shared/`.
- [x] Implement `setup-symlinks.sh` to generate skill symlinks for both agents.
- [x] Run `setup-symlinks.sh` to populate `.agent/skills/` and `.claude/skills/`.
- [x] Create `openspec/specs/project.md` with Antigravity and Claude collaboration rules.
- [x] Create `AGENTS.md` to instruct Antigravity on loading context and enforcing OpenSpec SSOT.
- [x] Create `CLAUDE.md` to instruct Claude Code on loading context and enforcing OpenSpec SSOT.
- [x] Create `AGENTS_SSYNC_RULES.md` to formally document OpenSpec maintenance mandates.
- [x] Validate model continuity by ensuring both agents parse the shared skills and OpenSpec SSOT successfully.
