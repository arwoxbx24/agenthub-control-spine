---
artifact_id: AH-794-test-first-prod-lock-validation-20260614
artifact_type: validation-report
source_task: AH-794
run_id: AH-PROD-LOCK-TEST-FIRST-GOVERNANCE-20260614
status: pass
safe_to_replay: false
---

# AH-794 Validation Report

## Validation Scope

Repository governance package only. No StroyRemont production/client runtime mutation.

## Fixture Coverage

The fixture pack covers the required acceptance cases:

1. Test task tries to merge into master -> BLOCK.
2. Test task tries workflow run on master -> BLOCK.
3. Workflow name says Test but branch is master -> BLOCK.
4. Route has unknown environment -> BLOCK.
5. Test branch + test workflow + no prod secrets -> ALLOW.
6. Owner says `делай` -> BLOCK production approval.
7. Exact phrase after test proof -> ALLOW release gate.
8. PR merge success without browser/user proof -> BLOCK Done.
9. Workflow success without test acceptance -> BLOCK release.
10. Client delivery claim without green ledger -> BLOCK.
11. Emergency rollback route lacks previous-known-good proof -> BLOCK.
12. Branch cleanup without register evidence -> BLOCK.

## Deterministic Validator

Validator path: `validators/test_first_prod_deploy_lock_validator.rb`.
Fixtures path: `fixtures/test-first-prod-deploy-lock/fixtures.json`.
Expected command: `ruby validators/test_first_prod_deploy_lock_validator.rb fixtures/test-first-prod-deploy-lock/fixtures.json`.
Expected output: `PASS test_first_prod_deploy_lock_validator cases=12`.

## Readback Validation

- GitHub connector write receipts exist for policy, schemas, validator, fixtures, runbook, templates, coverage register, incident report, validation report, and receipt.
- Branch: `agenthub/AH-794-test-first-prod-lock-20260614`.
- Physical YouTrack task: AH-794.
- AgentHub RUN_ID: `AH-PROD-LOCK-TEST-FIRST-GOVERNANCE-20260614`.
- PR #171 head with register coverage: `8b8de784ab9d8e37ef8d35eaf153b9d2b2ab91cc`.
- GitHub Actions run `27510687341`: `secret-scan`, conclusion `success`.
- Job `81310068397` / `gitleaks`: success.
- Job `81310068427` / `AH-794 test-first production lock validator`: success.
- Step `Run AH-794 deterministic validator`: success.
- PR file patch readback: `INDEX.md`, `ARTIFACT_REGISTER.md`, and `PR_QUEUE_REGISTER.md` contain AH-794 coverage sections.

## Residual

None for repository governance validation. Local shell remained restricted, but the allowed GitHub Actions CI route confirmed the deterministic validator and gitleaks success on the PR head with register coverage. No StroyRemont production/client runtime mutation was performed.
