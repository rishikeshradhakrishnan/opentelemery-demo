---
name: health
description: Check health status of all running OpenTelemetry Demo containers
allowed-tools: Bash(docker compose ps *), Bash(docker ps *), Bash(docker inspect *), Bash(curl *)
---

## Context

- Container status: !`docker compose ps 2>/dev/null`

## Your Task

Check and report on the health status of all OpenTelemetry Demo services.

### Health Check Commands

```bash
# Overview of all services
docker compose ps

# Detailed status with health
docker compose ps --format "table {{.Service}}\t{{.Status}}\t{{.Ports}}"

# Check specific container health
docker inspect --format='{{.State.Health.Status}}' <container_id>

# List unhealthy containers
docker ps --filter "health=unhealthy" --format "table {{.Names}}\t{{.Status}}"
```

### Endpoint Health Checks

Once services are running, verify key endpoints:

```bash
# Frontend (main UI)
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/

# Jaeger UI
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/jaeger/ui/

# Grafana
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/grafana/

# Feature Flags UI
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/feature/
```

### Report Format

Present findings in a clear table:

| Service | Status | Health | Notes |
|---------|--------|--------|-------|
| frontend | running | healthy | OK |
| cart | running | healthy | OK |
| email | not running | - | Skipped (slow build) |

### Common Issues

- **Unhealthy**: Check logs with `/logs <service>`
- **Restarting**: Service crashing - check logs for errors
- **Exited**: Service failed to start - likely config or dependency issue
- **Missing**: Service not started - may have been scaled to 0

### Suggested Actions

Based on findings, suggest:
- `/logs <service>` for unhealthy services
- `/rebuild <service>` for services needing restart
- `make start` if many services are down
