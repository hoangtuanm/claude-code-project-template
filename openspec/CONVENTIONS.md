# Agent Conventions

> Universal behavioral rules for Claude Code working on this project.

---

## 1. Skill Discovery First

Before initiating any spec or change, **agents must verify existing skills and discover new capabilities**.

**Rule:** Always check `.claude/skills/` for existing relevant skills first. If no suitable skill exists locally, use `.claude/skills/find-skills/SKILL.md` to search the open agent ecosystem at [skills.sh](https://skills.sh/). When installing, prioritize the **highest-rated and most trustworthy** skills — not just any relevant match.

**Flow:**
1. User requests a feature or change
2. Agent checks `.claude/skills/` for existing relevant skills
3. If a suitable skill exists locally → use it, proceed with `/opsx:propose`
4. If no suitable local skill → invoke `find-skills` to search [skills.sh](https://skills.sh/)
5. Evaluate candidates by trust signals (see table below)
6. Install ONLY the highest-rated, most trustworthy match → `.claude/skills/`
7. Proceed with `/opsx:propose` leveraging the skill
8. If no suitable skill found → proceed using existing agent capabilities

**Trust signals (evaluate before installing):**

| Signal | Source | Preferred |
|---|---|---|
| Security risk (Gen) | `npx skills add --list` output | Safe or Low Risk |
| Socket alerts | `npx skills add --list` output | 0 alerts |
| Snyk risk | `npx skills add --list` output | Low Risk |
| Source organization | skills.sh page | Verified orgs (e.g., `github`, `vercel-labs`) |

**Why:** Avoid reinventing the wheel, but also avoid introducing untrusted capabilities. The agent ecosystem evolves constantly — always check before building from scratch, but vet quality before installing.

---

## 2. Semantic Versioning on Archive

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

---

## 3. Modular Monolith Architecture

All new code MUST follow the **Modular Monolith** pattern: a single repository and deployable unit with strictly decoupled, domain-driven internal modules.

**Full specification:** [`openspec/specs/architecture/spec.md`](openspec/specs/architecture/spec.md)

**Immutable rules (apply to all stacks):**
- Cross-cutting code lives in `src/shared/`
- Modules NEVER import from each other's internals — only through `index.ts` or `shared/` contracts
- Every new module MUST have a corresponding `openspec/specs/<name>/spec.md`
- Agents MUST read a module's `README.md` before editing its code

### Variant A — Web / Node / Backend (default)

```
src/modules/<name>/
├── domain/       ← entities, use cases, business rules
├── infra/        ← DB, external APIs, adapters
├── ui/           ← components scoped to this module
├── index.ts      ← public API
└── README.md
```

### Variant B — React Native / Expo Router

Expo Router owns the `app/` directory for file-based routing. Screens live there (thin — import and render only). All logic lives in `src/modules/`.

```
app/                        ← Expo Router screens (navigation only)
  (tabs)/
    index.tsx               ← imports from src/modules/home
  _layout.tsx

src/modules/<name>/
├── components/   ← UI components (not screens)
├── hooks/        ← business logic as hooks
├── api/          ← data fetching and mutations
├── store/        ← local state (Zustand slice, etc.)
├── types.ts
├── index.ts      ← public API
└── README.md

src/shared/       ← design system, utils, shared hooks
```

**When starting a project, declare the variant in `openspec/config.yaml` under `architecture.variant`** so all future Claude sessions apply the correct structure without ambiguity.

---

## 4. Architectural Diagrams for Modules

Every module MUST include production-grade ASCII diagrams generated via the `plantuml-ascii` skill. **Always use Unicode output (`-utxt`)** for box-drawing characters and superior visual quality.

**Required diagrams (in `src/modules/<name>/diagrams/`):**

| Diagram | File | Type | Purpose |
|---|---|---|---|
| Module structure | `module.puml` | Component | Shows domain/infra/ui layers and their relationships |
| Domain entities | `entities.puml` | Class | Key entities, their attributes, and relationships |

**Optional diagrams (when applicable):**

| Diagram | File | Type | When to include |
|---|---|---|---|
| Data flow | `data-flow.puml` | Sequence | Module has complex request/response flows |
| Entity lifecycle | `states.puml` | State | Entities have distinct state transitions |
| Business process | `process.puml` | Activity | Complex decision trees or workflows |

**Generation command:**
```bash
plantuml -utxt diagrams/*.puml
```

**Rules:**
- Source files (`.puml`) and output files (`.utxt`) are both version-controlled
- Key diagrams MUST be embedded in the module's `README.md` under the **Architecture** and **Key Entities** sections
- Keep diagrams simple — short labels, minimal nesting — for clean ASCII rendering
- Update diagrams when module architecture changes
