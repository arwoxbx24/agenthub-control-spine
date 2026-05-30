---
artifact_id: t0-escape-boundary-gates-policy
artifact_type: active_policy
owner_role: T1 Architect / AgentHub Core Controller
source_task: 3-640
run_id: RUN-P0-T0-ESCAPE-BOUNDARY-GATES-IMPLEMENTATION-20260530
created_at: 2026-05-30
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
supersedes: prompts/implementation/P0-agenthub-t0-escape-boundary-blocker-implementation-prompt-20260530.txt
---

# T0 Escape Boundary Gates Policy

This policy installs the implementation contract for the seven P0 gates found
missing or incomplete in PR #115. It is policy-as-code paired with
`validators/t0_escape_boundary_gates_validator.rb` and
`evals/t0-escape-boundary-gates/fixtures.json`.

## Installed Gates

| Gate | Required control |
|---|---|
| `T0_DIRECT_ACTION_GATE` | Deny T0 before any code, config, shell, runtime, microservice, PM2, Komodo, Docker, DB, proxy, firewall, DNS, product, or service mutation action. The action must reroute to an authorized AgentHub worker instead of continuing in T0. |
| `ROLE_STATE_REVALIDATION_GATE` | Every tool, action, dispatch, merge, task transition, register update, and Done attempt must revalidate `run_id`, `task_id`, `scope_signature`, `actor_role`, `actor_model`, `worker_id`, allowed surfaces, forbidden surfaces, and route receipt. Mid-context role drift returns `ROLE_STATE_REVALIDATION_MISSING`. |
| `CODE_AUTHORING_ROUTE_GATE` | Code, config, YAML, shell, frontend, backend, test, and IaC authoring is allowed only for scoped T2 Codex workers. `gpt-5.3-codex-spark` is primary when selectable; fallback requires same-RUN Spark/Codex unavailable evidence. |
| `LIVE_ADAPTER_AUTHORITY_GATE` | Live runtime and command adapters require an explicit T2 live-worker authorization, rollback evidence path, validation plan, no-secret proof, and exact task/scope binding. Sandbox or dispatch-only proof cannot close live outcomes. |
| `TASK_SERVICE_CONTINUOUS_LOOP_GATE` | Routine missing proof, PR queue state, register update, task comment, validation, review gate, and task readback become same-RUN microtasks. The owner is not interrupted for routine platform steps. |
| `DONE_GATE_HARDENER` | Done requires implementation evidence, validation evidence, receipt, task readback, register/index coverage, PR lifecycle state, no active blocker, and no secret leak. Audit-only, report-only, prompt-only, sandbox-only, dispatch-only, or PR-only evidence is denied. |
| `OWNER_OUTPUT_SUPPRESSION_GATE` | Owner-facing output is suppressed during active execution. Only the final `Fact/Action/Left` result or an exact owner-only irreversible blocker may be sent. |

## Action Receipt Fields

Every implementation-capable action must carry these fields before execution:

- `run_id`
- `task_id`
- `scope_signature`
- `actor_role`
- `actor_model`
- `worker_id`
- `action_class`
- `target_surface`
- `allowed_surfaces`
- `forbidden_surfaces`
- `route_receipt`
- `model_route`
- `secret_redaction`
- `evidence_path`
- `validation_plan`
- `owner_output_mode`

Missing fields fail closed as `ROLE_STATE_REVALIDATION_MISSING`.

## Finalization Rule

Finalization is allowed only when the receipt proves:

- all seven gates were evaluated;
- implementation and validation evidence both exist;
- PR #115 is preserved as audit-only or superseded by the implementation PR;
- registers and task readback are updated or a typed platform blocker is
  recorded;
- no runtime, product, secret, Docker, DB, proxy, firewall, DNS, PM2, or Komodo
  mutation occurred outside an authorized T2 live-worker route.
