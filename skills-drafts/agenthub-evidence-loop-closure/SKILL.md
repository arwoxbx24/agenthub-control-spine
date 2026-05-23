---
name: agenthub-evidence-loop-closure
description: Prevent agents from stopping after partial implementation by turning missing proof into same-run microtasks and blocking Done until AgentHub merge evidence is successful.
owner_role: Verifier
source_task: AH-511
status: draft
---

# AgentHub Evidence Loop Closure

## Purpose

Stop the common failure mode where work is implemented, then the agent stops because evidence, task readback, or merge proof is missing.

## Trigger Conditions

- user says the agent cycle is not complete;
- runtime checks pass but AgentHub merge is missing or blocked;
- task card exists but implementation/validation evidence is incomplete;
- wrapper says PASS while receipt says BLOCKED, PARTIAL, UNKNOWN, or residuals remain;
- a final answer is being prepared.

## Core Rule

Missing in-scope proof is not a reason to stop. It becomes the next microtask in the same run.

Stop only for:

- explicit user stop;
- missing control-plane route;
- forbidden-zone need without exact gate;
- destructive action requirement;
- missing secret or external access;
- failed artifact publication when publication is required;
- repeated identical blocker after the configured retry threshold.

## Closure Sequence

1. Confirm task id and RUN_ID.
2. Confirm worker inventory is non-empty.
3. Confirm implementation evidence.
4. Confirm validation evidence.
5. Confirm forbidden-zone and secret-redaction gates.
6. Confirm task readback.
7. Run AgentHub merge.
8. If merge blocks, convert each residual into a microtask.
9. Rerun merge once new evidence exists.
10. Only then prepare final user report.

## Residual Classifier

- `MISSING_WORKER_EVIDENCE`: register worker or fallback worker evidence.
- `MISSING_VALIDATION`: run scoped validation.
- `MISSING_TASK_READBACK`: update and re-read task card.
- `FORBIDDEN_ZONE_BLOCKER`: stop with exact gate required.
- `SYNTHETIC_PROOF`: replace with real receipt or mark blocked.
- `UNRELATED_FAILURE`: do not expand scope; create separate task if needed.

## Final Report Gate

A final user report may say complete only when:

- AgentHub merge status is `SUCCESS`;
- `done_allowed=true`;
- task card is Done or equivalent accepted closure state;
- no residual blockers remain;
- user-facing summary is short and does not expose secrets or internal URLs.

## Negative Test

If the agent says "fixed" after green curl output but before merge success and task readback, this skill fails with:

```text
BLOCKED_DONE_EVIDENCE_MISSING
```
