---
artifact_id: model-portfolio-utilization-policy
artifact_type: active_policy
owner_role: T1 Architect / Model Router Controller
source_task: AH-615
run_id: RUN-P0-MODEL-PORTFOLIO-CONTINUOUS-LOOP-20260530
created_at: 2026-05-30
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Model Portfolio Utilization Policy

AgentHub selects models inside the control plane. The owner must not be asked
to run `/model`, choose a model, click a routine button, or continue a normal
automation cycle.

## Route Matrix

| Route class | Purpose | Primary route | Fallback | Forbidden |
|---|---|---|---|---|
| `T0_PREGATEWAY` | owner intent, classify, bind task/RUN, route, verify, final summary | `gpt-5.5` for P0/P1 control classification | `gpt-5.4` only for lower-risk control summaries | code/config/YAML/shell/test authoring, runtime mutation |
| `T1_ARCHITECT` | architecture, assignment, ADR, decomposition | `gpt-5.4` | `gpt-5.5` only for high-risk P0/P1 control architecture | direct implementation mutation |
| `T2_CODEX_IMPLEMENTER` | code, config, YAML, shell, tests, frontend, backend, IaC | `gpt-5.3-codex-spark` | `gpt-5.3-codex`, then `gpt-5.4-mini`, then `gpt-5.4`, only with same-RUN Spark/Codex unavailable proof | GPT-5.5/main/base code authorship, sandbox route as Spark proof, owner manual model selection |
| `TASK_SERVICE` | task card, parent/child binding, status, evidence, Done readback | deterministic tool route | `gpt-5.4-mini`; `gpt-5.2` only for complex persistent task-service orchestration | Spark for non-code task updates |
| `VERIFIER` | QA, truth-redteam, PR/receipt validation | deterministic validator or `gpt-5.4-mini` | `gpt-5.4` for complex cross-source review | mutation |
| `RESEARCH` | official docs, source reading, comparison | search/tool route plus `gpt-5.4-mini` or `gpt-5.4` | none unless documented | Spark for information-only work |
| `SECURITY_REDACTION` | secret scan, redaction, output safety | deterministic scanner | `gpt-5.4-mini` verifier | secret values in chat, repo, logs, or receipts |

## Enforcement

Every implementation-capable worker receipt must include:

- `task_class`
- `requested_model`
- `resolved_model`
- `actual_route`
- `worker_role`
- `run_id`
- `fallback_reason`
- `same_run_fallback_proof`
- `spark_available`
- `return_to_spark_when_available`
- `owner_manual_model_required`

For code/config/YAML/shell/test/frontend/backend/IaC, `requested_model` and
`resolved_model` must be `gpt-5.3-codex-spark` when Spark is selectable.
`agenthub-sandbox-worker` is never accepted as Spark proof.

## Continuous Loop

AgentHub task service must execute the full cycle without owner readback:

1. request capture;
2. duplicate check;
3. parent/child task creation or exact route blocker;
4. microtask execution;
5. stage movement;
6. evidence attachment;
7. validation;
8. Done gate;
9. final owner message.

Routine missing task, register, PR, validation, or receipt proof becomes a
same-RUN microtask. Owner-facing output remains suppressed until final Done or
one exact owner-only irreversible blocker.
