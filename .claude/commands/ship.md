---
name: ship
description: Commit, push, and open a PR following OpenTelemetry Demo conventions. Use when user says "commit", "ship", "create a PR", or wants to push changes.
allowed-tools: Bash(git checkout -b:*), Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*), Bash(gh pr create:*), Bash(gh pr view:*), Read, Edit
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commit messages: !`git log --oneline -10`

## Your task

Based on the above changes, execute the full git workflow:

1. **Create branch** (if on main): Use format `<type>/<service>-<description>` or `<type>/<description>`
2. **Stage changes**: Use `git add` with specific files (avoid `git add -A`)
3. **Commit**: Follow the commit message conventions below
4. **Push**: Push branch to origin with `-u` flag
5. **Create PR**: Use `gh pr create` with the PR template format below

Execute all steps. Do not pause for confirmation between steps.

## OpenTelemetry Demo Conventions

### Commit Message Format

Use one of these formats based on change type:

```
(type): Description
fix(service): description
feat(service): description
build(deps): description
[service] description
```

**Types:**
- `fix` — Bug fixes
- `feat` — New features
- `chore` — Maintenance, config changes
- `build` — Build system, dependencies
- `refactor` — Code refactoring
- `docs` — Documentation only

**Service scopes:** checkout, cart, frontend, payment, ad, recommendation, shipping, currency, email, quote, product-catalog, product-reviews, fraud-detection, flagd-ui, load-generator, llm, otel-collector

### Branch Naming

```
fix/checkout-span-error
feat/frontend-dark-mode
chore/bump-otel-packages
refactor/cart-cleanup
```

### PR Body Format

```markdown
# Changes

[Brief description of what changed and why]

## Merge Requirements

For new features contributions, please make sure you have completed the following
essential items:

* [ ] `CHANGELOG.md` updated to document new feature additions
* [ ] Appropriate documentation updates in the [docs](https://opentelemetry.io/docs/demo/)
* [ ] Appropriate Helm chart updates in the [helm-charts](https://github.com/open-telemetry/opentelemetry-helm-charts)
```

## Reminders

After creating the PR, remind the user:
- Update `CHANGELOG.md` if not already done
- Check if docs need updating at opentelemetry.io
- Check if Helm chart needs updating for docker-compose/config changes

## Error Handling

- **"nothing to commit"** — Inform user no changes detected
- **"gh: command not found"** — Ask user to install GitHub CLI: `brew install gh`
- **"branch already exists"** — Use existing branch or suggest alternative name
- **Authentication errors** — Run `gh auth login`
