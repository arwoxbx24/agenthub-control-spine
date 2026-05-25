---
artifact_id: agenthub-safe-recovery-control-loop
artifact_type: runbook
owner_role: T0 Control Plane Registrar
source_task: AH-534
related_tasks:
  - AH-535
  - AH-536
  - AH-537
run_id: RUN-agenthub-safe-recovery-control-20260525
created_at: 2026-05-25
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Safe Recovery Control Loop

## Trigger

Use this runbook when an AgentHub/Codex run shows any of these signs:

- repeated blocker loops;
- fake Done/PASS risk;
- live adapter unavailable;
- parent task closure while children are open;
- stale prompt/report replay;
- long user-facing chat instead of compact final state;
- Docker/DB/proxy/runtime safety risk;
- 500/502 incident without an approved live worker route.

## Closed Loop

1. Normalize the request into safe operational wording.
2. Read `AGENTS.md`, `INDEX.md`, `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, current context pack, source task, and active PR.
3. Run duplicate check for tasks, PRs, branches, receipts, reports, prompts, and scope signature.
4. Reuse the existing controlling task or PR whenever one exists.
5. Classify blocker alternatives before final blocker: route repair, scope split, alternate validation, helper/control, waiver, child fix, true terminal blocker.
6. Convert missing in-scope proof into same-run microtask when the task-service route can materialize it.
7. If task-service materialization fails, do not create chat-only tasks; update the existing controlling task with the exact gate and keep the parent open.
8. Validate evidence before Done.
9. Write or update a control-spine receipt.
10. Final chat to user: only `Fact`, `Action`, `Left`.

## Task Closure Gate

Before moving any task to Done, verify:

- task id exists and matches scope;
- child tasks are Done or explicitly not implementation blockers;
- implementation evidence exists;
- validation evidence exists;
- receipt exists;
- task readback confirms final state;
- no active blocker remains;
- no forbidden surface was touched.

If any item fails, keep the task open and write the exact typed blocker.

## Live Worker Handoff

For live Docker/DB/proxy/500/502 work, dispatch only a scoped worker with:

- `task_id`, `RUN_ID`, `worker_id`, role;
- allowed services/assets;
- forbidden surfaces;
- read-only diagnostics first;
- rollback/checkpoint before mutation;
- redacted evidence output;
- endpoint validation matrix;
- typed blocker format.

If AgentHub returns `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`, the next action is platform route repair, not manual T0 shell.

## Prompt Quality Gate

A corrective prompt must score at least 85/100 across task identity, source hierarchy, role correctness, scope boundary, execution order, safety, evidence, closure, token efficiency, and final-output control. Prompts below 85 are repaired before execution. Prompts below 70 are quarantined.

## Caveman Output Gate

User-facing final output must use exactly:

```text
Fact: <verified state>
Action: <artifact/task/PR/receipt or action>
Left: <none or exact typed blocker>
```

No logs, tables, JSON, raw paths, secrets, long explanations, or emotional text in chat.