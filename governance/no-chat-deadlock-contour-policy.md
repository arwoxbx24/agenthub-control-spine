---
artifact_id: no-chat-deadlock-contour-policy
artifact_type: governance-policy
source_task: AH-P0-NO-CHAT-DEADLOCK-CONTOUR
run_id: RUN-P0-NO-CHAT-DEADLOCK-CONTOUR-20260531
status: active
default_load: false
safe_to_replay: false
---

# No-Chat Deadlock Contour Policy

This policy binds prior no-interaction, boundary/backup, Codex-native, and
task-first controls into one AgentHub contour gate. It prevents mid-cycle user
chat, user-message stop events, forbidden path drift, repeated bad spawning,
model-route ambiguity, task-service fake Done, and long final reports.

## Required Contour Gates

Every implementation contour must enforce:

- `NO_MID_CYCLE_USER_CHAT`
- `TASK_FIRST_BEFORE_MUTATION`
- `TZ_SCOPE_FIRST_BEFORE_WORKER`
- `LIVE_PATH_ONLY_OR_TYPED_BLOCKER`
- `FORBIDDEN_DIRECTORY_BLOCK`
- `USER_DELTA_QUEUE_INSTEAD_OF_STOP`
- `DEADLOCK_BREAKER_AFTER_TWO_FAILURES`
- `MODEL_ROUTE_RECEIPT_REQUIRED`
- `SPAWN_RECEIPT_REQUIRED_FOR_SPAWNED_WORK`
- `NO_FAKE_PASS_OR_PARTIAL_DONE`
- `API_DOCUMENTATION_FIRST`
- `T0_CONTROL_PLANE_ONLY`
- `FINAL_USER_MESSAGE_ONLY_AFTER_DONE_OR_TRUE_BLOCKER`

## User Delta Queue

After `RUN_ID` and task/TZ acceptance, user messages are not direct execution
commands. They become `USER_DELTA_QUEUE` entries classified as:

- `SCOPE_CHANGE`
- `CORRECTION`
- `WRONG_INPUT`
- `URGENCY`
- `OWNER_ONLY_GATE`
- `ABUSE_NOISE`
- `VALIDATION_DATA`

Only `OWNER_ONLY_GATE`, safety quarantine, explicit stop/rollback, or source
drift may stop the contour. All other deltas are applied at the next safe
checkpoint as task or TZ addenda.

## TZ Before Worker

Mutation is denied unless a technical assignment exists with task id, RUN_ID,
scope signature, allowed paths, forbidden paths, live path proof rule,
rollback/checkpoint, validation matrix, API/docs-first decision, and evidence
format.

## Deadlock Breaker

A deadlock exists when:

- the same gate fails twice;
- the same worker returns the same blocker twice;
- two spawn attempts fail due to context window;
- a worker touches a non-live path;
- QA returns `NOT_PROVEN` after implementation says `PASS`;
- requested and actual model differ without approved fallback;
- task-service cannot produce a physical issue id while Done is requested;
- the user repeats a no-chat/continue instruction during active work.

After deadlock detection, identical retry is blocked. T1 must create an
architecture repair microtask, compact context, or typed blocker.

## Model And Spawn Receipt

Implementation workers must record requested, resolved, and actual model. If
work is spawned, `spawn_receipt` must be non-default and must include role,
task/RUN, model, scope, and evidence. `agenthub-sandbox-worker` is not Spark
proof for Spark-mandatory work.

## Final Output Compressor

Final owner output must be Russian and exactly:

```text
Fact: <one line>
Action: <one line>
Left: <none or exact typed blocker>
```

Logs, reports, PR matrices, raw URLs, and technical dumps are rejected.
