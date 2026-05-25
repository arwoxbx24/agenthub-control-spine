---
artifact_id: agenthub-only-execution-discipline
artifact_type: governance-control
owner_role: T0 Control Plane
source_task: AH-534
run_id: RUN-control-spine-agenthub-only-execution-discipline-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub-Only Execution Discipline

## Purpose

This control makes direct T0 runtime, shell, storage, server, and broad command execution invalid for AgentHub-governed work. AgentHub is the execution spine; YouTrack is the task spine; this repository is the receipt spine.

## Required Route

All git, runtime, server, storage, validation, report, task, and artifact work that is in AgentHub scope must route through a task-bound AgentHub path before execution.

A valid execution route has:

| Field | Required |
|---|---|
| YouTrack task id | yes |
| RUN_ID | yes |
| worker id / role | yes |
| allowed surface | yes |
| forbidden surface | yes |
| rollback or checkpoint rule | yes when mutation is possible |
| validation contract | yes |
| evidence output | yes |
| control-spine receipt | yes before Done |

## Hard Rules

- T0 direct shell mutation invalidates the run.
- T0 direct runtime, server, Docker, database, proxy, storage, package, Git, GitHub, or broad filesystem mutation outside AgentHub invalidates the run.
- Worker runtime execution requires an AgentHub task/run/worker/evidence receipt before it can be accepted.
- Report or receipt missing in this repository means no Done.
- Chat-only reports are not closure evidence.
- Wrapper PASS, task creation, or blocker text is not Done.
- If the AgentHub execution adapter is unavailable, the run is not allowed to fall back to direct shell; it must create or update a platform remediation task and write a control-spine receipt.

## Invalidation Classes

The following exact classes are mandatory in receipts and blockers:

| Class | Meaning | Required action |
|---|---|---|
| `DIRECT_SHELL_MUTATION_BY_T0` | T0 used direct shell for mutation or cleanup. | Mark run invalid, quarantine evidence, create remediation receipt. |
| `DIRECT_RUNTIME_MUTATION_WITHOUT_AGENTHUB` | Runtime/server mutation occurred outside AgentHub route. | Mark run invalid or blocked and route remediation. |
| `YOLO_RUNTIME_MODE_FORBIDDEN` | Agent attempted urgency-based bypass of route/safety gates. | Stop bypass, register blocker, continue only through AgentHub. |
| `NO_CONTROL_SPINE_RECEIPT` | No repo receipt exists for a scoped run. | No Done; write or update receipt. |
| `CHAT_REPORT_INSTEAD_OF_REPO_RECEIPT` | Agent wrote chat status instead of repository evidence. | Convert to receipt microtask. |
| `REPORT_THEN_STOP_LOOP` | Agent stopped after a report/blocker without remediation path. | Continue same RUN if safe, otherwise remediation task. |
| `FAKE_DONE_FROM_REPORT` | Agent claimed Done from report or task creation only. | Reopen/mark invalid; require evidence. |
| `BROAD_COMMAND_WITHOUT_TASK` | Broad command ran without task/run/worker contract. | Invalidate run and record exact surface. |
| `UNSAFE_STORAGE_WRITE` | Storage/object/artifact mutation happened without route/receipt. | Block Done and create remediation receipt. |
| `IMAGE_OR_LINK_NOT_VALIDATED` | Delivered image/link/artifact lacked validation. | Block Done until validation or typed blocker. |
| `TASK_SERVICE_WRITEBACK_BYPASS` | Task service state was changed outside approved route. | Mark route invalid and repair task evidence. |
| `AGENTHUB_EXECUTION_ADAPTER_UNAVAILABLE` | AgentHub cannot execute the required worker adapter. | Create/update platform remediation task; no direct fallback. |

## Run Invalidation Rule

If any class above occurs:

1. Mark the run `INVALID` or `BLOCKED` in the receipt.
2. Do not claim Done.
3. Write or update the control-spine receipt.
4. Update the YouTrack task with the exact blocker.
5. If a safe route remains, continue through the same RUN as a remediation microtask.
6. If no safe route remains, create or update a platform remediation task and stop without asking Andrew for routine clicks.

## Continuous Agent Cycle

A report is not the end of work. The cycle ends only in one of these states:

- `DONE_WITH_EVIDENCE`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `FORBIDDEN_SCOPE_BLOCKER`
- `WRONG_TASK`

Vague blocked states are invalid.

## Reporting Rule

Every AgentHub/Codex run that touches tasks, prompts, reports, repository artifacts, runtime, server, or validation must produce or update a control-spine receipt.

Reports, receipts, and prompts are `default_load=false` unless `ARTIFACT_REGISTER.md` explicitly says otherwise.
