---
artifact_id: p0-codex-spark-model-router-pr80-residual-audit-20260528
artifact_type: audit_report
owner_role: T1 Architect / Model Router Controller / Verifier
source_task: AH-590
run_id: RUN-P0-CODEX-SPARK-MODEL-ROUTER-PR80-FIX-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 Codex Spark Model Router and PR80 Residual Audit

## Scope

AgentHub-core model-router and action-policy governance only. No product,
runtime, Docker, NPM, DB, proxy, firewall, DNS, SSL, or service mutation.

## Fact Audit

| Item | Status | Evidence | Repair |
|---|---|---|---|
| PR #80 and #81 merged | CONFIRMED | `PR_QUEUE_REGISTER.md` records #80/#81 merged; main contains AgentHub X controls. | This run builds on those controls. |
| PR80 residual: action validator can omit surface bounds | CONFIRMED | `validators/agenthub_action_policy_validator.rb` required only run/task/role/action/scope/evidence/receipt before this patch. | Validator now returns `BLOCKED_SURFACE_BOUNDS_MISSING` before allow. |
| Model router only proves generic Codex-capable routing | CONFIRMED | `evals/model-token-routing/fixtures.json` used `model_class=CODEX_CAPABLE` without worker model, Spark availability, or fallback evidence. | Model evals now require `worker_model`, `model_route_reason`, Codex availability, and same-RUN fallback evidence. |
| T0 direct authorship remains blocked | CONFIRMED | T0 negative fixtures and validator pass after model/surface evidence fields are added. | Existing hard-stop preserved. |
| Repo-first Done lacked model-route evidence gate | CONFIRMED | `validators/repo_first_receipt_gate.rb` did not require `worker_model` or `model_route_reason`. | Done gate now fails with `NOT_DONE_MODEL_ROUTE_EVIDENCE_MISSING`. |

## Installed Controls

- Updated `validators/agenthub_action_policy_validator.rb`.
- Updated `validators/model_token_router_validator.rb`.
- Updated `validators/repo_first_receipt_gate.rb`.
- Updated `schemas/agent-action-request.schema.json`.
- Updated `evals/model-token-routing/fixtures.json`.
- Updated `evals/agenthub-x-capability-positive-tests/fixtures.json`.
- Updated `evals/t0-direct-action-negative-tests/fixtures.json`.
- Updated `evals/repo-first-reporting/fixtures.json`.
- Updated `governance/model-token-routing-policy.md`.
- Updated `governance/agenthub-model-routing-and-token-economy.md`.
- Added `governance/adr/ADR-codex-spark-model-router-enforcement-20260528.md`.

## Validation Matrix

| Gate | Expected |
|---|---|
| Code/config with Codex available | `gpt-5.3-codex-spark` or `gpt-5.3-codex` primary route |
| Code/config with general model while Codex available | `CODEX_SPARK_ROUTE_REQUIRED` |
| Codex unavailable | same-RUN fallback to approved mini/Codex-capable worker |
| Missing surfaces | `BLOCKED_SURFACE_BOUNDS_MISSING` |
| Missing worker model or route reason | `MODEL_ROUTE_EVIDENCE_MISSING` or Done denied |
| Same gate twice | `ARCHITECTURE_REPAIR_REQUIRED` |

## Residuals

No repository-governance residual remains after targeted validation. Runtime
registry integration is not claimed beyond these control-spine validators and
evals; any future missing runtime install path must be reported as
`MODEL_ROUTER_INSTALL_PATH_REQUIRED`, not bypassed by T0.
