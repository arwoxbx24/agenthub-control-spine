---
artifact_id: agenthub-global-control-loop-closure
artifact_type: runbook
owner_role: T1 Architecture Broker
source_task: AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523
run_id: RUN-agenthub-global-control-spine-audit-20260523
created_at: 2026-05-23
status: active
---

# AgentHub Global Control Loop Closure

## Goal

Close AgentHub work with proof-backed state, not partial status. This runbook
applies when a run touches governance artifacts, task-service state, runtime
validation, client delivery, or final Done claims.

## Procedure

1. Confirm canonical target, task class, and forbidden scope.
2. Create or read back the controlling task anchor.
3. Create one `RUN_ID`.
4. Record selected skills, route receipt, worker ownership, and validation matrix.
5. Before mutation, pass the T0 Action Boundary Gate.
6. Execute only the owned scope.
7. Record implementation evidence.
8. Run scoped validation.
9. Confirm forbidden-scope and secret-redaction gates.
10. Read back task state when task-service state is in scope.
11. Run AgentHub merge or accepted governance-only equivalent.
12. Classify Done type.
13. Produce final compact Russian output.

## Same-Run Microtask Rule

If in-scope proof is missing, create a bounded microtask in the same run for one
of these residual classes:

- `MISSING_WORKER_EVIDENCE`;
- `MISSING_IMPLEMENTATION_EVIDENCE`;
- `MISSING_VALIDATION`;
- `MISSING_TASK_READBACK`;
- `MISSING_MERGE_EVIDENCE`;
- `MISSING_SECRET_SCAN`;
- `MISSING_INDEX_OR_CHANGELOG`;
- `MISSING_FORBIDDEN_SCOPE_CONFIRMATION`.

Stop only when the missing item requires forbidden access, destructive action,
external credentials, explicit user authorization, or a repeated same-gate failure
that has already reached the no-repeat threshold.

## Blocker Classification

Before returning a terminal blocker, evaluate the A-G matrix:

1. Route repair possible?
2. Scope split possible?
3. Alternate validation possible?
4. Existing helper, script, schema, or MCP control possible?
5. Typed waiver appropriate?
6. Child fix under the same roadmap possible?
7. True terminal blocker after proof-bearing attempt?

Record the first viable route. Return a terminal blocker only when all safe routes
fail.

## Task-Service Payload Order

Use a canonical payload builder. Do not hand-assemble repeated JSON payloads after
two gate errors.

Order:

1. bind SID, TID, EID, WID, task id, run id, worker id, scope, and duplicate
   signature;
2. attach route receipt refs;
3. attach implementation evidence refs;
4. attach validation refs;
5. attach target transition or blocker class;
6. validate full-card fields;
7. execute task-service action;
8. read back task state.

## Hot-Lane Closure

For urgent client delivery or "close everything" requests:

1. Create a hot-lane ledger.
2. Bucket visible work into `CLIENT_DELIVERY_SCOPE`,
   `PORTFOLIO_OR_IDEA_SCOPE`, and `BLOCKED_EXTERNAL_DECISION`.
3. Work only on `CLIENT_DELIVERY_SCOPE`.
4. Treat portfolio, idea, and future-work items as non-blocking for client Done.
5. Create a separate full backlog audit only when explicitly requested.

## Final Closure

Final closure is allowed only when:

- the Done taxonomy claim matches the evidence;
- no active blocker remains;
- receipt exists;
- index/changelog updates exist for repository artifacts;
- no secret or raw transcript risk is present;
- no forbidden runtime, infrastructure, or client product surface was touched.
