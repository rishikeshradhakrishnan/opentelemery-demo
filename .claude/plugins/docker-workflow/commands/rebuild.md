---
name: rebuild
description: Rebuild and restart a single service for development iteration
allowed-tools: Bash(docker compose *), Bash(make redeploy *)
argument-hint: "<service-name>"
---

## Context

- Running services: !`docker compose ps --format "{{.Service}}: {{.Status}}" 2>/dev/null | head -15`
- Recent changes: !`git diff --name-only HEAD~1 2>/dev/null | grep "^src/" | head -10`

## Your Task

Rebuild and restart a single service for quick development iteration.

### If no service specified:

1. Check recent git changes to suggest which service might need rebuilding
2. Ask user which service to rebuild using AskUserQuestion

### Rebuild Process

Use the project's `make redeploy` command which handles the full cycle:

```bash
# Recommended: Use make redeploy
make redeploy service=<service-name>

# This is equivalent to:
docker compose build <service>
docker compose stop <service>
docker compose rm --force <service>
docker compose create <service>
docker compose start <service>
```

### Quick Reference: Service to Directory Mapping

| Service | Source Directory | Language |
|---------|------------------|----------|
| frontend | src/frontend/ | Node.js |
| cart | src/cart/ | .NET |
| checkout | src/checkout/ | Go |
| payment | src/payment/ | Node.js |
| product-catalog | src/product-catalog/ | Go |
| recommendation | src/recommendation/ | Python |
| ad | src/ad/ | Java |
| shipping | src/shipping/ | Rust |
| currency | src/currency/ | C++ |
| email | src/email/ | Ruby |
| quote | src/quote/ | PHP |
| fraud-detection | src/fraud-detection/ | Java/Kotlin |

### After Rebuilding

1. Check the service started correctly: `docker compose ps <service>`
2. View logs if needed: `/logs <service>`
3. Test the functionality in the UI at http://localhost:8080/

### Tips

- For frontend changes, the service auto-reloads in dev mode
- For backend changes, always rebuild to pick up code changes
- If rebuild fails, try with `--no-cache`: `docker compose build --no-cache <service>`
