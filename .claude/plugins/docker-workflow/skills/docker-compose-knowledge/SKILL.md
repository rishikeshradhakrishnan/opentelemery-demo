---
name: docker-compose-knowledge
description: This skill provides deep knowledge about Docker Compose workflows for the OpenTelemetry Demo project. It should be used when the user asks about "docker", "compose", "containers", "building services", "running the demo", "service dependencies", or troubleshooting container issues in this polyglot microservices environment.
---

# Docker Compose Knowledge for OpenTelemetry Demo

## Project Docker Architecture

The OpenTelemetry Demo uses Docker Compose to orchestrate 30+ microservices. Key files:

- `docker-compose.yml` - Main orchestration (all services)
- `docker-compose.minimal.yml` - Reduced set for lighter resource usage
- `docker-compose-tests.yml` - Test configuration
- `.env` - Environment variables and versions
- `.env.override` - Local overrides (create if needed)
- `.env.arm64` - ARM64 Mac-specific settings

## Essential Commands

### Starting the Demo
```bash
make start              # Full demo with all services
make start-minimal      # Minimal configuration
make stop               # Stop all services
```

### Building
```bash
make build                        # Build all images
docker compose build <service>    # Build specific service
docker compose build --no-cache   # Force fresh build
```

### Development Iteration
```bash
make redeploy service=<name>      # Rebuild and restart one service
make restart service=<name>       # Restart without rebuilding
```

### Debugging
```bash
docker compose ps                          # Service status
docker compose logs <service> --tail 100   # View logs
docker compose logs <service> --follow     # Stream logs
```

## Service Dependencies

### Core Flow (must be running)
```
frontend-proxy (envoy)
    └── frontend (next.js)
           └── cart, checkout, payment, product-catalog, etc.
```

### Telemetry Pipeline
```
services → otel-collector → jaeger/prometheus/grafana
```

### Data Stores
```
cart → valkey (redis)
product-reviews → postgresql
fraud-detection, checkout → kafka
```

## Skipping Problematic Services

Some services have known build issues and can be safely skipped:

```bash
# Skip email (Ruby - slow bundle install)
docker compose up -d --scale email=0

# Skip currency (C++ - long compile time)
docker compose up -d --scale currency=0

# Skip multiple
docker compose up -d --scale email=0 --scale currency=0
```

## Port Mappings

All services are accessed through frontend-proxy at `localhost:8080`:

| Path | Service |
|------|---------|
| `/` | Frontend (web UI) |
| `/jaeger/ui/` | Jaeger (traces) |
| `/grafana/` | Grafana (dashboards) |
| `/loadgen/` | Load Generator UI |
| `/feature/` | Feature Flags UI |

## Environment Variables

Key variables in `.env`:

```bash
IMAGE_VERSION=latest           # Image tag
IMAGE_NAME=ghcr.io/open-telemetry/demo
OTEL_COLLECTOR_PORT=4317       # OTLP gRPC
OTEL_COLLECTOR_PORT_HTTP=4318  # OTLP HTTP
```

Create `.env.override` for local customization (gitignored).

## Troubleshooting Quick Reference

| Problem | Solution |
|---------|----------|
| Build stuck | Skip service: `--scale <service>=0` |
| Port conflict | Check: `lsof -i :<port>` |
| Stale build | Rebuild: `docker compose build --no-cache <service>` |
| Disk full | Clean: `docker system prune -a` |
| Service crash | Check logs: `docker compose logs <service>` |
| ARM64 issues | Verify `.env.arm64` loaded (automatic with make) |
