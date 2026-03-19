# Claude Code Project Template

A production-ready bootstrap for projects powered by [Claude Code](https://claude.ai/code). Ships with a spec-driven development workflow, enforced conventions, pre-installed skills, and cross-session memory — so every Claude session picks up exactly where the last one left off.

---

## What's Inside

| Layer | What it provides |
|---|---|
| **OpenSpec** | Spec-driven workflow with a full change lifecycle (explore → propose → apply → archive) |
| **Conventions** | 4 enforced behavioral rules applied by Claude across every session |
| **Skills** | 6 pre-installed Claude Code skills for workflow, diagramming, and discovery |
| **Memory** | Cross-session context via Claude Code's native memory system |
| **Architecture** | Modular monolith pattern with Web and Expo Router variants |

---

## Quick Start

### 1. Use this template

Click **"Use this template"** on GitHub to create a new repo with a clean git history.

```bash
git clone https://github.com/your-username/your-project
cd your-project
```

### 2. Follow the setup checklist

See [SETUP.md](SETUP.md) for the full setup steps. The short version:

```bash
# 1. Fill in your product vision
open openspec/PRD.md

# 2. Set your architecture variant in openspec/config.yaml
#    architecture.variant: web | expo

# 3. Set up environment variables
cp .env.example .env

# 4. Open in Claude Code and kick off the first change
# /openspec-propose "initial project setup"
```

---

## Project Structure

```
.
├── CLAUDE.md                    ← Boot instructions Claude reads at session start
├── SETUP.md                     ← First-run checklist for new projects
├── .env.example                 ← Environment variable template
│
├── .claude/
│   └── skills/                  ← Pre-installed Claude Code skills
│       ├── find-skills/
│       ├── openspec-apply-change/
│       ├── openspec-archive-change/
│       ├── openspec-explore/
│       ├── openspec-propose/
│       └── plantuml-ascii/
│
├── openspec/                    ← Single Source of Truth (SSOT)
│   ├── config.yaml              ← Project config (version, agent, architecture variant)
│   ├── CONVENTIONS.md           ← 4 enforced conventions
│   ├── PRD.md                   ← Product requirements (fill this in first)
│   ├── specs/                   ← Living capability specs
│   │   ├── architecture/spec.md
│   │   └── project.md
│   └── changes/                 ← Active and archived changes
│       └── archive/
│
└── src/                         ← Your application code (empty — add modules here)
    ├── modules/                 ← Feature modules (see Architecture section)
    └── shared/                  ← Cross-cutting utilities and design system
```

---

## The OpenSpec Workflow

OpenSpec is a spec-driven development methodology built into this template. Every significant change follows a structured lifecycle — keeping Claude aligned across sessions without re-explanation.

```
/openspec-explore [topic]          Think through the problem space
        │
        ▼
/openspec-propose [change-name]    Generate proposal, design, specs, and tasks
        │
        ▼
/openspec-apply-change [name]      Implement tasks one by one
        │
        ▼
/openspec-archive-change [name]    Sync specs to openspec/specs/, move to archive
        │
        ▼
git commit + semantic version tag  Checkpoint for instant rollback
```

### Change artifacts

Each change lives in `openspec/changes/<name>/` and contains:

| File | Purpose |
|---|---|
| `proposal.md` | Scope, motivation, and goals |
| `design.md` | Technical decisions and trade-offs |
| `specs/<capability>/spec.md` | Capability-level requirements |
| `tasks.md` | Implementation checklist |
| `.openspec.yaml` | Change metadata |

At archive time, delta specs are synced to `openspec/specs/` — the permanent source of truth.

---

## Conventions

Four rules enforced by Claude Code across every session. Defined in [`openspec/CONVENTIONS.md`](openspec/CONVENTIONS.md).

### 1. Skill Discovery First

Before building anything from scratch, Claude checks `.claude/skills/` for existing capabilities. If nothing fits locally, it searches [skills.sh](https://skills.sh/) via the `find-skills` skill — evaluating candidates by security risk, Socket alerts, Snyk score, and source organization trust before installing.

### 2. Semantic Versioning on Archive

Every successful archive triggers a git commit and annotated tag:

| Delta type | Bump | Commit type |
|---|---|---|
| New specs added | MINOR | `feat(name): ...` |
| Specs modified or removed | MAJOR | `breaking(name): ...` |
| Docs, config, housekeeping | PATCH | `chore/fix/refactor(name): ...` |

`git checkout vX.Y.Z` restores any checkpoint instantly.

### 3. Modular Monolith Architecture

All code follows a modular monolith pattern — one deployable unit with strictly decoupled, domain-driven modules. Two variants are supported, declared via `architecture.variant` in `openspec/config.yaml`.

**Variant A — Web / Node / Backend (default)**

```
src/modules/<name>/
├── domain/        ← entities, use cases, business rules
├── infra/         ← DB, external APIs, adapters
├── ui/            ← components scoped to this module
├── index.ts       ← public API (the only import surface)
└── README.md
```

**Variant B — React Native / Expo Router**

Expo Router owns `app/` for file-based routing. Screens stay thin — all logic lives in `src/modules/`.

```
app/                         ← Expo Router screens (navigation only)
  (tabs)/index.tsx           ← imports from src/modules/home

src/modules/<name>/
├── components/    ← UI components (not screens)
├── hooks/         ← business logic
├── api/           ← data fetching and mutations
├── store/         ← local state (Zustand slice, etc.)
├── index.ts       ← public API
└── README.md
```

**Immutable rules across both variants:**
- Modules NEVER import from each other's internals — only via `index.ts`
- Cross-cutting code lives in `src/shared/`
- Every module has a corresponding `openspec/specs/<name>/spec.md`
- Claude reads a module's `README.md` before editing its code

### 4. Architectural Diagrams for Modules

Every module includes ASCII diagrams generated via the `plantuml-ascii` skill (always with `-utxt` for Unicode box-drawing). Required diagrams live in `src/modules/<name>/diagrams/` and are embedded in the module's `README.md`.

| Diagram | File | Type |
|---|---|---|
| Module structure | `module.puml` | Component |
| Domain entities | `entities.puml` | Class |

---

## Skills

Six skills ship pre-installed in `.claude/skills/`. Invoke them with `/skill-name` in Claude Code.

| Skill | Command | Purpose |
|---|---|---|
| **openspec-explore** | `/openspec-explore` | Thinking partner — explore problems before implementing |
| **openspec-propose** | `/openspec-propose` | Generate a complete change proposal in one step |
| **openspec-apply-change** | `/openspec-apply-change` | Work through implementation tasks |
| **openspec-archive-change** | `/openspec-archive-change` | Archive a completed change and sync specs |
| **plantuml-ascii** | `/plantuml-ascii` | Generate ASCII art diagrams via PlantUML |
| **find-skills** | `/find-skills` | Search the skills.sh ecosystem for new capabilities |

---

## Cross-Session Memory

Claude Code's native memory system persists context across sessions at:

```
~/.claude/projects/<project-hash>/memory/
├── MEMORY.md              ← index, auto-loaded every session
├── user_*.md              ← user profile and expertise
├── feedback_*.md          ← validated approaches and corrections
├── project_*.md           ← ongoing goals and decisions
└── reference_*.md         ← where things live externally
```

`MEMORY.md` is injected into every conversation before the first message. Use it to store user preferences, workflow feedback, architectural decisions, and external references — so Claude never needs to be re-briefed.

To populate memory for a new project, ask Claude:
> "Generate memory files for this project based on what you know about how we work."

---

## CLAUDE.md

The [`CLAUDE.md`](CLAUDE.md) file is Claude Code's boot configuration. It instructs Claude to:

1. Load `openspec/config.yaml` and `openspec/CONVENTIONS.md` at session start
2. Use skills from `.claude/skills/`
3. Scope edits to relevant features while always updating `openspec/` globally

It also contains the OpenSpec rules — the four disciplines that keep `openspec/` as the authoritative source of truth across all sessions.

---

## Versioning

This template follows semantic versioning. Key milestones:

| Version | Milestone |
|---|---|
| v0.1.0 | Initial template with dual-agent support |
| v0.4.0 | Migrated to Claude Code–only |
| v0.5.0 | Collapsed `skills/shared/` indirection — skills now real dirs |
| v0.5.1 | Merged `SYNC_RULES.md` into `CLAUDE.md`, stripped stack assumptions |
| v0.6.0 | Added `SETUP.md`, Expo Router variant, `architecture.variant` config |

---

## License

MIT
