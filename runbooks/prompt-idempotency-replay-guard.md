---
artifact_id: prompt-idempotency-replay-guard-runbook
artifact_type: runbook
source_task: AH-773
run_id: RUN-AGENTHUB-PROMPT-IDEMPOTENCY-REPLAY-GUARD-20260612
created_at: 2026-06-12
lifecycle_status: active_control
---

# Prompt Idempotency Replay Guard Runbook

## Intake

1. Parse prompt frontmatter.
2. Verify required identity fields.
3. If identity is missing, create `PROMPT_IDENTITY_MISSING_PACKFIX` before mutation.
4. Compute idempotency key from prompt UID, source task, scope signature, repo, target branch, and artifact path hash.

## Search Surfaces

Check these before mutation:

- YouTrack task fields and comments;
- `reports/receipts/`;
- `ARTIFACT_REGISTER.md`;
- `PR_QUEUE_REGISTER.md`;
- open/closed PR body and comments;
- replay ledger or metrics report when installed.

## Decisions

- `PROMPT_ALREADY_EXECUTED_NO_REPLAY`: stop as no-op and reuse receipt.
- `SAME_PROMPT_RESUME_FROM_RESIDUAL_PACKFIX`: resume existing contour only.
- `STALE_PROMPT_REPLAY_DENIED_SUPERSEDED`: deny old prompt and use superseding artifact.
- `UNSAFE_PROMPT_REPLAY_DENIED`: deny replay for runtime/secrets/DB/Docker/proxy/firewall/DNS/SSL/destructive scope unless new task/RUN authorizes it.
- `NEW_EXECUTION_ALLOWED`: continue normal task-first lifecycle.

## Guardrails

Do not create duplicate YouTrack tasks, duplicate branches, duplicate PRs, or duplicate workers for the same idempotency key. Do not overwrite newer installed controls with older prompt content. Do not print long prompt text as execution.

## Final Output

Use short Russian caveman form: Fact / Action / Left.