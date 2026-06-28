---
artifact_id: agenthub-codex-spark-model-routing-policy
artifact_type: active_policy
owner_role: T1 Architecture Broker / Verifier
source_task: AH-601
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# AgentHub Codex Spark Routing Policy

## Routing rule

All code/config/validator/schema/test/workflow/shell tasks require primary Spark route
unless Spark is explicitly unavailable and a same-run fallback proof exists.

## Spark-first enforcement

- `gpt-5.3-codex-spark` must be requested first for code/config-like tasks.
- If a non-Spark model is requested first for a code-like task, result is routed to
  `CODEX_SPARK_FIRST_ATTEMPT_REQUIRED`.
- Same-RUN fallback must return proof path and reason.

## Model truth and proof

Accepted Spark proof proofs for this lane:

- `codex_compliance_api_event`
- `codex_usage_delta`
- `codex_client_session_metadata`
- `codex_cli_json_event_with_model`
- `codex_remote_app_server_trace`
- `api_response_metadata`
- `fallback_model_receipt`

Proof markers like requested model only, env-only claims, or sandbox-only traces do not satisfy proof requirements.

## Destructive model rule

`gpt-5.5` in code-like scope requires `MODEL_ESCALATION_RECEIPT`.

