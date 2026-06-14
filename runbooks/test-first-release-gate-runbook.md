---
artifact_id: test-first-release-gate-runbook
artifact_type: runbook
source_task: AH-794
status: active_control
safe_to_replay: false
---

# Test-First Release Gate Runbook

1. Bind a physical task and RUN_ID.
2. Classify the task as local, test, staging, production, or unknown production risk.
3. For any test task, write environment route proof before action.
4. For any PR, merge, workflow run, or deployment-related action, write workflow impact audit from YAML/default branch/current branch/secrets/environment evidence.
5. If target branch is `main` or `master`, stop unless this is an approved production release.
6. Run test-only execution against a proved test route.
7. Collect browser/user outcome proof on test.
8. Prepare release candidate receipt.
9. Request production approval only with the exact release summary and only after test proof.
10. Proceed to production only if the owner phrase is exactly `разрешаю отгрузку на прод`.
11. Validate production after release and write receipt/readback.

## Blocker Codes

- `TEST_ONLY_ROUTE_PROOF_MISSING`
- `WORKFLOW_IMPACT_AUDIT_MISSING`
- `UNKNOWN_IS_PROD_RISK`
- `MASTER_MAIN_PROD_RISK_BLOCKED`
- `OWNER_PROD_APPROVAL_EXACT_PHRASE_MISSING`
- `TEST_BROWSER_OR_OWNER_ACCEPTANCE_MISSING`
- `CLIENT_DELIVERY_GREEN_LEDGER_MISSING`
