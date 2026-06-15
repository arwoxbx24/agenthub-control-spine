---
artifact_id: test-first-prod-deploy-lock-coverage-20260614
artifact_type: coverage-register
source_task: AH-794
run_id: AH-PROD-LOCK-TEST-FIRST-GOVERNANCE-20260614
status: active_control_candidate
safe_to_replay: false
---

# Test-First Production Deploy Lock Coverage

| Control | Artifact | Status |
|---|---|---|
| Production lock policy | `governance/test-first-prod-deploy-lock-policy.md` | installed |
| Environment route proof schema | `schemas/environment_route_proof.schema.json` | installed |
| Workflow impact audit schema | `schemas/workflow_impact_audit.schema.json` | installed |
| Release approval schema | `schemas/release_approval_gate.schema.json` | installed |
| Test acceptance proof schema | `schemas/test_acceptance_proof.schema.json` | installed |
| Deterministic validator | `validators/test_first_prod_deploy_lock_validator.rb` | installed |
| Required negative/positive fixtures | `fixtures/test-first-prod-deploy-lock/fixtures.json` | installed |
| Release runbook | `runbooks/test-first-release-gate-runbook.md` | installed |
| Worker template | `prompts/templates/test-first-release-worker-template.md` | installed |
| Owner confirmation template | `prompts/templates/owner-test-confirmation-request-template.md` | installed |
| Incident analysis | `reports/incidents/AH-794-prod-crossing-incident-analysis-20260614.md` | installed |
| Validation report | `reports/validations/AH-794-test-first-prod-lock-validation-20260614.md` | installed |
| Receipt | `reports/receipts/AH-794-test-first-prod-lock-receipt-20260614.md` | installed |

## Scope Boundary

No StroyRemont production mutation. Optional product-repo guard PR remains out of scope unless explicitly task-bound later.
