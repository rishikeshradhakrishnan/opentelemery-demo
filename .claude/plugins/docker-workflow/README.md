# Docker Workflow Plugin

Docker Compose workflow automation for the OpenTelemetry Demo project.

## Features

- **Build Management**: Build specific services, skip problematic ones, handle failures
- **Service Debugging**: View logs, check health, troubleshoot containers
- **Development Iteration**: Quickly rebuild and restart single services
- **Proactive Troubleshooting**: Automatic analysis of Docker failures with fix suggestions

## Commands

| Command | Description |
|---------|-------------|
| `/build` | Build Docker images with interactive service selection |
| `/logs` | View and tail logs for specific services |
| `/health` | Check health status of all running containers |
| `/rebuild` | Rebuild and restart a single service |

## Agents

- **docker-troubleshooter**: Automatically analyzes Docker build/run failures and suggests fixes
- **service-health-checker**: Checks container health and identifies issues

## Usage

```bash
# Build services interactively
/build

# View logs for a service
/logs frontend

# Check health of all services
/health

# Rebuild a single service during development
/rebuild cart
```

## Project-Specific Knowledge

This plugin understands the OpenTelemetry Demo's:
- 30+ polyglot microservices
- Docker Compose configuration
- Common build issues (email service, ARM64 compatibility)
- Service dependencies and health checks
