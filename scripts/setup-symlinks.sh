#!/bin/bash
# Script to create symlinks for shared skills in .claude/skills/.

set -e

# Ensure directories exist
mkdir -p skills/shared
mkdir -p .claude/skills

# Create symlinks in .claude/skills pointing to skills/shared
for skill_dir in skills/shared/*; do
  if [ -d "$skill_dir" ]; then
    skill_name=$(basename "$skill_dir")

    if [ ! -L ".claude/skills/$skill_name" ]; then
      echo "Creating symlink for Claude Code: $skill_name"
      ln -s "../../skills/shared/$skill_name" ".claude/skills/$skill_name"
    fi
  fi
done

echo "Symlinks setup complete. Claude Code will use skills/shared/ as the SSOT."
