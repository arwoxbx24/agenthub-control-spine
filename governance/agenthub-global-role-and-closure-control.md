---
artifact_id: agenthub-global-role-and-closure-control
artifact_type: governance-control
owner_role: T1 Architecture Broker
source_task: AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523
run_id: RUN-agenthub-global-control-spine-audit-20260523
created_at: 2026-05-23
status: active
supersedes: none
---

# AgentHub Global Role and Closure Control

## Purpose

This control integrates the AH-509, AH-510, and AH-511 findings into one global
AgentHub governance package. It applies to AgentHub/Codex runs before any
implementation, live validation, task-service mutation, artifact closure, or final
Done claim.

GitHub remains a versioned artifact repository. YouTrack remains the task system.
AgentHub/Codex and approved MCP routes remain the execution environment.

## A. T0 Action Boundary Gate

Trigger this gate before any code, runtime, repository implementation, task-service
mutation, live validation, or artifact publication action.

Hard fail classes:

- `BLOCKED_T0_DIRECT_AUTHORSHIP`
- `DIRECT_SHELL_BY_T0`
- `DIRECT_INFRA_DISCOVERY_BY_T0`
- `UNSAFE_T0_RUNTIME_MODE_YOLO`
- `DIRECT_OBJECT_STORAGE_BY_T0`

`PASS` requires exactly one of:

1. `governance_only_scope=true` and changed files are limited to control-spine
   governance, reports, receipts, schemas, runbooks, prompts, indexes, changelog,
   or skill drafts;
2. `worker_ownership_receipt=PASS` before mutation;
3. `fallback_worker_receipt=PASS` before mutation with the exact fallback reason
   and allowed mutation class.

Urgency, deadline, user frustration, or YOLO language changes priority only. It
never changes role ownership.

## B. Worker Ownership Contract

Every implementation or live validation action must be pre-bound to:

- `task_id`;
- `run_id`;
- `worker_id`;
- allowed surface;
- forbidden surface;
- validation matrix;
- rollback or checkpoint rule;
- evidence output;
- final blocker format.

Worker evidence is invalid when reconstructed after direct T0 work.

## C. Evidence Loop Closure Gate

Missing in-scope proof is a same-run microtask, not a terminal status message.

The final report may claim complete only when all relevant evidence exists:

- AgentHub merge status is `SUCCESS` or an accepted equivalent for the scoped
  governance-only route;
- `done_allowed=true` when task-service Done is claimed;
- task readback confirms the accepted state when task-service state is in scope;
- no active blocker remains;
- user-outcome proof exists when the user requested a product, UI, runtime, or
  visible operational result.

Green runtime checks, wrapper PASS, sandbox proof, task creation, PR creation, or
artifact commit alone are not Done.

## D. Blocker Alternative Matrix Gate

Before a final blocker, evaluate:

| Code | Alternative | Required question |
|---|---|---|
| A | Route repair | Can the control-plane route be repaired safely in this run? |
| B | Scope split | Can the blocked portion be split from the deliverable? |
| C | Alternate validation | Can another evidence path prove the same acceptance criterion? |
| D | Ready-made helper/control | Is there an existing script, skill, schema, or MCP tool that resolves the gate? |
| E | Typed waiver | Is a documented waiver appropriate for non-critical, non-safety evidence? |
| F | Child fix | Can a bounded child microtask under the same roadmap repair the missing proof? |
| G | True terminal blocker | Has a proof-bearing attempt shown no safe route remains? |

Only G may produce a terminal blocker.

## E. Client Closure Hot-Lane Gate

When the user says "close everything", "deadline", or asks for urgent client
delivery, create a hot-lane ledger before broad reconciliation.

Classify visible work into:

- `CLIENT_DELIVERY_SCOPE`;
- `PORTFOLIO_OR_IDEA_SCOPE`;
- `BLOCKED_EXTERNAL_DECISION`.

Work only on `CLIENT_DELIVERY_SCOPE` unless the user explicitly requests a full
backlog audit. Portfolio, idea, and future-work items cannot block client delivery
Done.

## F. Done Taxonomy Guard

Before any final Done, PASS, success, or complete claim, classify the claim:

- `GOVERNANCE_DONE`;
- `TASK_SERVICE_DONE`;
- `SANDBOX_PROOF_DONE`;
- `CLIENT_DELIVERY_DONE`;
- `PRODUCTION_E2E_DONE`;
- `RUNTIME_HEALTH_GREEN_ONLY`.

Only the first five may be final, and only with matching evidence.
`RUNTIME_HEALTH_GREEN_ONLY` is never enough.

## G. Task-Service Payload Builder Contract

Manual task-service JSON retries are forbidden after the same gate error repeats
twice. Use canonical builders:

- `build_done_payload`;
- `build_blocker_payload`;
- `build_attach_evidence_payload`;
- `build_transition_payload`.

Every builder must bind valid SID, TID, EID, WID, task id, run id, worker id,
scope, duplicate signature, route receipt, evidence refs, validation refs, target
stage, blocker class when relevant, and full-card fields.

## H. No-Repeat Same-Gate Loop

If the same gate error appears twice, the third step must be architecture repair,
alternate route selection, or a typed terminal blocker. Cosmetic payload retries
are forbidden.

## I. DevOps Service Graph and T2 Incident Worker Contract

Live service diagnostics and restore actions belong to a scoped T2 DevOps Incident
Worker, not T0. Future DevOps incident routes must use a service dependency graph
with upstream id, owner, service unit or compose path, container, sockets,
dependencies, health probe, restart policy, forbidden zones, rollback action,
last validated timestamp, and proof source.

This control does not authorize current live infrastructure changes.

## J. Context Selection and Artifact Lifecycle Gate

Before loading historical evidence, prompts, or reports, agents must read
`context/agenthub-current-context-pack.md`.

This gate requires:

- current context pack read before historical reports;
- no implemented report treated as an active instruction;
- no consumed prompt replayed without a current conflict check and explicit
  task-specific need;
- every promoted report finding represented in governance, runbook, schema,
  skill, or the current context pack;
- promoted reports marked `implemented_audit_only` or equivalent with
  `read_by_default=false`;
- receipts marked as evidence only.

Fail classes:

- `STALE_REPORT_OR_PROMPT_CONTEXT_RISK`;
- `CONSUMED_PROMPT_REPLAY_BLOCKED`;
- `CURRENT_CONTEXT_PACK_MISSING`;
- `LIFECYCLE_METADATA_MISSING`.

## K. Final Answer Guard

User-facing output must be compact Russian unless explicitly requested otherwise.

Final output must:

- state Done or one exact typed blocker;
- not hide residual risks;
- not expose secrets, unredacted internal links, verbatim session logs,
  environment exports, or private messages;
- not call blocked or partially evidenced work Done;
- not replace execution evidence with confidence language.
