---
artifact_id: agenthub-youtrack-board-lifecycle-scoped-autonomy-validation-20260611
artifact_type: validation-report
owner_role: Verifier
source_task: AH-743
run_id: RUN-AGENTHUB-YOUTRACK-BOARD-LIFECYCLE-SCOPED-AUTONOMY-20260611
created_at: 2026-06-11
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# Validation Report

## Installed controls

- `governance/agenthub-youtrack-board-lifecycle-policy.md`
- `governance/agenthub-scoped-permission-elevation-policy.md`
- `schemas/youtrack_task_lifecycle_receipt.schema.json`
- `schemas/agenthub_permission_lane_manifest.schema.json`
- `schemas/youtrack_board_transition_receipt.schema.json`
- `validators/youtrack_task_lifecycle_validator.rb`
- `validators/agenthub_permission_lane_validator.rb`
- `evals/youtrack-task-lifecycle/fixtures.json`
- architecture prompt and receipt artifacts

## Fact-check

- JetBrains YouTrack Developer Portal documents command application to issues through REST command payloads using issue IDs or `idReadable` values.
- JetBrains YouTrack Developer Portal documents Agile board REST resources.
- JetBrains YouTrack REST API documentation covers custom fields and board-related resources.

## Validation gates

- `TASK_ID_PRESENT`: PASS (`AH-743`).
- `DUPLICATE_CHECK_PRESENT`: PASS (no unresolved exact duplicate found before create).
- `ISSUE_MOVED_TO_DEVELOP_ON_START`: PASS (`AH-743` created in `Develop`).
- `LANE_PERMISSION_MANIFEST_PRESENT`: PASS (schema + validator installed).
- `DESTRUCTIVE_ACTIONS_REQUIRE_LANE6_PROOF`: PASS (Lane 6 validator case rejects missing proof).
- `FINAL_ONLY_OWNER_OUTPUT`: PASS (prompt and policy enforce Russian `Fact / Action / Left`).

## Commands for implementation validator

```bash
ruby validators/youtrack_task_lifecycle_validator.rb evals/youtrack-task-lifecycle/fixtures.json
ruby validators/agenthub_permission_lane_validator.rb evals/youtrack-task-lifecycle/fixtures.json
ruby -rjson -e 'ARGV.each { |path| JSON.parse(File.read(path)); puts "json ok: #{path}" }' schemas/youtrack_task_lifecycle_receipt.schema.json schemas/agenthub_permission_lane_manifest.schema.json schemas/youtrack_board_transition_receipt.schema.json evals/youtrack-task-lifecycle/fixtures.json
```

## Residual

Register/index/PR queue rows must be updated before merge if the repository requires direct register coverage in the same PR.
