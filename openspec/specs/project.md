# Project Specification: Agent Collaboration

## Overview
This project relies on a dual-agent workflow featuring Antigravity (primary IDE) and Claude Code (CLI/Extension fallback). 

## Rules of Collaboration
- **Antigravity-First Rules**: Antigravity is the primary driver for major IDE-centric refactors, system planning, and holistic cross-file changes.
- **Claude Fallback**: Claude Code is utilized for quick CLI-based iterations, hyper-focused file fixes, or extension-based tasks.
- **Seamless Handoffs**: Smooth transitions between models are guaranteed by OpenSpec. The working state must ALWAYS reside in `openspec/`.

## SSOT (Single Source of Truth)
- All context lives in `openspec/config.yaml` and `openspec/specs/`.
- Hand-offs between Antigravity and Claude require zero additional prompting if the `openspec/` directory is accurately maintained. Both agents are instructed by `AGENTS.md` and `CLAUDE.md` to parse `openspec/` upon starting a task.
