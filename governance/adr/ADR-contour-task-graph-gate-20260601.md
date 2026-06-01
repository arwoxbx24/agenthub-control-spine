---
artifact_id: adr-contour-task-graph-gate-20260601
artifact_type: architecture-decision-record
source_task: AH-CONTOUR-TASK-GRAPH-20260601
run_id: RUN-AGENTHUB-CONTOUR-TASK-GRAPH-20260601-001
status: accepted
default_load: false
safe_to_replay: false
---

# ADR: Contour Ledger + YouTrack Task Graph Gate

## Context

AgentHub runs can produce useful execution receipts while their controlling
YouTrack issues remain open, duplicated, unverified, or missing physical
readback. That creates false final success and lets agents drift into unrelated
work. Existing no-chat, task-first, and boundary policies block parts of this
failure class, but the task graph itself needs a deterministic closure gate.

## Options

### Option A: Prompt-only reminder

Add wording that agents should close tasks before final output.

- Positive: cheap.
- Negative: weak enforcement, easy to bypass, does not catch null task ids or
  parent/child state mismatch.
- Decision: rejected.

### Option B: Contour Ledger + Task Graph Gate

Install a contour object, stage model, task graph validator, fixtures, and
receipt requirements.

- Positive: deterministic, works with existing AgentHub receipts and YouTrack
  readback, blocks fake Done without broad runtime changes.
- Negative: still depends on the task-service route being available for real
  physical issue writes.
- Decision: accepted.

### Option C: Full runtime policy engine

Move all task creation, worker state, and final output through a central
runtime policy service.

- Positive: strongest long-term enforcement.
- Negative: larger runtime integration risk and outside this repository-only
  corrective scope.
- Decision: defer; use this ADR as the contract for future runtime work.

## Consequences

- Every actionable contour has one `CONTOUR_ID`.
- Every child task must belong to the contour.
- Final user output is denied while any task remains active.
- AgentHub merge success is insufficient without YouTrack graph readback.
- Task-service physical write failure becomes a terminal typed blocker for
  closure, not a fake success.

## Rollback

Revert the policy, schema, validator, fixtures, and register entries from this
run. Existing no-chat/task-first policies remain active and are not weakened by
rollback.

## Review Date

2026-06-15.
