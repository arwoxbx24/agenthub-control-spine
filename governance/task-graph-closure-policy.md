---
artifact_id: task-graph-closure-policy
artifact_type: governance-policy
owner_role: T0 Control Plane Registrar
source_task: AH-542
run_id: RUN-agenthub-p0-paralysis-breaker-repo-first-control-repair-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Task Graph Closure Policy

## Rules

1. Search for duplicate scope before creating a task.
2. One normalized scope has one controlling issue.
3. New child tasks are allowed only for a lane-specific worker need.
4. Duplicate tasks are linked and marked Duplicate, Superseded, Blocked, or
   Tracking as supported by YouTrack.
5. Task creation is not progress unless it is followed by route, evidence, and
   readback.
6. Parent Done is forbidden while implementation children are open, blocked,
   failed, or unvalidated.
7. A tracking-only parent may close only when all child states and evidence are
   read back and the parent does not claim implementation Done.
8. GitHub issues are not the AgentHub task tracker.

## Required Readback

Before Done, record:

- issue id and summary;
- Type, Priority, Stage;
- parent/child or duplicate links;
- implementation evidence pointer;
- validation evidence pointer;
- AgentHub RUN_ID and worker receipt;
- blocker type or `none`;
- final state.

## Invalid Done Evidence

The following cannot close a task by themselves:

- sandbox-only proof;
- PR-only or commit-only proof;
- T0-only note;
- generic wrapper PASS;
- green curl without user outcome scope;
- task creation;
- old prompt/report text.
