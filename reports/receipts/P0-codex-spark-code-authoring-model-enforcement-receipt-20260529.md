---
artifact_id: P0-codex-spark-code-authoring-model-enforcement-receipt-20260529
artifact_type: operational_receipt
owner_role: T0 Control / T1 Architect / Registrar / Verifier
source_task: AH-590/AH-601
run_id: RUN-P0-CODEX-SPARK-CODE-AUTHORING-MODEL-ENFORCEMENT-20260529
created_at: 2026-05-29
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark Code-Authoring Model Enforcement Receipt

task_id: AH-601

requested_model: gpt-5.3-codex-spark

required_resolved_model: gpt-5.3-codex-spark

active_requirement: AgentHub code/config/YAML/shell/frontend/backend/test/IaC
authorship must use the dedicated Codex Spark model selected through the
standard Codex model selector or an equivalent AgentHub worker receipt.

misframed_prior_scope: The previous quota-page wording is not the active proof
contour for this task. It is superseded here by strict code-authoring model
selection.

wrong_task_change_classification: UNRELATED_BUT_SAFE_PRESERVE

wrong_task_execution_note: Lease/timeout sandbox auto-requeue is unrelated and
cannot satisfy Codex Spark code-authoring model proof.

installed_gate:
- `gpt-5.3-codex-spark` is the only primary code-authoring route.
- `gpt-5.3-codex` is rejected as a substitute while Spark is selectable.
- GPT-5.5/main/base/primary is rejected for implementation authorship.
- Missing requested model selector returns `CODEX_SPARK_MODEL_SELECTOR_NOT_SET`.
- Requested Spark with non-Spark actual/resolved model returns
  `CODEX_SPARK_RESOLVED_MODEL_MISMATCH`.
- Lease/requeue work cannot count as model proof.

local_runtime_config:
- `/root/.codex/config.toml` default model changed from `gpt-5.5` to
  `gpt-5.3-codex-spark` for future Codex CLI launches.

validation_results:
- `ruby validators/model_token_router_validator.rb evals/model-token-routing/fixtures.json` -> PASS, 38 cases.
- `ruby validators/model_portfolio_router_validator.rb evals/model-portfolio-routing/fixtures.json` -> PASS, 16 cases.
- `ruby validators/agenthub_action_policy_validator.rb evals/t0-direct-action-negative-tests/fixtures.json` -> PASS, 7 cases.
- `git diff --check` -> PASS.
- `gitleaks dir . --no-banner --redact --log-level warn` -> PASS.

active_blocker: none for control-spine router enforcement

safety:
- no production/runtime/service mutation in the control-spine repository.
- no Docker/Nginx/database/proxy/firewall mutation.
- no secret values recorded in this receipt.
