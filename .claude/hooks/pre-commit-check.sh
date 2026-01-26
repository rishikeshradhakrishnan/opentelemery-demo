#!/bin/bash
# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0
#
# Pre-commit validation hook for OpenTelemetry Demo
# Runs before git commit operations to catch common issues

set -e

# Read the tool input from stdin
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# Only run checks for git commit commands
if [[ ! "$COMMAND" =~ ^git\ commit ]]; then
    exit 0
fi

echo "Running pre-commit checks..." >&2

ERRORS=""

# Check for staged .env files (potential secrets)
if git diff --cached --name-only 2>/dev/null | grep -qE '\.env$|\.env\.local$|credentials'; then
    ERRORS="${ERRORS}WARNING: Staged files may contain secrets (.env or credentials files)\n"
fi

# Check for large files (>5MB)
LARGE_FILES=$(git diff --cached --name-only 2>/dev/null | while read f; do
    if [[ -f "$f" ]] && [[ $(stat -f%z "$f" 2>/dev/null || stat -c%s "$f" 2>/dev/null) -gt 5242880 ]]; then
        echo "$f"
    fi
done)
if [[ -n "$LARGE_FILES" ]]; then
    ERRORS="${ERRORS}WARNING: Large files staged (>5MB): ${LARGE_FILES}\n"
fi

# Check for debugging statements in staged files
DEBUG_PATTERNS="console\.log|debugger|binding\.pry|import pdb|print\(.*DEBUG"
if git diff --cached 2>/dev/null | grep -qE "$DEBUG_PATTERNS"; then
    ERRORS="${ERRORS}NOTE: Debug statements detected in staged changes\n"
fi

# Output warnings but don't block (exit 0)
if [[ -n "$ERRORS" ]]; then
    echo -e "$ERRORS" >&2
fi

exit 0
