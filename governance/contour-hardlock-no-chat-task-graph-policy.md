---
artifact_id: contour-hardlock-no-chat-task-graph-policy
artifact_type: active_policy
owner_role: T1 Architect / Registrar
source_task: AH-CONTOUR-HARDLOCK-NO-CHAT-TASK-GRAPH-20260601
run_id: RUN-CONTOUR-HARDLOCK-NO-CHAT-TASK-GRAPH-20260601
created_at: 2026-06-01
status: active
default_load: false
safe_to_replay: false
---

# Contour Hardlock No-Chat Task Graph Policy

## Decision

AgentHub execution is hardlocked to one contour from intake to final receipt.
The contour owns task graph state, worker scope, user message buffering,
model/spawn receipts, evidence, validation, registers, and final owner output.

This policy composes the existing no-interaction, no-chat deadlock, boundary
backup/docs-first, model receipt, and contour task graph controls into one
release gate. It is not a product repair policy and must not be used as
authority for live service, Docker, database, proxy, firewall, DNS, SSL, or
secret mutation.

## State Machine

Allowed contour states:

- `INTAKE`
- `CONTOUR_CREATED`
- `TASK_GRAPH_READY`
- `ARCHITECTURE_LOCKED`
- `WORKER_DISPATCHED`
- `IMPLEMENTATION_IN_PROGRESS`
- `IMPLEMENTATION_EVIDENCE_READY`
- `QA_IN_PROGRESS`
- `QA_PASS`
- `TASKS_CLOSING`
- `REGISTERS_UPDATED`
- `DONE_WITH_EVIDENCE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `PLATFORM_GATE_BLOCKED`
- `SAFETY_QUARANTINE`

User-facing final output is allowed only in:

- `DONE_WITH_EVIDENCE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `SAFETY_QUARANTINE`

`PLATFORM_GATE_BLOCKED` is an internal terminal state unless the final receipt
uses an exact typed blocker and records the next autonomous remediation task.

## Hardlock Gates

Before mutation, every contour must prove:

- physical or accepted fallback task contour;
- `RUN_ID`;
- duplicate check;
- technical assignment;
- parent/child graph or explicit no-child rationale;
- allowed and forbidden roots;
- rollback plan;
- validation matrix;
- Done gate policy;
- typed blocker policy.

During execution:

- user messages become contour deltas, not chat replies;
- routine blockers become same-run microtasks or typed platform blockers;
- T0 stays control-plane only;
- workers mutate only scoped canonical roots or official product APIs;
- `/root/gemini-space`, `/root/codex-space`, `/tmp`, Docker data, DB data,
  proxy/firewall/cert/key paths, and non-canonical mirrors are invalid
  implementation evidence by default;
- requested/resolved/actual model and non-default spawn receipt are mandatory
  for spawned implementation work;
- same-gate retry stops after two failures;
- final owner chat is blocked until contour tasks are terminal and evidence
  gates pass.

## Done

`DONE_WITH_EVIDENCE` requires:

- implementation evidence;
- independent validation evidence;
- AgentHub receipt;
- task readback or `TASK_SERVICE_PHYSICAL_WRITE_MISSING` platform blocker;
- no active blocker for Done;
- register and PR queue coverage when artifacts changed;
- no forbidden path evidence;
- no secret or raw internal transcript leakage;
- final Russian `Fact/Action/Left` output only.

If task-service physical write is unavailable, repository governance controls
may be installed and validated, but final contour closure remains
`PLATFORM_GATE_BLOCKED` with `TASK_SERVICE_PHYSICAL_WRITE_MISSING`.
