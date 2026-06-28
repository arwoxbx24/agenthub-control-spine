---
artifact_id: agenthub-model-truth-proof-policy
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

# AgentHub Model Truth Proof Policy

## Accepted model proof types

- `codex_compliance_api_event`
- `codex_usage_delta`
- `codex_client_session_metadata`
- `codex_cli_json_event_with_model`
- `codex_remote_app_server_trace`
- `api_response_metadata`
- `fallback_model_receipt`

## Rejections

- env-only claim
- requested/resolved model text
- sandbox-only execution traces
- request-only artifacts without usage proof
- prompt dumps used as model truth

## Closure behavior

- PASS/DONE requires model truth proof of accepted type and a non-empty reference.
- `usage_audit_access=false` is not equivalent to proof and must not be faked as PASS/DONE.
- `gpt-5.5` code/config execution without model escalation receipt is rejected.
