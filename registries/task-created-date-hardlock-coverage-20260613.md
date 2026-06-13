---
artifact_id: task-created-date-hardlock-coverage-20260613
artifact_type: registry_coverage
source_task: AH-789
run_id: task-created-date-hardlock-20260613
created_at: 2026-06-13
lifecycle_status: active_control_coverage
default_load: false
safe_to_replay: false
---

# Task Created Date Hardlock Coverage

| Path | Type | Coverage |
|---|---|---|
| `governance/task-created-date-hardlock-policy.md` | policy | Requires `Дата создания` after task create and backfill from `createdAt`. |
| `schemas/task-card.schema.json` | schema | Adds required `created_at` and `custom_created_date`. |
| `schemas/task_created_date_hardlock.schema.json` | schema | Encodes created-date decisions and blockers. |
| `validators/task_created_date_hardlock_validator.rb` | validator | Blocks missing/mismatched created-date evidence. |
| `evals/task-created-date-hardlock/fixtures.json` | fixtures | Covers missing date, backfill required, pass, mismatch. |
| `reports/validations/AH-789-task-created-date-hardlock-validation-20260613.md` | validation | Readback validation and backfill summary. |
| `reports/receipts/AH-789-task-created-date-hardlock-receipt-20260613.md` | receipt | Implementation and backfill receipt. |

## Backfill Scope

Backfill changed only custom field `Дата создания` for AH issues created during the current week where the field was empty. Source value was each issue's own system `createdAt`.
