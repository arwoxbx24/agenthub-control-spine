---
artifact_id: teamlead-t0-role-drift-emergency-stop
artifact_type: runbook
source_task: AH-510
run_id: AH-510-T0-EMERGENCY-STOP-CONTROL-20260523
status: active
---

# TeamLead T0 Role-Drift Emergency Stop

## Procedure

1. Stop T0 direct execution immediately.
2. Identify the active issue, run, and latest user intent through control-plane readback.
3. Perform duplicate check before creating or dispatching anything.
4. Classify role drift and record the primary typed blocker when routing is not safe.
5. If implementation is still required, dispatch exactly one scoped worker by default.
6. Keep worker evidence separate from T0 control-plane evidence.
7. Do not mark Done unless implementation evidence, validation evidence, receipt, task readback, and no-blocker state all pass.
8. Send only the final compact Russian result to the user.

## Stop Rules

- If no safe MCP/control-plane route exists: `T0_CONTROL_PLANE_ROUTE_UNAVAILABLE`.
- If no safe worker route exists: `WORKER_ROUTE_UNAVAILABLE`.
- If physical tracker writeback lacks required receipt identifiers: `PHYSICAL_TASK_WRITE_MISSING`.
- If user-visible proof is missing: `USER_OUTCOME_PROOF_MISSING`.
- If evidence is incomplete: `DONE_EVIDENCE_MISSING`.

## Non-Goals

This runbook is not a product implementation guide and not a permission grant for T0 to perform live infrastructure work.
