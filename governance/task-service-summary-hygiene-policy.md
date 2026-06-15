---
artifact_id: task-service-summary-hygiene-policy
artifact_type: governance-policy
source_task: AH-803
run_id: cleanup-stale-contours-20260615
created_at: 2026-06-15
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Task-Service Summary Hygiene Policy

Task-service must not create owner-visible tasks with placeholder summaries such as `Task-service backlog request`.

## Required Summary Contract

Every created task must have a meaningful summary before it is visible in the task manager. The summary must include at least one of:

- product or control surface;
- concrete defect or governance objective;
- parent task id or incident id;
- closure state such as stale, duplicate, superseded, or blocked owner-only gate.

## Rejected Placeholder Summaries

The following summaries are invalid for new unresolved tasks:

- `Task-service backlog request`
- `Backlog request`
- `New task`
- `Untitled`
- empty or whitespace-only summary

## Microtask Rules

Microtasks must name their purpose and parent, for example `AH-793 browser proof PackFix: test banner upload evidence`.

If a microtask becomes superseded by a parent task or merged control-spine PR, it must be renamed, closed with evidence, and marked no-blocker. It must not remain as an unresolved placeholder.

## Done Gate

Closing a placeholder cleanup task requires:

- implementation evidence;
- validation evidence;
- receipt;
- explicit `Blocker: none` or typed blocker;
- readback that no unresolved placeholder remains in the contour.

## Safety

This policy does not authorize product repository changes, production/test runtime work, workflow dispatch, Docker, database, proxy, firewall, PM2, secrets, or broad cleanup outside the task-service hygiene scope.
