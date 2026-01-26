#!/bin/bash
# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0
#
# Dockerfile validation hook
# Checks for common issues in Dockerfile edits

set -e

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

# Only check Dockerfiles
if [[ ! "$FILE_PATH" =~ Dockerfile ]]; then
    exit 0
fi

echo "Validating Dockerfile: $FILE_PATH" >&2

# Check if file exists
if [[ ! -f "$FILE_PATH" ]]; then
    exit 0
fi

WARNINGS=""

# Check for latest tag usage
if grep -q ':latest' "$FILE_PATH" 2>/dev/null; then
    WARNINGS="${WARNINGS}WARNING: Using ':latest' tag - consider pinning to specific version\n"
fi

# Check for missing WORKDIR
if ! grep -q '^WORKDIR' "$FILE_PATH" 2>/dev/null; then
    WARNINGS="${WARNINGS}NOTE: No WORKDIR specified - consider adding one\n"
fi

# Check for root user (no USER directive)
if ! grep -q '^USER' "$FILE_PATH" 2>/dev/null; then
    WARNINGS="${WARNINGS}NOTE: No USER directive - container will run as root\n"
fi

if [[ -n "$WARNINGS" ]]; then
    echo -e "$WARNINGS" >&2
fi

exit 0
