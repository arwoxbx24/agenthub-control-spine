---
artifact_id: youtrack-board-lifecycle-final-done-policy-20260611
artifact_type: governance_policy
source_task: AH-743
run_id: RUN-AGENTHUB-YOUTRACK-GITHUB-BOARD-FINAL-CLOSURE-20260611
status: active
---

# YouTrack Board Lifecycle Final Done Policy

## Purpose

YouTrack is the operational task truth surface for AgentHub implementation contours. GitHub, receipts, sandbox evidence, and merged pull requests are supporting evidence only; they do not close the task unless the controlling YouTrack issue has a board stage readback of `Done`.

## Required Controls

- Every implementation contour owns exactly one controlling YouTrack issue.
- Duplicate search must run before issue creation. Matching source request, repository, branch, run id, or duplicate signature means the existing issue is reused.
- Newly created issues must include owner, RUN_ID, repository, branch, duplicate signature, evidence fields, validation fields, and Done gate text before implementation begins.
- Workers must move the issue through `Backlog -> Develop -> Review -> Test -> Done` or the mapped live board equivalents.
- A worker must read back the issue after every stage move and record stage, actor, timestamp, method, and result in the lifecycle receipt.
- Final success is blocked unless the final readback stage is `Done`.
- Parent issue closure is blocked while child implementation issues are non-terminal unless the parent is explicitly tracking-only.

## Stage Semantics

- `Backlog`: issue captured, deduplicated, and card completed.
- `Develop`: worker route accepted and implementation begins.
- `Review`: implementation artifact, PR, or patch is ready for verification.
- `Test`: validation is executing or completed and evidence is being attached.
- `Done`: implementation installed, validation passed, GitHub evidence attached, receipt recorded, and parent/child state is terminal.

## Failure Handling

- `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`: locate or create one full controlling issue, then retry once.
- `PHYSICAL_TASK_WRITE_MISSING`: enrich the card payload and retry the task-service route once.
- `COMMAND_SYNTAX_INVALID`: query field values or command suggestions, then retry once.
- `BOARD_STAGE_VALUE_UNKNOWN`: read the project field bundle and map canonical stages.
- Same gate failure twice becomes a typed architecture blocker, not another issue.

## Done Gate

The final report parser must reject `Done`, `PASS`, `success`, `green`, and equivalent closure claims unless the lifecycle receipt contains `final_stage_readback: Done`, validation evidence, GitHub metadata, duplicate-check evidence, and no active blocker.
