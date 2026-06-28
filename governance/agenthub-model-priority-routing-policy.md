---
artifact_id: agenthub-model-priority-routing-policy
artifact_type: governance_policy
owner_role: T1 Architecture Broker / T2 Codex Worker / Verifier
source_task: AH-601
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Model Priority Routing Policy

AgentHub model routing is lane-based. A requested or resolved model label is a routing request only; it is not execution proof.

## Lanes

| Lane | Scope | Default | Guard |
|---|---|---|---|
| M0 | architecture, business analysis, complex audit, root-cause synthesis | `gpt-5.5` | Forbidden for routine code/config/validator/schema/test/fixture/script/workflow classes unless explicit escalation. No more than 5% of routine M0 workload without escalation. |
| M1 | professional coding requiring stronger reasoning after Spark validation failure | `gpt-5.4` | Fallback use requires fallback reason. |
| M2 | code, config, validators, schemas, tests, fixtures, scripts, workflows, CLI automation | `gpt-5.3-codex-spark` first | Spark must be first attempted when visible in `codex debug models`. Fallback order: `gpt-5.4-mini` (or explicit visible low-cost model), `gpt-5.4`, `gpt-5.5` only with `MODEL_ESCALATION_RECEIPT`. |
| M3 | tiny read-only, formatting, registers, low-risk text patching | `gpt-5.4-mini` or visible low-cost model | No code reasoning assumption. |

## M0 Budget Guard

Every route decision for lane M0 must carry these workload fields:

- `is_routine_workload` (`true/false`)
- `route_workload_context` or `m0_workload_total`

For routine M0 workload (non-escalated), `count_routine / count_total <= 0.05`.
Escalated routine M0 work requires `MODEL_ESCALATION_RECEIPT`.

`route_workload_context` is the preferred single source for workload context when present. `m0_workload_total` and `count_total` may be used as explicit numeric proofs only when route context is split across systems.

## M2 Fallback Order

1. `gpt-5.3-codex-spark`
2. `gpt-5.4-mini` or exact low-cost Codex-capable model visible in `codex debug models`
3. `gpt-5.4`
4. `gpt-5.5` only with `MODEL_ESCALATION_RECEIPT`.

## Required Route Decision Evidence

Every route decision for code/config work must record:

- `run_id`
- `task_id`
- `task_class`
- `route_lane`
- `is_routine_workload` (for M0 workload accounting)
- `spark_catalog_visible`
- `first_attempt_model`
- `requested_model`
- `resolved_model`
- `fallback_used`
- `fallback_model`
- `fallback_reason`
- `route_workload_context` (preferred)
- `model_escalation_receipt`

## Non-Proof Sources

- `AGENTHUB_REQUESTED_MODEL` and `AGENTHUB_RESOLVED_MODEL` are routing markers, not execution proof.
- Sandbox route labels, env vars, PR state, validator-only output, and requested/resolved labels cannot prove actual model execution.

## Denials

- M2 work routed to `gpt-5.5` without `MODEL_ESCALATION_RECEIPT` fails.
- Spark visible in `codex debug models` but not first attempted for M2 fails.
- Routine M0 work routed to routine code/config/validator/schema/test/fixture/script/workflow classes fails.
- M0 workload ratio > 5% without escalation fails.
- Sandbox route, env vars, requested/resolved labels, PR state, or validator-only evidence cannot prove actual model execution.
