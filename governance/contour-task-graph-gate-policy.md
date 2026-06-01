---
artifact_id: contour-task-graph-gate-policy
artifact_type: governance-policy
source_task: AH-CONTOUR-TASK-GRAPH-20260601
run_id: RUN-AGENTHUB-CONTOUR-TASK-GRAPH-20260601-001
status: active
default_load: false
safe_to_replay: false
---

# Contour Task Graph Gate Policy

This policy installs the AgentHub contour ledger and YouTrack task graph gate.
It prevents final owner success, unrelated continuation, or worker mutation
while any task inside the active contour is unfinished, unverified, orphaned,
duplicated, outside the stage model, or missing physical YouTrack readback.

## Decision

Adopt a `CONTOUR_ID` led task graph for every actionable AgentHub run. A
contour may have multiple tasks, but every task must be attached to exactly one
parent contour issue or a recorded sub-contour. GitHub PRs, AgentHub merge
reports, sandbox receipts, and green checks cannot close the contour unless the
YouTrack task graph is terminal.

## Required Contour Object

Every contour closure receipt must include:

- `contour_id`
- `run_id`
- `source_user_request_hash`
- `scope_signature`
- `parent_issue_id`
- `child_issue_ids`
- `allowed_directories`
- `forbidden_directories`
- `stage_inventory`
- `evidence_inventory`
- `validation_inventory`
- `blocker_inventory`
- `final_receipt`

## Canonical Stage Model

Allowed active stages:

- `Backlog`
- `Develop`
- `Review`
- `Test`

Allowed terminal stages:

- `Done`
- `Blocked`
- `Duplicate`
- `Superseded`
- `Quarantine`

Aliases must be normalized before evidence is accepted. A task is not closed by
writing `PASS`, `DONE`, or `SUCCESS` into a custom field while its stage remains
active.

## Task Graph Closure Rules

- Parent `Done` is rejected while any child remains in `Backlog`, `Develop`,
  `Review`, or `Test`.
- AgentHub merge `SUCCESS` is execution evidence only. It cannot trigger owner
  final output while YouTrack readback says any contour task is active.
- `task_id: null`, `issue_id: null`, task-service `NOOP`, or missing readback
  blocks mutation and Done.
- Duplicate scope signatures must update or link the existing task, not create
  another open task.
- More than seven active child tasks requires a T1 split/merge decision.
- A worker may update only tasks attached to its `CONTOUR_ID`.

## User And Worker Gates

- User messages during an active contour become `CONTOUR_INPUT_DELTA` events.
  They are processed at the next safe checkpoint and must not stop workers
  unless they are owner-only, safety, or explicit stop/rollback gates.
- Workers require exact writable roots before mutation. `/root/gemini-space`,
  `/root/codex-space`, `/tmp` implementation targets, DB paths, Docker data,
  proxy/firewall paths, and secret paths are forbidden unless an explicit
  contour scope expansion approves them.
- The same gate failing twice creates an architecture repair microtask or
  typed blocker. A third identical retry is rejected.
- QA evidence cannot substitute for implementation evidence.

## Done Gate

Final user output is allowed only when all are true:

- physical YouTrack readback exists for parent and children;
- every contour task is terminal;
- implementation evidence is present where implementation was in scope;
- independent validation evidence is present;
- AgentHub receipt exists;
- no orphan or duplicate open task remains;
- no forbidden path mutation appears in evidence;
- PR/register evidence is present when repository artifacts changed.

If any required task-service operation cannot physically write or read back an
issue, the contour must end with `TASK_SERVICE_PHYSICAL_WRITE_MISSING`, not
`Done`.
