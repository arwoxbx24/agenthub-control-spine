---
artifact_id: prompt-idempotency-replay-guard-coverage-20260612
artifact_type: registry_coverage
source_task: AH-773
run_id: RUN-AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-20260612
created_at: 2026-06-12
lifecycle_status: active_control_coverage
---

# Prompt Idempotency Replay Guard Coverage

| Path | Coverage |
| --- | --- |
| `schemas/prompt_idempotency_record.schema.json` | Replay decision and idempotency ledger schema |
| `schemas/prompt_frontmatter_identity.schema.json` | Serious prompt identity frontmatter schema |
| `validators/prompt_idempotency_replay_guard_validator.rb` | Deterministic fixture validator |
| `evals/prompt-idempotency-replay-guard/fixtures.json` | Positive and negative replay cases |
| `runbooks/prompt-idempotency-replay-guard.md` | Execution runbook |
| `reports/receipts/AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-RECEIPT-20260612.md` | Receipt |
| `reports/validations/AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-VALIDATION-20260612.md` | Validation |

## Register Decision

This control prevents duplicate execution for resent prompts that have the same prompt UID, source task, scope signature, repo, target branch, and artifact path hash.