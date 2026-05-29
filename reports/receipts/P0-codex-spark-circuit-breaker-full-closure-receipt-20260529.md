---
artifact_id: P0-codex-spark-circuit-breaker-full-closure-receipt-20260529
artifact_type: operational-receipt
owner_role: T1 Architect / T2 Control-Spine Worker / Registrar
source_task: AH-601
run_id: RUN-P0-CODEX-SPARK-CIRCUIT-BREAKER-FULL-CLOSURE-20260529
created_at: 2026-05-29
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark Circuit Breaker Full Closure Receipt

receipt_id: P0-codex-spark-circuit-breaker-full-closure-receipt-20260529

task_id: AH-601

run_id: RUN-P0-CODEX-SPARK-CIRCUIT-BREAKER-FULL-CLOSURE-20260529

circuit_breaker_status: ACTIVE

circuit_breaker_install_path: `validators/model_token_router_validator.rb`

containment_worker: W-circuit-breaker-containment-evidence-01

containment_evidence_hash: 0ffef5154de06f66f92e96f00c9c6c5743a18401c46f3b9ca1299d889325b604

active_non_codex_code_dispatches: none_reported

no_primary_model_code_authoring: PASS

T0_no_code_authoring: PASS

no_secret_leak: PASS

no_runtime_mutation: PASS

attached_spark_receipt: `reports/receipts/P0-codex-spark-json-usage-execution-receipt-20260529.md`

attached_spark_usage_input_tokens: 27158

attached_spark_usage_output_tokens: 823

proof_artifact_hash: e397568b10627f09cc6cd9cc08bce42df832d588084f2538bb6318ec92ee4165

event_receipt_hash: aeb18747b7a092eb1b5902e846e95bfefd1eafafd29061b9ff23db094f54ac52

installed_controls:

- primary model burn circuit breaker
- Spark/Codex route gate for code/config/YAML/shell surfaces
- non-Spark Codex fallback same-RUN proof gate
- command/self-report rejection gate
- zero-usage and fallback JSON proof rejection
- same-gate two-failure stop

final_state: PRIMARY_MODEL_BURN_PREVENTED_BUT_PLATFORM_BLOCKED

residual_blocker: CODEX_SPARK_EXECUTION_NOT_PROVEN_BY_PLATFORM_METRIC

owner_only_surface: owner-visible Spark subscription usage meter

