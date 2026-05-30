---
artifact_id: model-token-routing-policy
artifact_type: governance_policy
owner_role: T1 Architect / Cost Controller
source_task: AH-590
run_id: RUN-P0-GLOBAL-AGENT-CONTROL-SECRETS-REPO-AUDIT-20260527
created_at: 2026-05-27
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Model Token Routing Policy

## Decision

AgentHub model selection is registry-driven. Agents must not hardcode stale model names, assume limits, or retry expensive reasoning loops for routine registrar work.

## Routing

| Task class | Required route |
|---|---|
| P0 architecture/control decision | top reasoning route, bounded source packet |
| Technical assignment / ADR | architecture route with compact evidence |
| Code/config/YAML/shell/frontend/backend/tests/IaC | Codex-capable scoped worker; prefer `gpt-5.3-codex-spark`, then `gpt-5.3-codex`, when available |
| Registrar/register/PR queue | deterministic tool or lower-cost route |
| Verifier/QA | verifier-capable route |
| Security redaction | deterministic scanner first, model second |

The complete model portfolio route map is installed in
`governance/model-portfolio-utilization-policy.md`. That policy is the
authoritative matrix for T0 pre-gateway, T1 architecture, T2 code/config,
task-service, verifier, research, and security/redaction route classes.

## Codex Spark Enforcement

Code, config, shell, YAML, frontend, backend, test, and infrastructure-as-code
tasks must route to a Codex-capable worker profile before any general reasoning
model. If `gpt-5.3-codex-spark` is available in the approved runtime registry,
the worker receipt must request and resolve to `gpt-5.3-codex-spark`. A receipt
whose actual route is `agenthub-sandbox-worker` is not Spark proof.

If primary Codex capacity is unavailable, fallback must stay in the same
`run_id` and use the approved chain: `gpt-5.3-codex`, then `gpt-5.4-mini`,
then `gpt-5.4`. The fallback receipt must include same-RUN unavailability proof
and must automatically return to Spark when Spark becomes available. T0 direct
authorship and broad general-model command loops remain forbidden.

Every dispatch receipt for implementation-capable work must include:

- `worker_model`;
- `requested_model`;
- `resolved_model`;
- `actual_route`;
- `model_route_reason`;
- `codex_available`;
- `fallback_reason` when fallback is used, otherwise `null`;
- `same_run_fallback_proof`;
- `return_to_spark_when_available`;
- token/context budget class;
- residuals.

## Loop and Budget Rules

- no full chat history to workers;
- no repeated stable artifact paste;
- no duplicate RUN for the same scope while one is active;
- same-gate failure twice ends retry and opens architecture repair or typed blocker;
- expensive model use requires task-class justification.

## Official Source Anchor

Current OpenAI model/API facts must be verified against official OpenAI documentation before being encoded as a policy claim: https://platform.openai.com/docs/models
