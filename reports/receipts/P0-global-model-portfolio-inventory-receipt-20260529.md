---
artifact_id: P0-global-model-portfolio-inventory-receipt-20260529
artifact_type: operational_receipt
owner_role: T1 Architect / Registrar
source_task: AH-590
run_id: RUN-P0-GLOBAL-MODEL-PORTFOLIO-ROUTE-CLOSURE-20260529
created_at: 2026-05-29
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Global Model Portfolio Inventory Receipt

inventory_status: INSTALLED

registry_source: AgentHub runtime contract and control-spine capability matrix

approved_helper_models:

- `gpt-5.3-codex-spark`
- `gpt-5.3-codex`
- `gpt-5.4-mini`
- `gpt-5.1-codex-mini`

route_classes:

- `CONTROL_T0`
- `ARCHITECT_T1`
- `CODEX_PRIMARY_T2`
- `CODEX_FALLBACK_T2`
- `REGISTRAR`
- `VERIFIER_QA`
- `SECURITY_REDACTION`
- `BROWSER_PRODUCT_QA`
- `DEVOPS_RUNTIME`

policy_path: `governance/model-portfolio-utilization-policy.md`

schema_path: `schemas/model_route_invocation_receipt.schema.json`

validator_path: `validators/model_portfolio_router_validator.rb`

fixtures_path: `evals/model-portfolio-routing/fixtures.json`

platform_meter_residual: CODEX_SPARK_PLATFORM_METER_UNAVAILABLE

