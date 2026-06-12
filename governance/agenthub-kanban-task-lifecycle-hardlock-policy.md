---
artifact_id: agenthub-kanban-task-lifecycle-hardlock-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker / T0 Registrar
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Kanban Task Lifecycle Hardlock Policy

## Purpose

Force every actionable AgentHub contour to use one physical YouTrack task, one RUN_ID, explicit owner binding, stage readback, evidence, validation, receipt, and no-blocker proof before Done.

## Canonical chain

`Backlog -> Develop -> Preview -> Test -> Done`.

Compatibility aliases:

- `Todo` maps to `Backlog`.
- `In Progress` maps to `Develop`.
- `Review` maps to `Preview`.
- `Closed`, `Resolved`, and custom Done strings map to `Done` only when the Done gate passes.

## Rules

1. No implementation without a controlling issue.
2. No issue creation without duplicate signature search.
3. A task created by an agent must not remain in Backlog once work starts.
4. Stage movement requires readback after each transition.
5. Parent Done is forbidden while child implementation tasks remain non-terminal unless the parent is explicitly tracking-only.
6. Done requires implementation evidence, validation evidence, tool receipt, explicit `NO_BLOCKER`, register coverage when artifacts changed, PR queue coverage when PR exists, and final readback.
7. Task creation, PR creation, sandbox proof, HTTP 200, or prompt installation alone is not Done.

## Same-RUN repair

Routine lifecycle defects become PackFix events inside the same RUN:

- `TASK_GARBAGE_DEFECT`
- `YOUTRACK_STAGE_READBACK_REPAIR_REQUIRED`
- `DONE_GATE_FIELD_NORMALIZATION_REQUIRED`
- `DUPLICATE_TASK_GATE_FAILED`

Only owner-only irreversible gates may stop in user chat.
