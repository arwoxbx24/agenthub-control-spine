---
artifact_id: AGENTHUB-CODEX-SPARK-MODEL-ROUTING-VALIDATION-20260612
artifact_type: validation_report
owner_role: T2 Codex Worker
source_task: AH-601
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# AGENTHUB Codex Spark Model Routing Truth Validation

## Verification Scope

- Gate package for strict lane-aware route proof and execution truth.
- Fixture: `evals/model-routing/fixtures/codex_spark_usage_truth_20260612.json`.
- Run id: `RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612`.

## Commands

- `ruby validators/agenthub_model_router_validator.rb evals/model-routing/fixtures/codex_spark_usage_truth_20260612.json`
- `ruby validators/model_execution_truth_validator.rb evals/model-routing/fixtures/codex_spark_usage_truth_20260612.json`

## Official Sources

- https://developers.openai.com/codex/
- https://developers.openai.com/codex/guides/using-the-cli
- https://developers.openai.com/codex/reference
- https://developers.openai.com/codex/models
- https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan

## Validation Results

| Command | Status | Cases |
|---|---|---:|
| `ruby validators/agenthub_model_router_validator.rb evals/model-routing/fixtures/codex_spark_usage_truth_20260612.json` | PASS | 7 |
| `ruby validators/model_execution_truth_validator.rb evals/model-routing/fixtures/codex_spark_usage_truth_20260612.json` | PASS | 7 |

## Gate Outcomes

- Route controls checked:
  - M2 first-attempt Spark policy;
  - 5% M0 routine-busy guard;
  - escalation receipt for `gpt-5.5` in M2;
  - explicit fallback ordering and fallback reasons.
- Execution truth controls checked:
  - `DONE`/`PASS` only when `model_truth_status` is `PROVEN` or `FALLBACK_PROVEN`;
  - blocked claim markers rejected for final states;
  - `env_only_model_claim` blocks final states.

## Run-Specific Truth Blocking

- Local T0 pre-dispatch was blocked by `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`.
- Command adapter was blocked by `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`.
- Actual Spark execution remains `NOT_PROVEN`/`BLOCKED_AUDIT_ACCESS` for this run.

## Required Follow-up

No further code/config/schema/validator mutation is required in this scope.
