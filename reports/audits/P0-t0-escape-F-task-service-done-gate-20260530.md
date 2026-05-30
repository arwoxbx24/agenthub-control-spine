---
artifact_id: P0-t0-escape-F-task-service-done-gate-20260530
artifact_type: audit_report
source_task: 3-640
run_id: RUN-P0-T0-ESCAPE-ORCHESTRATION-BOUNDARY-AUDIT-20260530
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
created_at: 2026-05-30
---

# Microtask F - Task Service And Done Gate Audit

## Result

Final state: `TASK_SERVICE_DONE_GATE_DEFECT`.

## Evidence

- Task-service MCP is installed and returned a contract response.
- `ensure_request_task` for this audit returned `NOOP` / `non_actionable`, so a YouTrack draft `3-640` was created as fallback.
- Prior AH-602 readback returned no physical issue for `AH-602` in the visible YouTrack route.
- Existing validators and policies deny Done from sandbox-only proof, PR-only evidence, open children, or missing readback.

## Defect

Task-service policy exists, but the physical task route can fail to materialize actionable work while still returning `PASS`. That creates a gap for task readback and parent/child closure.

## Required Repair

`ensure_request_task` must either create/link a physical task with readback or return `TASK_SERVICE_ROUTE_UNAVAILABLE`, not `NOOP`, for actionable P0 audits. Done must stay impossible without physical task readback or a typed unavailable route.

## Gates

- no_secret_leak: `PASS`
- no_runtime_mutation: `PASS`
- no_product_code_mutation: `PASS`
