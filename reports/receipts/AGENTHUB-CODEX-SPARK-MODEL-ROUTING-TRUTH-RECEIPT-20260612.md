---
artifact_id: AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-RECEIPT-20260612
artifact_type: operational_receipt
owner_role: T2 Codex Worker
source_task: AH-601
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# AGENTHUB Codex Spark Model Routing Truth Receipt

final_state: BLOCKED_AUDIT_ACCESS
truth_gate: AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612

scope:
  task_id: AH-601
  lane_focus:
  - M0
  - M2
  - M3
  artifacts:
  - governance/agenthub-model-priority-routing-policy.md
  - governance/agenthub-codex-spark-usage-truth-policy.md
  - schemas/model_execution_truth_receipt.schema.json
  - schemas/agenthub_model_route_decision.schema.json
  - validators/model_execution_truth_validator.rb
  - validators/agenthub_model_router_validator.rb
  - evals/model-routing/fixtures/codex_spark_usage_truth_20260612.json
  - runbooks/codex-spark-proof-probe.md

validation:
  command_validator_outputs:
  - command: ruby validators/agenthub_model_router_validator.rb evals/model-routing/fixtures/codex_spark_usage_truth_20260612.json
    status: PASS
    cases: 7
  - command: ruby validators/model_execution_truth_validator.rb evals/model-routing/fixtures/codex_spark_usage_truth_20260612.json
    status: PASS
    cases: 7

evidence:
  route_gate:
    - M2 first-attempt check requires Spark in visible catalog.
    - M0 routine work requires escalation if >5% without escalation receipt.
    - M2 fallback to `gpt-5.5` requires `MODEL_ESCALATION_RECEIPT`.
  execution_gate:
    - `DONE`/`PASS` states require proof status `PROVEN` or `FALLBACK_PROVEN`.
    - Missing proof ref blocks final proof states.
    - `env_only_model_claim=true` blocks final states.

blocked_state:
  pre_dispatch_state: PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID
  adapter_state: CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED
  actual_model_truth: BLOCKED_AUDIT_ACCESS
  note: No claim is made that actual Spark execution ran in this local run from requested/resolved/env-only proof fields.

pr_status:
  pr_open: none
  reason: no_open_pr_for_this_truth_run

