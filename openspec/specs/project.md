# Project Specification: Agent Workflow

## Overview
This project uses a single-agent workflow with Claude Code as the sole AI agent.

## Rules of Operation
- **Claude Code** is the primary and only agent. It handles all tasks: system planning, holistic cross-file refactors, focused file edits, and CLI-based iterations.
- **Seamless Session Continuity**: Continuity across sessions is guaranteed by OpenSpec. The working state MUST always reside in `openspec/`. Claude Code reads `openspec/` at the start of every session to restore full context without additional prompting.

## SSOT (Single Source of Truth)
- All context lives in `openspec/config.yaml` and `openspec/specs/`.
- Claude Code is instructed by `CLAUDE.md` to parse `openspec/` upon starting any task.
- Cross-session state is maintained exclusively through `openspec/changes/` (active and archived) and `openspec/specs/`. Never through ad-hoc files outside this structure.
