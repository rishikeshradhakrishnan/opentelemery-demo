---
name: build
description: Build Docker images for OpenTelemetry Demo services. Shows interactive service selection.
allowed-tools: Bash(docker compose *), Bash(docker *), Bash(make *)
argument-hint: "[service names or 'all']"
---

## Context

- Available services: !`docker compose config --services 2>/dev/null | sort`
- Currently running: !`docker compose ps --format "{{.Service}}: {{.Status}}" 2>/dev/null | head -20`

## Your Task

Help the user build Docker images for the OpenTelemetry Demo.

### If no arguments provided:

Use AskUserQuestion to let the user select which services to build:

1. **All services** - Build everything (may take a while)
2. **Core services only** - frontend, cart, checkout, payment, product-catalog
3. **Specific services** - Let user specify which ones
4. **All except problematic** - Skip known slow/failing services (email, currency)

### If arguments provided:

Build the specified services directly.

### Build Commands

```bash
# Build all services
make build

# Build specific service(s)
docker compose build <service1> <service2>

# Build with no cache (for troubleshooting)
docker compose build --no-cache <service>

# Skip specific services when starting
docker compose up -d --scale email=0 --scale currency=0
```

### Known Issues

- **email service**: Ruby bundle install can be slow/stuck - suggest skipping with `--scale email=0`
- **currency service**: C++ build can be slow on first run
- **ARM64 Macs**: Java services may need `_JAVA_OPTIONS=-XX:UseSVE=0` (handled by .env.arm64)

### After Building

Suggest next steps:
- `make start` to start all services
- `docker compose up -d` to start in detached mode
- `/health` to check service status after starting
