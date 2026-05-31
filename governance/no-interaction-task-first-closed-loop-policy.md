---
artifact_id: no-interaction-task-first-closed-loop-policy
artifact_type: governance-policy
source_task: AH-P0-NO-INTERACTION-TASK-FIRST
run_id: RUN-P0-NO-INTERACTION-TASK-FIRST-20260531
status: active
default_load: false
safe_to_replay: false
---

# No-Interaction Task-First Closed Loop Policy

This policy hardens AgentHub runs that already passed initial capture. It turns
routine user interruptions into internal run events, requires task and technical
assignment gates before mutation, and blocks final Done until task, evidence,
register, and validation readbacks agree.

## Architecture

AgentHub uses two fronts.

1. User Front Controller:
   - may ask focused intake questions only during `INTAKE_CAPTURE`;
   - queues later user messages as `RUN_USER_INPUT_QUEUE` events;
   - emits user-facing text only in terminal states.

2. Backend Closed Loop:
   - binds or creates the YouTrack contour;
   - writes the technical assignment before mutation;
   - dispatches bounded workers and verifiers;
   - records evidence, validation, task readback, registers, and PR queue state;
   - aggregates final output only after all gates pass.

## Lifecycle States

Allowed states:

- `INTAKE_CAPTURE`
- `TASK_BOOTSTRAP`
- `TECHNICAL_ASSIGNMENT`
- `ACTIVE_RUN`
- `INTERNAL_BLOCKER_REMEDIATION`
- `VALIDATION`
- `FINAL_AGGREGATION`
- `DONE_WITH_EVIDENCE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `SAFETY_QUARANTINE`
- `EXPLICIT_USER_STOP_OR_ROLLBACK`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `FORBIDDEN_SCOPE_BLOCKER`
- `INSTRUCTION_SOURCE_DRIFT`

Only these states may emit user-facing text:

- `INTAKE_CAPTURE`
- `DONE_WITH_EVIDENCE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `SAFETY_QUARANTINE`
- `EXPLICIT_USER_STOP_OR_ROLLBACK`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `FORBIDDEN_SCOPE_BLOCKER`
- `INSTRUCTION_SOURCE_DRIFT`

`ACTIVE_RUN`, `TASK_BOOTSTRAP`, `TECHNICAL_ASSIGNMENT`,
`INTERNAL_BLOCKER_REMEDIATION`, `VALIDATION`, and `FINAL_AGGREGATION` must route
messages to internal logs, task comments, receipts, or PR queue records.

## Task-First Gate

Before any mutation, the run must prove:

- one controlling task or accepted physical task-route blocker exists;
- duplicate check is recorded;
- parent/child relation is recorded when child work exists;
- technical assignment exists;
- acceptance gates and rollback/checkpoint are recorded;
- forbidden zones are declared.

A GitHub PR, local test, sandbox wrapper PASS, or report is not task Done.
Parent Done is denied while implementation children remain open, failed,
unvalidated, or blocked unless the parent is explicitly tracking-only.

## User Input Queue

User messages received after execution starts must become queue events classified
as one of:

- `SCOPE_REINFORCEMENT`
- `SCOPE_CORRECTION`
- `NEW_RELATED_REQUIREMENT`
- `NEW_UNRELATED_REQUEST`
- `SAFETY_WARNING`
- `EMERGENCY_STOP`
- `ROLLBACK_REQUEST`
- `OWNER_CREDENTIAL_OR_AUTHORITY_INPUT`
- `NOISE_OR_DUPLICATE`

Routine classes must not produce user chat. `EMERGENCY_STOP` and
`ROLLBACK_REQUEST` may stop mutation and enter a terminal state. Owner-only
credential or authority input may surface only when no safe autonomous route
exists.

## Worker Aggregation

Spawned/subagent workers return evidence to the aggregator, not to user chat.
The aggregator must require requested/resolved/actual model proof, exact scope,
forbidden actions, artifact hash, and independent verification before Done.
Partial worker patches are not completion evidence.

## Blockers

Allowed terminal blockers are exact and typed:

- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `SAFETY_QUARANTINE`
- `EXPLICIT_USER_STOP_OR_ROLLBACK`
- `FORBIDDEN_SCOPE_BLOCKER`
- `INSTRUCTION_SOURCE_DRIFT`
- `READY_BLOCKED_BY_PLATFORM_GATE`

Routine PR queue, task comment, register, validation, model fallback, duplicate
search, or missing proof gaps must become same-run remediation work, not owner
chat.

## Done Gate

`DONE_WITH_EVIDENCE` requires:

- task contour and duplicate check;
- technical assignment;
- no mid-cycle user-chat leakage;
- user-input queue coverage;
- parent/child Done gate;
- subagent/model proof gate;
- artifact lifecycle and PR queue coverage;
- validator/eval PASS;
- secret scan PASS;
- task readback or exact platform blocker;
- final receipt.
