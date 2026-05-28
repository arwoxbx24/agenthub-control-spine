---
artifact_id: p0-codex-spark-model-router-pr80-residual-receipt-20260528
artifact_type: operational_receipt
owner_role: Registrar / Verifier
source_task: AH-590
run_id: RUN-P0-CODEX-SPARK-MODEL-ROUTER-PR80-FIX-20260528
created_at: 2026-05-28
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# P0 Codex Spark Model Router PR80 Residual Receipt

RUN_ID: `RUN-P0-CODEX-SPARK-MODEL-ROUTER-PR80-FIX-20260528`
task_class: AGENTHUB_SYSTEM_PROCESS
status: DONE_WITH_EVIDENCE
worker_role: T2_AGENTHUB_CORE_WORKER / Registrar / Verifier
worker_model: `gpt-5.3-codex-spark` primary route required for code/config when available; `gpt-5.3-codex` accepted as primary Codex route; `gpt-5.1-codex-mini` or `gpt-5.4-mini` accepted only as same-RUN fallback.
model_route_reason: Code/config/shell/YAML/IaC tasks must consume Codex-capable worker capacity before general reasoning models; T0 direct authorship remains denied.
codex_available: represented in `evals/model-token-routing/fixtures.json` as primary-route and unavailable-fallback cases.
fallback_reason: `null` for primary route; required non-empty value for same-RUN fallback.
changed_files:
- `governance/model-token-routing-policy.md`
- `governance/agenthub-model-routing-and-token-economy.md`
- `governance/adr/ADR-codex-spark-model-router-enforcement-20260528.md`
- `schemas/agent-action-request.schema.json`
- `validators/agenthub_action_policy_validator.rb`
- `validators/model_token_router_validator.rb`
- `validators/repo_first_receipt_gate.rb`
- `evals/model-token-routing/fixtures.json`
- `evals/agenthub-x-capability-positive-tests/fixtures.json`
- `evals/t0-direct-action-negative-tests/fixtures.json`
- `evals/repo-first-reporting/fixtures.json`
- `reports/audits/P0-codex-spark-model-router-pr80-residual-audit-20260528.md`
- `reports/receipts/P0-codex-spark-model-router-pr80-residual-receipt-20260528.md`
installed_controls:
- Codex Spark / Codex primary-route model router eval.
- Same-RUN fallback eval.
- Surface-bound action-policy denial.
- Model-route evidence denial.
- Repo-first Done gate model evidence requirement.
fixed_residuals:
- PR80 action validator now requires `allowed_surfaces` and `forbidden_surfaces` before allow.
- Implementation-capable actions now require `worker_model`, `model_route_reason`, and `fallback_reason` field.
validation:
- JSON syntax validation for changed schemas and fixtures.
- Targeted Ruby validator evals.
- `git diff --check`.
- redacted `gitleaks` scan.
negative_tests:
- T0 direct authorship blocked.
- General model rejected for code/config when Codex is available.
- Missing surface bounds blocked.
- Missing model route evidence blocked.
- Same-gate third retry becomes architecture repair.
- Done fails without model-route evidence.
forbidden_scope_untouched:
- Product/runtime/Docker/NPM/DB/proxy/firewall/DNS/SSL mutation: not performed.
- Secret/env values printed or committed: false.
repo_artifacts:
- Audit, ADR, receipt, validators, schemas, evals, and registers in `arwoxbx24/agenthub-control-spine`.
task_readback:
- AH-590 updated after PR merge.
residuals:
- none for repository-governance scope after validation; runtime adapter install path remains a future typed blocker if contradicted by live readback.
