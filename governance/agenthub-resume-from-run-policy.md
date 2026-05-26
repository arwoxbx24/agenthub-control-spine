---
artifact_id: agenthub-resume-from-run-policy
artifact_type: governance_policy
owner_role: T1 Architect
source_task: AH-590
run_id: RUN-P0-FULL-REQ-BACKEND-ONLY-ARCH-20260526
created_at: 2026-05-26
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Resume From Run Policy

## Required Checkpoint

Every actionable run must persist:

- `RUN_ID`;
- `task_id`;
- role and worker id;
- `scope_signature`;
- branch or PR if applicable;
- last completed phase;
- last receipt path;
- validation state;
- blocker state;
- pending next action;
- `safe_to_resume`;
- `replay_risk`;
- supersession link when replaced.

## Resume Order

After interruption, model switch, context loss, or worker crash:

1. read YouTrack task;
2. read AgentHub checkpoint;
3. read control-spine registers and current context;
4. read branch/PR queue;
5. continue from last completed phase.

Restarting from zero is allowed only after a corrupt-checkpoint receipt is
created.

## Same-Gate Rule

If the same gate fails twice for the same scope signature, no third retry is
allowed. Route to architecture repair or typed blocker.

