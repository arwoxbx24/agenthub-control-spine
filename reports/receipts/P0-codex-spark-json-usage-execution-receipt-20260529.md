---
artifact_id: P0-codex-spark-json-usage-execution-receipt-20260529
artifact_type: operational-receipt
owner_role: T2 Codex Spark Worker / Registrar
source_task: AH-601
run_id: agenthub-emergency-worker-route-unblock-codex-spark-json-20260529-0819
created_at: 2026-05-29
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark JSON Usage Execution Receipt

receipt_id: P0-codex-spark-json-usage-execution-receipt-20260529

task_id: AH-601

run_id: agenthub-emergency-worker-route-unblock-codex-spark-json-20260529-0819

worker_id: W-codex-spark-json-event-proof-01

requested_model: gpt-5.3-codex-spark

actual_model: inferred_from_codex_cli_explicit_model_binding

fallback_used: false

model_invocation_receipt_or_usage_telemetry: codex_cli_json_usage_receipt

usage_input_tokens: 27158

usage_output_tokens: 823

proof_artifact_path: @agenthub-runs/codex-spark-json-event-proof-20260529-0819/spark-json-proof.json

proof_artifact_hash: e397568b10627f09cc6cd9cc08bce42df832d588084f2538bb6318ec92ee4165

event_receipt_path: @agenthub-runs/codex-spark-json-event-proof-20260529-0819/spark-codex-events.jsonl

event_receipt_hash: aeb18747b7a092eb1b5902e846e95bfefd1eafafd29061b9ff23db094f54ac52

no_secret_leak: PASS

no_runtime_mutation: PASS

T0_no_code_authoring: PASS

primary_model_no_code_authoring: PASS

final_state: SPARK_CODEX_CLI_JSON_USAGE_PROVEN

residual_blocker: none_for_local_invocation

