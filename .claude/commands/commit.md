---
name: commit
description: Stage and commit changes following OpenTelemetry Demo conventions. Use for incremental commits without pushing.
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
---

## Context

- Current git status: !`git status`
- Staged changes: !`git diff --cached --stat`
- Unstaged changes: !`git diff --stat`
- Recent commits: !`git log --oneline -5`

## Your task

1. Review the changes above
2. Stage relevant files (use specific file names, not `git add -A`)
3. Create a commit following the message conventions below

## Commit Message Conventions

**Format options:**
```
(type): Description
fix(service): description
feat(service): description
[service] description
```

**Types:** fix, feat, chore, build, refactor, docs

**Service scopes:** checkout, cart, frontend, payment, ad, recommendation, shipping, currency, email, quote, product-catalog, product-reviews, fraud-detection, flagd-ui, load-generator, llm, otel-collector

**Examples from this repo:**
- `(chore): Convert .NET Solution files to SLNX format`
- `fix(checkout): use span.RecordError instead of AddEvent(error)`
- `[accounting] move dbcontext to local scope - fix memory leak`
- `build(deps): bump the npm-production-dependencies group`

## Guidelines

- Keep commit messages concise but descriptive
- Include service name in scope when change is service-specific
- Use imperative mood ("fix bug" not "fixed bug")
- Don't include PR numbers in commit messages (added automatically on merge)
