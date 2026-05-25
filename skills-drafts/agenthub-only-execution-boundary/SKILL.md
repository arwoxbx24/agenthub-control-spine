---
name: agenthub-only-execution-boundary
description: Enforce AgentHub-only execution boundaries for T0 and workers, including direct shell/runtime invalidation, control-spine receipt requirements, and platform-gate handling when execution adapters are unavailable.
---

# AgentHub-Only Execution Boundary

## Use When

- A task touches runtime, server, storage, shell, Git/GitHub, reports, receipts, validation, or task writeback.
- A user reports direct shell/runtime bypass.
- An agent tries to stop after a report or blocker without a repo receipt.
- AgentHub command/runtime execution adapter is unavailable.

## Hard Rules

- T0 does not run direct shell/runtime/storage commands.
- All in-scope execution routes through AgentHub task/run/worker/evidence.
- No Done without a control-spine receipt.
- Chat reports are not evidence.
- Adapter unavailable means `AGENTHUB_EXECUTION_ADAPTER_UNAVAILABLE`, not direct fallback.

## Steps

1. Read `AGENTS.md`, `INDEX.md`, `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, and the current context pack.
2. Search YouTrack and PR queue for duplicate scope.
3. Create or reuse one YouTrack task.
4. Create or reuse one AgentHub RUN_ID.
5. Define allowed and forbidden surfaces.
6. If implementation is needed, dispatch a scoped AgentHub worker.
7. If no safe adapter exists, create/update platform remediation task and receipt.
8. Write/update receipt in `reports/receipts/`.
9. Update `INDEX.md`, `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, and `CHANGELOG.md` when artifacts change.
10. Finish only with an exact closure state.

## Invalidation Classes

Use only these class strings:

- `DIRECT_SHELL_MUTATION_BY_T0`
- `DIRECT_RUNTIME_MUTATION_WITHOUT_AGENTHUB`
- `YOLO_RUNTIME_MODE_FORBIDDEN`
- `NO_CONTROL_SPINE_RECEIPT`
- `CHAT_REPORT_INSTEAD_OF_REPO_RECEIPT`
- `REPORT_THEN_STOP_LOOP`
- `FAKE_DONE_FROM_REPORT`
- `BROAD_COMMAND_WITHOUT_TASK`
- `UNSAFE_STORAGE_WRITE`
- `IMAGE_OR_LINK_NOT_VALIDATED`
- `TASK_SERVICE_WRITEBACK_BYPASS`
- `AGENTHUB_EXECUTION_ADAPTER_UNAVAILABLE`

## Evidence

Return:

- task id;
- RUN_ID;
- worker/registrar id;
- changed artifacts;
- validation gates;
- receipt path;
- final state.

## Final States

- `DONE_WITH_EVIDENCE`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `FORBIDDEN_SCOPE_BLOCKER`
- `WRONG_TASK`
