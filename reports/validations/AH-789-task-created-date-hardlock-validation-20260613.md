---
artifact_id: AH-789-task-created-date-hardlock-validation-20260613
artifact_type: validation_report
source_task: AH-789
run_id: task-created-date-hardlock-20260613
created_at: 2026-06-13
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# AH-789 Task Created Date Hardlock Validation

## Scope

Validate that AgentHub task cards no longer lose the custom YouTrack field `Дата создания` when a task is created through the MCP create path.

## Root Cause

The MCP create path populated the YouTrack system `createdAt` timestamp but did not populate the custom board-visible field `Дата создания`. The project field existed, but it was not required in the project field schema and the task-card schema did not require readback of both values.

## Installed Controls Readback

- `schemas/task-card.schema.json`: requires `created_at` and `custom_created_date`.
- `governance/task-created-date-hardlock-policy.md`: requires create -> readback -> custom date fill -> readback.
- `schemas/task_created_date_hardlock.schema.json`: defines created-date evidence and blocker states.
- `validators/task_created_date_hardlock_validator.rb`: blocks missing or mismatched created-date evidence.
- `evals/task-created-date-hardlock/fixtures.json`: covers missing, backfill-required, pass, and mismatch states.
- `registries/task-created-date-hardlock-coverage-20260613.md`: records register coverage for this control package.

## YouTrack Backfill Evidence

Backfilled only the empty custom field `Дата создания` for AH issues created during the current week. Source value for each issue was its own system `createdAt`.

Updated issues: AH-789, AH-778, AH-781, AH-788, AH-787, AH-786, AH-779, AH-785, AH-780, AH-777, AH-773, AH-772, AH-771, AH-774, AH-768, AH-767, AH-770, AH-764, AH-766, AH-762, AH-765, AH-763, AH-761, AH-760.

Validation query after backfill: `project: AH has: -{Дата создания} created: {This week}` returned zero issues.

## Security / Scope

- No production runtime mutation.
- No Docker, DB, proxy, firewall, PM2, Grafana, DNS, or SSL mutation.
- No secrets, raw env dumps, or private links stored.
- Only YouTrack task custom field `Дата создания` was updated for listed tasks.

## Result

Validation status: PASS for the AH current-week missing-date contour.
Blocker: none.
