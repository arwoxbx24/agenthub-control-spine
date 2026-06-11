---
artifact_id: agenthub-blocker-inversion-scoped-self-healing-policy-20260611
artifact_type: governance_policy
source_task: AH-745
run_id: RUN-AGENTHUB-BLOCKER-INVERSION-SCOPED-SELF-HEALING-20260611
status: active
---

# AgentHub Blocker Inversion Scoped Self-Healing Policy

## Purpose

Routine AgentHub blockers must become typed repair actions inside the same contour, not repeated terminal BLOCK text. Safety controls remain active; this policy replaces blind deadblocks with scoped self-healing, permission broker escalation, task lifecycle readback, validation, and receipts.

## Blocker Outcomes

- `SELF_HEALING_REPAIR_EXECUTED`: routine platform gap repaired in the same contour.
- `SCOPED_PERMISSION_ELEVATED`: exact lane/tool/scope authority granted with receipt.
- `TASK_LIFECYCLE_REPAIRED`: YouTrack stage moved and read back.
- `ROUTE_REPAIRED_AND_RETRIED_ONCE`: route repaired and retried once.
- `SAFE_TYPED_OWNER_GATE`: only irreversible owner-only action.
- `SAFETY_HARD_STOP`: secrets, destructive/global runtime risk, legal/payment/account-owner authority, or forbidden scope.

## Routine Blockers

Missing task id, stale run state, missing receipt/register/PR queue entry, missing status context, missing worker route, duplicate risk, prompt dump, and route metadata mismatch must be mapped to a repair recipe before closure.

## Loop Breaker

The same blocker may appear twice. A third occurrence triggers blocker inversion repair, not another retry, new task, new PR, or owner-facing status loop.
