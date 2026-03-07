#!/bin/bash
# Script to create symlinks for shared skills in both .agent and .claude directories.

set -e

# Ensure directories exist
mkdir -p skills/shared
mkdir -p .agent/skills
mkdir -p .claude/skills

# Move existing skills from .agent/skills to skills/shared if they exist and aren't symlinks
for skill_dir in .agent/skills/*; do
  if [ -d "$skill_dir" ] && [ ! -L "$skill_dir" ]; then
    skill_name=$(basename "$skill_dir")
    echo "Moving $skill_name to skills/shared/"
    mv "$skill_dir" "skills/shared/"
  fi
done

# Create symlinks in .agent/skills and .claude/skills
for skill_dir in skills/shared/*; do
  if [ -d "$skill_dir" ]; then
    skill_name=$(basename "$skill_dir")
    
    # Symlink for Antigravity
    if [ ! -L ".agent/skills/$skill_name" ]; then
      echo "Creating symlink for Antigravity: $skill_name"
      ln -s "../../skills/shared/$skill_name" ".agent/skills/$skill_name"
    fi
    
    # Symlink for Claude
    if [ ! -L ".claude/skills/$skill_name" ]; then
      echo "Creating symlink for Claude: $skill_name"
      ln -s "../../skills/shared/$skill_name" ".claude/skills/$skill_name"
    fi
  fi
done

echo "Symlinks setup complete. Both agents will use skills/shared/ as the SSOT."
