# Project Setup

You cloned this template. Complete these steps before building.

---

## 1. Fill in your product vision

Edit [`openspec/PRD.md`](openspec/PRD.md) — replace all placeholder content with your actual vision, target users, and success metrics.

## 2. Update project config

Edit [`openspec/config.yaml`](openspec/config.yaml):

```yaml
version: 0.1.0          # reset to 0.1.0

architecture:
  variant: web           # web | expo  (see CONVENTIONS.md #3)
```

## 3. Update environment variables

Edit [`.env.example`](.env.example) — add the env vars your stack needs. Then:

```bash
cp .env.example .env
# fill in real values
```

## 4. Declare your architecture variant

In `openspec/CONVENTIONS.md`, Convention #3 defines two module structures:

- **Variant A** — Web / Node / Backend (default)
- **Variant B** — React Native / Expo Router

Claude Code will apply the correct structure based on `architecture.variant` in `openspec/config.yaml`.

## 5. (Optional) Clean git history

If you want a fresh history with no template commits:

```bash
rm -rf .git
git init
git add -A
git commit -m "chore: init from claude-code-project-template"
```

## 6. Open in Claude Code and start

```
/openspec-propose "initial project setup"
```

Claude will read your PRD, propose a first change, and walk you through the OpenSpec workflow from there.

---

## What's included

| Path | Purpose |
|---|---|
| `.claude/skills/` | 6 pre-installed skills (openspec-*, plantuml-ascii, find-skills) |
| `openspec/` | Single source of truth — specs, changes, conventions |
| `CLAUDE.md` | Boot instructions Claude reads at session start |
| `openspec/CONVENTIONS.md` | 4 conventions enforced across all sessions |
| `openspec/PRD.md` | Product requirements — fill this in first |
