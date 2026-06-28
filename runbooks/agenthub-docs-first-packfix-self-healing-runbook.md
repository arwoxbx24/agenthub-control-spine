---
artifact_id: agenthub-docs-first-packfix-self-healing-runbook
artifact_type: runbook
source_task: AH-763
run_id: RUN-AGENTHUB-DOCS-FIRST-VALIDATOR-ROUTE-PACKFIX-20260612
created_at: 2026-06-12
lifecycle_status: active
default_load: false
safe_to_replay: true
---

# Docs-First PackFix Self-Healing Runbook

## Purpose

Use this runbook when AgentHub needs to close a control-spine task that
touches product-behavior claims, validator execution, model-truth claims, or
YouTrack Done movement.

## Required Order

1. Bind exactly one task id and one `RUN_ID`.
2. Build a docs packet from official sources before behavior claims.
3. Classify the lane and create the authority envelope.
4. Convert routine blockers into same-RUN PackFix events.
5. Run validators only through a task-bound validator route.
6. Record command exits, schema parse, fixture results, and register coverage.
7. Move YouTrack only as far as evidence supports.
8. Do not call Done when validation, model truth, or user outcome proof is
   unresolved.

## Routine PackFix Blockers

- `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`
- `DISPATCH_TASK_GATE_MISSING`
- `YOUTRACK_READBACK_PERMISSION_MISSING`
- `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`
- `VALIDATOR_EXECUTION_NOT_RUN`
- `MODEL_FALLBACK_RECEIPT_MISSING`
- `CODEX_USAGE_AUDIT_ACCESS_MISSING`
- `T0_DIRECT_AUTHORSHIP_DEFECT`
- `T0_DIRECT_RUNTIME_MUTATION_DEFECT`
- `GITHUB_CONNECTOR_WRITE_UNAVAILABLE`

First occurrence becomes `PACKFIX_REQUIRED`. Second identical occurrence
becomes `ROUTE_REPAIR_REQUIRED`. A third identical retry is forbidden.

## Done Gate

Done requires:

- official docs packet present,
- authority envelope present,
- validators actually executed with task context,
- schemas and fixtures parse,
- register coverage present,
- model execution proof when a model execution claim is made, or explicit
  `NO_MODEL_CLAIM`,
- no active blocker.
