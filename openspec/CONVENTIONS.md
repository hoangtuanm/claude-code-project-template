# Agent Conventions

> Universal behavioral rules for all AI agents working on this project.
> Both Antigravity and Claude Code MUST follow these conventions.

---

## 1. Skill Discovery First

Before initiating any complex spec or change, **agents must discover their capabilities**.

**Rule:** Use `skills/shared/find-skills/SKILL.md` to search the open agent ecosystem at [skills.sh](https://skills.sh/). If suitable skills are found, install them into `skills/shared/` and symlink to both `.agent/skills/` and `.claude/skills/` before crafting a `/opsx:propose`.

**Flow:**
1. User requests a complex feature or change
2. Agent invokes the `find-skills` skill to search for relevant capabilities
3. If a matching skill exists → install to `skills/shared/`, create symlinks
4. Then proceed with `/opsx:propose` leveraging the new skill
5. If no matching skill → proceed with `/opsx:propose` using existing capabilities

**Why:** Avoid reinventing the wheel. The agent ecosystem evolves constantly — always check before building from scratch.

---

## 2. Post-OpenSpec Update Recovery

After running `openspec init`, **always execute `./scripts/setup-symlinks.sh`** to restore the shared skill symlinks for all agents.

**Why:** `openspec init` regenerates `.agent/skills/` with real directories, overwriting our symlinks to `skills/shared/`. The recovery script moves skills back to the shared directory and re-creates symlinks for both Antigravity and Claude Code.

**Flow:**
1. Run `openspec init --tools antigravity`
2. Run `./scripts/setup-symlinks.sh`
3. Verify with `ls -la .agent/skills/` — all entries should be symlinks

---

## 3. Semantic Versioning on Archive

After every successful `/opsx:archive`, **agents must create a git commit and semantic version tag**.

**Rule:** This provides robust fallback points, allowing rapid restoration of any functional checkpoint.

**Version bump logic (inferred from change deltas):**

| Delta Type | Bump | Example |
|---|---|---|
| Only `ADDED` specs | **MINOR** | New feature added |
| `MODIFIED` or `REMOVED` specs | **MAJOR** | Breaking / architectural change |
| No spec changes (docs, config) | **PATCH** | Housekeeping |

**Flow:**
1. Complete `/opsx:archive <change-name>`
2. Stage all changes: `git add -A`
3. Commit: `git commit -m "<type>(<change-name>): <summary>"`
   - Types: `feat` (MINOR), `fix` (PATCH), `breaking` (MAJOR)
4. Determine next version based on delta type above
5. Tag: `git tag -a vX.Y.Z -m "<change-name>: <summary>"`
6. Verify: `git log --oneline -1 && git tag -l 'v*'`

**Rollback:** `git checkout vX.Y.Z` restores any checkpoint instantly.
