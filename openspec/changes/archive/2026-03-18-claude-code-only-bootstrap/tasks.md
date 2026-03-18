## 1. Delete Antigravity Files

- [x] 1.1 Delete `AGENTS.md` from the project root
- [x] 1.2 Delete the entire `.agent/` directory (skills symlinks + workflow `.md` files)

## 2. Rename and Update Sync Rules

- [x] 2.1 Rename `AGENTS_SSYNC_RULES.md` → `SYNC_RULES.md`
- [x] 2.2 Edit `SYNC_RULES.md`: replace "Both Antigravity and Claude Code MUST" with "Claude Code MUST" throughout; remove any remaining dual-agent language

## 3. Update CLAUDE.md

- [x] 3.1 Instruction #1: change `./AGENTS_SSYNC_RULES.md` reference to `./SYNC_RULES.md`
- [x] 3.2 Instruction #3: remove "This guarantees continuity when the user switches back to Antigravity." — reword as Claude-only sync requirement
- [x] 3.3 Instruction #4: remove the Antigravity mention in the subdirectory scoping note (if still present after review)

## 4. Update openspec/config.yaml

- [x] 4.1 Change `agents.primary` from `"antigravity"` to `"claude-code"`
- [x] 4.2 Remove the `agents.fallback: "claude-code"` line entirely

## 5. Rewrite openspec/specs/project.md

- [x] 5.1 Replace the file contents with the updated single-agent collaboration spec (remove "Antigravity-First Rules" and "Claude Fallback" sections; update SSOT description to match new `SYNC_RULES.md` filename)

## 6. Update openspec/CONVENTIONS.md

- [x] 6.1 Convention #1 (Skill Discovery): remove the step that symlinks to `.agent/skills/`; update the flow to reference `.claude/skills/` only
- [x] 6.2 Convention #2 (Post-OpenSpec Update Recovery): remove `openspec init --tools antigravity` step; simplify to Claude Code–only recovery flow (run `openspec init`, then `./scripts/setup-symlinks.sh`, verify `.claude/skills/`)

## 7. Simplify scripts/setup-symlinks.sh

- [x] 7.1 Remove the migration block that moves skills from `.agent/skills/` to `skills/shared/`
- [x] 7.2 Remove the symlink creation loop for `.agent/skills/`
- [x] 7.3 Remove `mkdir -p .agent/skills` line
- [x] 7.4 Update the final echo message to reference Claude Code only (e.g., "Claude Code will use skills/shared/ as the SSOT.")

## 8. Clean Up .gitignore

- [x] 8.1 Remove the `.agents/` line (Antigravity npx install artifact; no longer applicable)

## 9. Verify

- [x] 9.1 Confirm no remaining references to "Antigravity" or ".agent/" exist in any non-archived file (`grep -r "antigravity\|\.agent/" --include="*.md" --include="*.yaml" --include="*.sh" --include="*.json" . --exclude-dir=.git --exclude-dir=openspec/changes/archive`)
- [x] 9.2 Confirm `.claude/skills/` symlinks still resolve correctly to `skills/shared/`
- [x] 9.3 Run `./scripts/setup-symlinks.sh` and confirm it completes without errors
