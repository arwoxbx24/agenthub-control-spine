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

## Codex Spark Enforcement

Code, config, shell, YAML, frontend, backend, test, and infrastructure-as-code
tasks must route to a Codex-capable worker profile before any general reasoning
model. If `gpt-5.3-codex-spark` or `gpt-5.3-codex` is available in the approved
runtime registry, the worker receipt must use one of those primary routes.

## Primary Model Burn Circuit Breaker

For code/config/YAML/shell/programming work, the primary/main/base reasoning
model is limited to classification and routing. It must not author, patch,
generate, validate, or run implementation work. The circuit breaker returns a
hard defect before generation when any primary model attempts code/config
authorship.

The circuit breaker requires:

- `circuit_breaker_active=true` before code/config work starts;
- `actor_model` on every implementation-capable dispatch;
- Spark/Codex worker route for code/config work;
- same-RUN Spark unavailability proof before any non-Spark Codex fallback;
- hard denial for GPT-5.5/main/base/primary fallback on code/config proof;
- same-gate retry stop after two failures.

If primary Codex capacity is unavailable, fallback must stay in the same
`run_id` and use an approved lower-cost Codex-capable or mini worker route. T0
direct authorship and broad general-model command loops remain forbidden.

Every dispatch receipt for implementation-capable work must include:

- `worker_model`;
- `model_route_reason`;
- `codex_available`;
- `fallback_reason` when fallback is used, otherwise `null`;
- token/context budget class;
- residuals.

## Codex Spark Execution Proof Gate

Spark route closure requires independent proof of the resolved model. The
following evidence classes are not enough for `DONE_WITH_EVIDENCE`:

- command-line request text such as `codex exec -m gpt-5.3-codex-spark`;
- worker self-report of `actual_model`;
- merged PR;
- installed policy or validator;
- sandbox-only proof without independent platform model identity.

Accepted Spark execution proof must be one of:

- a platform/model invocation receipt that independently names
  `gpt-5.3-codex-spark` as the resolved model; or
- owner-visible usage telemetry showing Spark usage changed for the proof run; or
- a Codex CLI JSON event receipt from an explicit
  `gpt-5.3-codex-spark` invocation with non-zero input/output usage tokens and
  no fallback. A plain command request without JSON usage remains rejected.

If the owner-visible Spark usage metric contradicts local command/request
evidence, the terminal blocker is `CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE`
until independent platform proof exists.

## Loop and Budget Rules

- no full chat history to workers;
- no repeated stable artifact paste;
- no duplicate RUN for the same scope while one is active;
- same-gate failure twice ends retry and opens architecture repair or typed blocker;
- expensive model use requires task-class justification.

## Official Source Anchor

Current OpenAI model/API facts must be verified against official OpenAI documentation before being encoded as a policy claim: https://platform.openai.com/docs/models
