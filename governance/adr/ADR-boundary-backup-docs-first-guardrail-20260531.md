---
artifact_id: adr-boundary-backup-docs-first-guardrail-20260531
artifact_type: architecture-decision-record
source_task: AH-P0-BOUNDARY-BACKUP-DOCS-FIRST
run_id: RUN-P0-BOUNDARY-BACKUP-DOCS-FIRST-20260531
status: active
default_load: false
safe_to_replay: false
---

# ADR: Boundary, Backup, And Docs/API-First Guardrails

## Context

Prior controls already cover closed loops, no-interaction, task-first behavior,
Codex-native routing, T0 boundaries, and API/documentation-first behavior.
Observed incidents still need a single deterministic layer for forbidden path
mutation, active path mismatch, safe backup sizing, dynamic scope expansion, and
non-live evidence rejection.

## Options

### Option A: Larger Prompt

Add more wording to worker prompts.

Decision: rejected. Larger prompts increase context-window failure and do not
block action classes.

### Option B: Validator-Backed Guardrail Package

Install policy, scope manifest schema, scope expansion template, validator,
fixtures, receipt, and register coverage.

Decision: selected. It is durable, auditable, and low-risk for a repository-only
governance repair.

### Option C: Runtime Policy Firewall

Implement runtime PreToolUse/PostToolUse enforcement that rejects commands before
tool execution.

Decision: deferred unless a separate AgentHub runtime task authorizes runtime
code mutation. This run records the contract and synthetic tests without touching
live runtime.

## Consequences

Positive:

- production claims from `/root/gemini-space`, `/root/codex-space`, `/tmp`,
  mirrors, and sandbox files are rejected;
- writes outside `WRITE_ALLOWED_ROOTS` are rejected;
- workers must request scope expansion instead of writing immediately;
- mutation needs rollback proof and docs/API decision;
- huge backup and Docker/DB data-copy shortcuts are blocked.

Negative:

- live runtime hook activation remains a separate platform task if repository
  controls are not loaded by the executor;
- physical task-service creation may still depend on task-service authority.

## Rollback

Revert this run's policy, schema, template, validator, fixtures, audit, receipt,
and register entries. No product/runtime state is touched.

## Review Date

2026-06-14.
