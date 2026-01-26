#!/bin/bash
# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0
#
# Auto-format files after editing
# Runs appropriate formatter based on file extension

set -e

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

# Skip if no file path
if [[ -z "$FILE_PATH" ]] || [[ ! -f "$FILE_PATH" ]]; then
    exit 0
fi

# Get file extension
EXT="${FILE_PATH##*.}"

case "$EXT" in
    ts|tsx|js|jsx|json)
        # Format with prettier if available (frontend files)
        if command -v npx &>/dev/null && [[ -f "package.json" ]]; then
            if [[ "$FILE_PATH" =~ ^src/frontend/ ]] || [[ "$FILE_PATH" =~ ^src/flagd-ui/ ]]; then
                npx prettier --write "$FILE_PATH" 2>/dev/null || true
            fi
        fi
        ;;
    py)
        # Format with black/ruff if available
        if command -v ruff &>/dev/null; then
            ruff format "$FILE_PATH" 2>/dev/null || true
        elif command -v black &>/dev/null; then
            black -q "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    go)
        # Format with gofmt
        if command -v gofmt &>/dev/null; then
            gofmt -w "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
    rb)
        # Format with rubocop if available
        if command -v rubocop &>/dev/null; then
            rubocop -a "$FILE_PATH" 2>/dev/null || true
        fi
        ;;
esac

exit 0
