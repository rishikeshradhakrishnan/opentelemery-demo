#!/bin/bash

# Script to reset changes to 'main' or 'original' branch

set -e

TARGET_BRANCH="${1:-main}"

# Validate branch name
if [[ "$TARGET_BRANCH" != "main" && "$TARGET_BRANCH" != "original" ]]; then
    echo "Error: Invalid branch. Use 'main' or 'original'"
    echo "Usage: $0 [main|original]"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Check if target branch exists
if ! git rev-parse --verify "$TARGET_BRANCH" > /dev/null 2>&1; then
    echo "Error: Branch '$TARGET_BRANCH' does not exist"
    exit 1
fi

echo "This will reset all changes to branch '$TARGET_BRANCH'"
echo "WARNING: All uncommitted changes will be lost!"
read -p "Are you sure? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted."
    exit 0
fi

echo "Resetting to '$TARGET_BRANCH'..."
git reset --hard "$TARGET_BRANCH"
git clean -fd

echo "Done. Working directory reset to '$TARGET_BRANCH'"
