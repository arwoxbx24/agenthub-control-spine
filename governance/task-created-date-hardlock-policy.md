---
artifact_id: task-created-date-hardlock-policy
artifact_type: governance_policy
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-789
run_id: task-created-date-hardlock-20260613
created_at: 2026-06-13
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Task Created Date Hardlock Policy

## Problem

Project `AH` has a system issue timestamp `createdAt` and a custom agile-card field `Дата создания`. The custom field is not required by the YouTrack schema and some AgentHub/MCP task creation routes do not populate it. Agile cards then show an empty date even though `createdAt` exists.

## Required Task Create Flow

Every AgentHub-created YouTrack issue in project `AH` must follow this sequence:

1. `create_issue` with Type, Priority, Stage, RUN_ID, Duplicate Signature, and scope fields.
2. `get_issue` readback immediately after create.
3. Extract system `createdAt` in `yyyy-MM-dd HH:mm:ss` form.
4. If custom field `Дата создания` is empty, update it to system `createdAt`.
5. `get_issue` readback again and record both values in the receipt.

A task creation receipt is invalid if `Дата создания` is empty after this sequence.

## Backfill Rule

Existing AH issues with empty `Дата создания` may be updated only by copying their own system `createdAt`. Backfill must not alter Stage, Type, Priority, Assignee, description, comments, links, evidence fields, or Done state.

## Closure Rule

No task may be treated as fully created, routable to Done, or valid evidence unless:

```text
createdAt: <system timestamp>
Дата создания: <same timestamp or UI-rendered equivalent>
```

If the field cannot be updated, use typed blocker `TASK_CREATED_DATE_FIELD_MISSING` and keep the task open.

## Forbidden

Do not use current wall clock time for backfill. Do not overwrite an existing non-empty `Дата создания` without a separate corrective task. Do not use this policy to mutate runtime, product code, DB, proxy, Docker, firewall, PM2, DNS, SSL, or unrelated task fields.
