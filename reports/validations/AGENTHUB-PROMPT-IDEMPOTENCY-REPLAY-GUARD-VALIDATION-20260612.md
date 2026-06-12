---
artifact_id: agenthub-prompt-idempotency-replay-guard-validation-20260612
artifact_type: validation_report
source_task: AH-773
run_id: RUN-AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-20260612
created_at: 2026-06-12
lifecycle_status: validation_ready
---

# AH-773 Prompt Replay Guard Validation

| Gate | Status | Evidence |
| --- | --- | --- |
| TASK_BOUND | PASS | AH-773 |
| RUN_BOUND | PASS | RUN-AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-20260612 |
| DUPLICATE_CHECK_DONE | PASS | No matching YouTrack task, receipt, or schema existed in main before execution. |
| PROMPT_IDENTITY_SCHEMA_PRESENT | PASS | `schemas/prompt_frontmatter_identity.schema.json` |
| IDEMPOTENCY_RECORD_SCHEMA_PRESENT | PASS | `schemas/prompt_idempotency_record.schema.json` |
| VALIDATOR_PRESENT | PASS | `validators/prompt_idempotency_replay_guard_validator.rb` |
| FIXTURES_PRESENT | PASS | `evals/prompt-idempotency-replay-guard/fixtures.json` |
| RUNBOOK_PRESENT | PASS | `runbooks/prompt-idempotency-replay-guard.md` |
| NO_DUPLICATE_REPLAY_MUTATION | PASS | Fixtures require already-executed prompt to NOOP. |
| RESIDUAL_RESUME | PASS | Fixtures require partial replay to RESUME existing PackFix. |
| SUPERSEDED_DENIAL | PASS | Fixtures require superseded replay to DENY. |
| NO_LIVE_MUTATION | PASS | Repository artifacts only. |

## Result

Ready for PR merge and YouTrack readback.