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
| Code/config/YAML/shell/frontend/backend/tests/IaC | Codex CLI/AgentHub worker with requested and resolved model `gpt-5.3-codex-spark`; fallback only with same-RUN Spark model-selection unavailability proof |
| Registrar/register/PR queue | deterministic tool or lower-cost route |
| Verifier/QA | verifier-capable route |
| Security redaction | deterministic scanner first, model second |

## Codex Spark Enforcement

Code, config, shell, YAML, frontend, backend, test, and infrastructure-as-code
tasks must route to the dedicated Codex Spark code-authoring model before any
general reasoning model. The required code-authoring route is exactly
`gpt-5.3-codex-spark` in the standard Codex model selector or an equivalent
AgentHub worker receipt. `gpt-5.3-codex`, `gpt-5.5`, `gpt-5.4`,
`gpt-5.4-mini`, and `gpt-5.1-codex-mini` are not substitutes for Spark when
Spark can be selected. Any fallback requires same-RUN proof that
`gpt-5.3-codex-spark` is unavailable or cannot be selected.

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
- same-RUN Spark model-selection unavailability proof before any non-Spark fallback;
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
- platform invocation telemetry showing Spark usage for the proof run; or
- a Codex CLI JSON event receipt from an explicit
  `gpt-5.3-codex-spark` invocation with non-zero input/output usage tokens and
  no fallback. A plain command request without JSON usage remains rejected.

If local command/request evidence cannot show the selected and resolved Spark
model, the terminal state is `CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE` until
independent platform proof or Codex CLI JSON usage exists.

## Codex Spark Code-Authoring Model Gate

The active P0 requirement is model selection, not a separate analytics page.
Every AgentHub task that writes code, config, YAML, shell, frontend, backend,
tests, or IaC must prove:

- `requested_model=gpt-5.3-codex-spark`;
- `resolved_model` or `actual_model=gpt-5.3-codex-spark`;
- `fallback_used=false`, unless the same RUN records Spark selector
  unavailability;
- `code_artifact_path` or equivalent changed-file evidence exists;
- no GPT-5.5/main/base/primary model authored implementation text.

The following sources cannot close this code-authoring model gate:

- `gpt-5.3-codex` or any non-Spark Codex route while Spark is selectable;
- terminal finalizer receipts that omit the selected/resolved Spark model;
- merged PRs without Spark route evidence;
- policy-only or validator-only changes;
- sandbox lease/requeue work;
- command-request-only proof without resolved model or CLI JSON usage.

Allowed terminal states for this contour are:

- `DONE_WITH_CODEX_SPARK_CODE_AUTHORING_MODEL`;
- `CODEX_SPARK_CODE_AUTHORING_REQUIRED`;
- `CODEX_SPARK_MODEL_SELECTOR_NOT_SET`;
- `CODEX_SPARK_RESOLVED_MODEL_MISMATCH`;
- `CODEX_SPARK_MODEL_SELECTION_UNAVAILABLE`;
- `PRIMARY_MODEL_CODE_AUTHORSHIP_DETECTED`;
- `MODEL_ROUTER_INSTALLATION_DEFECT`;
- `WRONG_TASK_EXECUTION_RECOVERY_REQUIRED`.

The lease/timeout sandbox auto-requeue class is explicitly unrelated to this
proof contour. It cannot satisfy or contribute to Codex Spark code-authoring
model proof.

## Loop and Budget Rules

- no full chat history to workers;
- no repeated stable artifact paste;
- no duplicate RUN for the same scope while one is active;
- same-gate failure twice ends retry and opens architecture repair or typed blocker;
- expensive model use requires task-class justification.

## Official Source Anchor

Current OpenAI model/API facts must be verified against official OpenAI documentation before being encoded as a policy claim: https://platform.openai.com/docs/models
