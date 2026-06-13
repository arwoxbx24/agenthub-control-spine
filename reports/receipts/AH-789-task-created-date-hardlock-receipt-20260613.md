---
artifact_id: AH-789-task-created-date-hardlock-receipt-20260613
artifact_type: implementation_receipt
source_task: AH-789
run_id: task-created-date-hardlock-20260613
created_at: 2026-06-13
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# AH-789 Task Created Date Hardlock Receipt

## Task

Task: AH-789
RUN_ID: task-created-date-hardlock-20260613
Repository: arwoxbx24/agenthub-control-spine
Branch: agenthub/task-created-date-hardlock-20260613

## Classification

Task class: CONTROL_SPINE_REGISTRAR + YOUTRACK_TASK_SERVICE_GUARD + GOVERNANCE_IMPLEMENTATION
Role: T1 architect / registrar / verifier
Scope signature: require-and-backfill-youtrack-custom-created-date-field-from-createdAt-20260613

## Implementation Evidence

Installed governance controls:

- `governance/task-created-date-hardlock-policy.md`
- `schemas/task-card.schema.json`
- `schemas/task_created_date_hardlock.schema.json`
- `validators/task_created_date_hardlock_validator.rb`
- `evals/task-created-date-hardlock/fixtures.json`
- `registries/task-created-date-hardlock-coverage-20260613.md`
- `reports/validations/AH-789-task-created-date-hardlock-validation-20260613.md`

Backfilled empty custom `Дата создания` fields for AH issues created during the current week by copying each issue's own system `createdAt` value.

## Validation Evidence

- Branch compare from main shows six installed-control commits before receipt/validation addition.
- Coverage register readback exists on branch.
- YouTrack query `project: AH has: -{Дата создания} created: {This week}` returned zero issues after backfill.
- AH-789 readback showed custom `Дата создания` populated after update.
- No runtime/service mutation was performed.

## Redaction / Secret Status

No secrets, env dumps, private keys, tokens, or raw internal links are included.

## Done Markers

Implementation evidence: installed controls on branch `agenthub/task-created-date-hardlock-20260613` and AH current-week custom-date backfill.
Validation evidence: validation report and YouTrack zero-missing-date readback for current-week AH tasks.
Receipt: `reports/receipts/AH-789-task-created-date-hardlock-receipt-20260613.md`.
Blocker: none.
