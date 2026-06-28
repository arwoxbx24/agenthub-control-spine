---
artifact_id: AGENTHUB-CODEX-SPARK-MODEL-TRUTH-RECEIPT-20260612
artifact_type: operational_receipt
owner_role: T2 Codex Worker / Verifier
source_task: AH-601
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# AGENTHUB Codex Spark Model Routing Truth Receipt

## Scope

Added route-truth and YouTrack Done truth gates and fixtures for Spark route truth
for AH-601 / AH-748.

## New artifacts

- `governance/agenthub-codex-spark-model-routing-policy.md`
- `governance/agenthub-model-truth-proof-policy.md`
- `schemas/agenthub_model_execution_truth.schema.json`
- `schemas/agenthub_model_budget_policy.schema.json`
- `validators/agenthub_model_router_truth_validator.rb`
- `validators/agenthub_youtack_done_model_truth_validator.rb`
- `evals/flexible-authority-broker/fixtures.json`

## Validation runs

- `ruby validators/agenthub_model_router_truth_validator.rb evals/flexible-authority-broker/fixtures.json` — PASS (5)
- `ruby validators/agenthub_youtack_done_model_truth_validator.rb evals/flexible-authority-broker/fixtures.json` — PASS (3)

## Installed truths

- `env-only` Spark claim fails for final truth gate.
- Spark proof via `codex_client_session_metadata` passes.
- Usage-audit-missing is not treated as proof and goes to PackFix.
- `gpt-5.5` code-like execution requires `MODEL_ESCALATION_RECEIPT`.
- Code task passes only when first attempt is Spark and proof type is accepted.
- Done prompt-dump path is explicitly blocked for finalization.
