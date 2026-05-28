---
artifact_id: adr-codex-spark-model-router-enforcement-20260528
artifact_type: architecture_decision_record
owner_role: T1 Architect / Model Router Controller
source_task: AH-590
run_id: RUN-P0-CODEX-SPARK-MODEL-ROUTER-PR80-FIX-20260528
created_at: 2026-05-28
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# ADR: Codex Spark Model Router Enforcement

## Status

Accepted.

## Context

PR #80 installed the AgentHub X capability matrix, but the action policy
validator still allowed scoped actions without checking `allowed_surfaces` and
`forbidden_surfaces`. The model-router evals also proved only generic
Codex-capable routing, not the required Spark/Codex-first behavior for
code/config/shell/YAML/IaC tasks.

## Decision

Implementation-capable work must route to a Codex-capable worker profile before
any general reasoning route. When available, `gpt-5.3-codex-spark` is the first
primary route and `gpt-5.3-codex` is the second primary route. If primary Codex
capacity is unavailable, fallback must stay inside the same `run_id` and use an
approved lower-cost Codex-capable or mini route. T0 direct authorship is never a
fallback.

Action-policy validation must deny before allow when any of these are missing:

- `allowed_surfaces`;
- `forbidden_surfaces`;
- `worker_model`;
- `model_route_reason`;
- present `fallback_reason` field.

## Rejected Options

- Leave model routing as prompt-only guidance: rejected because quota and cost
  defects continue without executable evals.
- Allow general model fallback for code/config work: rejected because it
  recreates expensive T0/context burn and weak worker ownership.
- Allow action approval without surface bounds: rejected because it makes scoped
  worker grants unbounded.

## Done Gate

Done requires targeted evals proving Spark/Codex-first routing, same-RUN
fallback, T0 denial, surface-bound denial, model-route evidence, repo-first
receipt, register coverage, and no domain/runtime mutation.
