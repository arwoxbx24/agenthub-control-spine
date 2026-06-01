---
artifact_id: silent-to-done-contour-v2-policy
artifact_type: active_policy
owner_role: T1 Architect / Registrar
source_task: AH-SILENT-TO-DONE-V2-20260601
run_id: RUN-SILENT-TO-DONE-V2-20260601
created_at: 2026-06-01
status: active
default_load: false
safe_to_replay: false
---

# Silent-to-Done Contour V2 Policy

## Decision

AgentHub user-facing output is allowed only at intake or final terminal states.
All mid-contour user messages become `contour_message_buffer` events. This
policy is a release gate layered over the existing no-chat, task-first, path,
model/spawn, retry, task graph, and hardlock controls.

## User Output States

Allowed user-facing states:

- `INTAKE`, before first contour dispatch and at most three essential questions.
- `DONE_WITH_EVIDENCE`.
- `OWNER_ONLY_IRREVERSIBLE_GATE`.
- `SAFETY_QUARANTINE`.

Forbidden user-facing states:

- `CONTOUR_CREATED`
- `TASK_GRAPH_READY`
- `ARCHITECTURE_LOCKED`
- `WORKER_DISPATCHED`
- `IMPLEMENTATION_IN_PROGRESS`
- `IMPLEMENTATION_EVIDENCE_READY`
- `QA_IN_PROGRESS`
- `QA_PASS`
- `TASKS_CLOSING`
- `REGISTERS_UPDATED`
- `PLATFORM_GATE_BLOCKED`
- `FORBIDDEN_SCOPE_BLOCKER`, unless it is also owner-only irreversible.

## Task-Service Circuit Breaker

When YouTrack physical write fails:

- retry at most twice;
- create or update a local contour ledger;
- emit `TASK_SERVICE_PHYSICAL_WRITE_REPAIR_REQUIRED`;
- do not create duplicate tasks after recovery;
- do not call task Done until physical write and readback pass.

`TASK_SERVICE_PHYSICAL_WRITE_REPAIR_REQUIRED` is a platform remediation blocker,
not a business Done state.

## Worker Context Budget

Worker prompts must not contain full chat history. Worker packets are limited to
task class, `RUN_ID`, objective, allowed scope, forbidden scope, acceptance
gates, exact evidence references, and path/hash references.

## Done

Done requires task readback or the typed task-service platform blocker when the
task-service itself is the active defect. It also requires implementation
evidence, independent QA, path authority, model/spawn receipts, security scan,
register/PR queue coverage, and `NO_ACTIVE_BLOCKER`.
