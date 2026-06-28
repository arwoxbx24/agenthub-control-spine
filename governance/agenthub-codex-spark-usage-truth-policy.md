---
artifact_id: agenthub-codex-spark-usage-truth-policy
artifact_type: governance_policy
owner_role: T1 Architecture Broker / Truth Redteam / Verifier
source_task: AH-601
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Codex Spark Usage Truth Policy

AgentHub must not claim Codex Spark ran unless an actual-model proof source exists.

## Official Fact Base

Official OpenAI Codex docs are the source for Codex CLI model flags, model catalog inspection, config precedence, Spark availability, sandbox/approval behavior, and plan usage reporting.

Recorded official sources:

- `https://developers.openai.com/codex/models`
- `https://developers.openai.com/codex/config-basic`
- `https://developers.openai.com/codex/cli/reference`
- `https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan`
- `https://developers.openai.com/codex/agent-approvals-security`

## Accepted Actual-Model Proof Types

- `codex_compliance_api`
- `codex_usage_page_delta`
- `codex_client_session_metadata`
- `api_response_metadata`
- `owner_analytics_readback`

`not_available` is a valid blocker marker only. It is not proof.

## Rejected Proof Types

- `AGENTHUB_REQUESTED_MODEL`
- `AGENTHUB_RESOLVED_MODEL`
- env variables
- wrapper log text
- sandbox dispatch receipt
- command construction text
- model catalog visibility
- entitlement or plan availability
- general agentic usage depletion

Actual-model proof is tied to the real invocation artifact for this run. `AGENTHUB_REQUESTED_MODEL`, `AGENTHUB_RESOLVED_MODEL`, or request/response logs never substitute for execution telemetry.

## Truth Status

Allowed statuses:

- `PROVEN`
- `FALLBACK_PROVEN`
- `NOT_PROVEN`
- `BLOCKED_AUDIT_ACCESS`

Final PASS/DONE is allowed only for `PROVEN` or `FALLBACK_PROVEN`. Otherwise the final state must be one typed blocker.
