---
name: logs
description: View and tail Docker container logs for OpenTelemetry Demo services
allowed-tools: Bash(docker compose logs *), Bash(docker logs *), Bash(docker compose ps *)
argument-hint: "<service-name> [--follow] [--tail N]"
---

## Context

- Running services: !`docker compose ps --format "{{.Service}}" 2>/dev/null | sort`

## Your Task

Help the user view logs for Docker services.

### If no service specified:

Ask which service logs to view using AskUserQuestion. Show the list of running services.

### Common Log Commands

```bash
# View recent logs for a service
docker compose logs <service> --tail 100

# Follow logs in real-time
docker compose logs <service> --follow --tail 50

# View logs for multiple services
docker compose logs frontend cart checkout --tail 50

# View all logs (can be overwhelming)
docker compose logs --tail 20

# View logs with timestamps
docker compose logs <service> --timestamps --tail 100
```

### Interpreting Logs

**Common patterns to look for:**
- `ERROR` or `error` - Application errors
- `WARN` or `warning` - Potential issues
- `connection refused` - Service dependency not ready
- `health check` - Health status changes
- `OTEL` or `trace` - OpenTelemetry instrumentation messages

**Service-specific tips:**
- **frontend**: Look for Next.js build errors, API connection issues
- **otel-collector**: Check for exporter errors, dropped spans
- **kafka**: Watch for broker connectivity issues
- **payment/checkout**: gRPC connection errors to other services

### After Viewing Logs

If errors are found, suggest:
- `/health` to check overall service health
- `/rebuild <service>` to restart a problematic service
- Check dependent services if connection errors appear
