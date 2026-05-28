---
artifact_id: p0-agenthub-self-healing-core-install-receipt-20260528
artifact_type: operational_receipt
owner_role: Registrar / Verifier
source_task: AH-590
run_id: RUN-P0-SELF-HEALING-CORE-20260528
created_at: 2026-05-28
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# P0 AgentHub Self-Healing Core Install Receipt

RUN_ID: `RUN-P0-SELF-HEALING-CORE-20260528`
source_task: `AH-590`
scope_signature: `AGENTHUB_SELF_HEALING_CORE`
status: `SELF_HEALING_CORE_INSTALLED_DONE_WITH_EVIDENCE`

PRs: `#86` merged to `main`
commits: implementation commit `4192cfc`; merge commit `1a181af`
YouTrack_readback: `AH-590` evidence prepared for final Done readback; draft `3-624`

installed_controls:
- self-healing core policy
- capability matrix policy
- action authorization receipt schema
- capability matrix schema
- self-healing event schema
- route recovery runbook
- secrets handle registry runbook
- self-healing validator and E1-E15 fixtures

capability_matrix_path: `governance/policies/agenthub-capability-matrix.md`
action_authorization_schema_path: `schemas/agenthub_action_authorization_receipt.schema.json`
self_healing_event_schema_path: `schemas/agenthub_self_healing_event.schema.json`
model_router_gate: E5/E6 plus PR #84 fallback evidence gate
registrar_repair_route: E7/E10/E11
live_route_repair_route: E8
secrets_handle_registry: `runbooks/agenthub-secrets-handle-registry.md`
task_debt_controller: E9 plus self-healing event `TASK_DEBT_DEFECT`
backend_only_output_gate: E15
negative_tests: E1-E15 PASS via `validators/agenthub_self_healing_validator.rb`
failed_tests_and_repairs: none
T0_direct_action_block_evidence: E1 and E2 PASS
Codex_route_evidence: E5 and E6 PASS
register_coverage: `INDEX.md`, `ARTIFACT_REGISTER.md`, and `PR_QUEUE_REGISTER.md` updated; PR #86 merged and readback row prepared
validation:
- self-healing E1-E15: PASS, 15 cases
- action-policy positive/regression eval: PASS, 19 cases
- T0 negative action eval: PASS, 7 cases
- model-token-router eval: PASS, 8 cases
- repo-first receipt gate eval: PASS, 4 cases
- schema and fixture JSON parse: PASS
- git diff check: PASS
- secret scan: PASS, `gitleaks detect --no-git --redact`
owner_only_residuals: none known for repository-governance scope
final_done_gate: repository-governance scope PASS; final task-system readback is recorded under `AH-590`
