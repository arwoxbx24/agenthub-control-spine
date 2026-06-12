---
artifact_id: agenthub-prompt-idempotency-replay-guard-receipt-20260612
artifact_type: receipt
source_task: AH-773
run_id: RUN-AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-20260612
prompt_uid: AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-FINAL-20260612
idempotency_key: AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-FINAL-20260612:AH-772:prompt-replay-prevention:arwoxbx24/agenthub-control-spine:main:required-artifacts
created_at: 2026-06-12
lifecycle_status: active_control_receipt
---

# AH-773 Prompt Idempotency Replay Guard Receipt

## Installed Controls

- `schemas/prompt_idempotency_record.schema.json`
- `schemas/prompt_frontmatter_identity.schema.json`
- `validators/prompt_idempotency_replay_guard_validator.rb`
- `evals/prompt-idempotency-replay-guard/fixtures.json`
- `runbooks/prompt-idempotency-replay-guard.md`
- `reports/receipts/AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-RECEIPT-20260612.md`
- `reports/validations/AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-VALIDATION-20260612.md`
- `registries/prompt-idempotency-replay-guard-coverage-20260612.md`

## Replay Decision

No prior installed receipt or schema was found in main before execution, and no duplicate YouTrack task was found. New execution was allowed under AH-773.

## Safety

No runtime, DB, Docker, proxy, firewall, DNS, SSL, branch-protection, secret, or destructive operation was performed.

## Result

Prompt replay prevention is installed as repository control artifacts. Future repeated prompt submissions with the same idempotency key must return `PROMPT_ALREADY_EXECUTED_NO_REPLAY` or resume the existing residual contour instead of creating duplicate tasks/PRs.