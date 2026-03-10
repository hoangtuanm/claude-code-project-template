# Specification: Modular Monolith Architecture

> **Status:** Active
> **Last Updated:** 2026-03-10

---

## Overview

All projects bootstrapped from this template MUST follow the **Modular Monolith** pattern: a single repository and deployable unit with strictly decoupled, domain-driven internal modules.

## Directory Structure

```
src/
├── modules/                     ← business domain modules
│   └── <module-name>/
│       ├── domain/              ← pure business logic, entities, rules
│       ├── infra/               ← adapters, repositories, external APIs
│       ├── ui/                  ← components, pages (if applicable)
│       ├── diagrams/            ← PlantUML source (.puml) + ASCII output (.utxt)
│       ├── index.ts             ← PUBLIC API (sole export point)
│       └── README.md            ← module documentation (embeds key diagrams)
│
├── shared/                      ← cross-cutting kernel
│   ├── config/                  ← app configuration
│   ├── types/                   ← shared type definitions
│   ├── utils/                   ← pure utility functions
│   ├── events/                  ← event contracts for cross-module comm
│   └── ui/                      ← shared UI primitives (if applicable)
│
├── app/                         ← application shell
│   ├── routes/                  ← routing / page composition
│   ├── layout/                  ← global layout (if applicable)
│   └── providers/               ← context providers, middleware
│
└── index.ts                     ← entry point
```

## Module Internal Structure

Each module under `src/modules/<name>/` follows a consistent three-layer pattern:

| Layer | Purpose | Rules |
|---|---|---|
| `domain/` | Business logic, entities, types, validation rules | **Zero external dependencies.** Pure functions and types only. No DB, no HTTP, no framework imports. |
| `infra/` | Database queries, API clients, adapters, repositories | May import from `domain/` and `shared/`. Implements interfaces defined in `domain/`. |
| `ui/` | Components, pages, views | May import from `domain/` and `shared/ui/`. Optional — omit for backend-only modules. |
| `diagrams/` | PlantUML source (`.puml`) and Unicode ASCII output (`.utxt`) | Contains architectural diagrams for the module. **Always use `-utxt` flag** for Unicode box-drawing output. |
| `index.ts` | Public API barrel export | **Only file other modules or `app/` may import from.** Exposes a curated surface area. |
| `README.md` | Module documentation | Describes the domain, key entities, public API, dependencies, and **embeds key ASCII diagrams**. Agents MUST read this before editing module code. |

## Dependency Rules (Strict)

```
  ALLOWED IMPORTS
  ═══════════════

  app/  ──────► modules/<name>/index.ts  ──────► shared/
                     │                              ▲
                     └──────────────────────────────┘

  FORBIDDEN IMPORTS
  ═════════════════

  modules/auth/  ──✗──►  modules/billing/       (no cross-module)
  modules/auth/domain/  ──✗──►  any infra/       (domain is pure)
  shared/  ──✗──►  modules/                      (kernel has no upward deps)
  anything  ──✗──►  modules/<name>/domain/       (use index.ts only)
```

### Cross-Module Communication

When Module A needs data or functionality from Module B:

1. **Shared contracts:** Define an interface or type in `shared/types/` that both modules implement.
2. **Event bus:** For async/decoupled communication, define event contracts in `shared/events/`. Module A emits, Module B subscribes. No direct coupling.
3. **App-level composition:** `app/` can import from multiple modules and compose them — this is the orchestration layer.

**NEVER** import directly from another module's internal `domain/`, `infra/`, or `ui/` folders.

## Module README Template

Each module's `README.md` should follow this structure:

```markdown
# <Module Name>

## Domain
Brief description of the business domain this module owns.

## Architecture
Embed the module component diagram (Unicode ASCII from `diagrams/module.utxt`):

(paste contents of diagrams/module.utxt here)

## Key Entities
- `Entity1` — description
- `Entity2` — description

Embed the entity class diagram (Unicode ASCII from `diagrams/entities.utxt`):

(paste contents of diagrams/entities.utxt here)

## Public API
What this module exports via `index.ts`.

## Dependencies
- `shared/types/...`
- `shared/events/...`

## Notes
Any special considerations, constraints, or design decisions.
```

## New Module Checklist

When creating a new module, agents MUST:

1. Create `src/modules/<name>/` with `domain/`, `infra/`, `diagrams/`, `index.ts`, and `README.md`
2. Add `ui/` only if the module has frontend components
3. Create a corresponding spec at `openspec/specs/<name>/spec.md`
4. Export only the public API through `index.ts`
5. Create required diagrams in `diagrams/` (see Convention #5):
   - `module.puml` → component diagram of module internals
   - `entities.puml` → class diagram of key domain entities
6. Generate Unicode ASCII output: `plantuml -utxt diagrams/*.puml`
7. Embed key diagrams (`.utxt` output) in `README.md`
8. Verify no forbidden imports exist
