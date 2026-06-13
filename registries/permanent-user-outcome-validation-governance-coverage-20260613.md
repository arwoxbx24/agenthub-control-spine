---
artifact_id: permanent-user-outcome-validation-governance-coverage-20260613
artifact_type: registry_coverage
source_task: AH-788
run_id: permanent-user-outcome-validation-governance-20260613
created_at: 2026-06-13
lifecycle_status: active_control_coverage
default_load: false
safe_to_replay: false
---

# Permanent User-Outcome Validation Governance Coverage

| Path | Type | Lifecycle | Coverage |
|---|---|---|---|
| `governance/permanent-user-outcome-validation-policy.md` | policy | active_control | Browser-first, no fake Done, no blind retry policy |
| `schemas/user_outcome_validation_matrix.schema.json` | schema | active_control | Scoped validation matrix and Done tuple |
| `schemas/claim_ledger.schema.json` | schema | active_control | Client/user claim ledger |
| `schemas/blind_retry_guard.schema.json` | schema | active_control | Same-gate retry decision schema |
| `validators/user_outcome_validation_matrix_validator.rb` | validator | active_control | Blocks local-only proof, missing browser proof, pending Done text |
| `validators/claim_ledger_validator.rb` | validator | active_control | Blocks unsupported client full-delivery claims |
| `validators/blind_retry_guard_validator.rb` | validator | active_control | Blocks blind retries and routes routine gaps to PackFix |
| `fixtures/user-outcome-validation/fixtures.json` | fixtures | active_control | Matrix negative and positive cases |
| `fixtures/user-outcome-validation/claim-ledger-fixtures.json` | fixtures | active_control | Claim ledger cases |
| `fixtures/anti-blind-retry/fixtures.json` | fixtures | active_control | Blind retry and PackFix cases |
| `prompts/templates/closed-contour-user-outcome-worker-template.md` | template | active_control | Worker communication and closure contract |
| `prompts/templates/client-delivery-claim-ledger-template.md` | template | active_control | Client claim ledger template |
| `runbooks/agent-cycle-and-user-outcome-validation-runbook.md` | runbook | active_control | Agent cycle and validation runbook |
| `reports/validations/AH-788-permanent-user-outcome-validation-governance-validation-20260613.md` | validation | operational_receipt | Readback validation summary |
| `reports/receipts/AH-788-permanent-user-outcome-validation-governance-receipt-20260613.md` | receipt | operational_receipt | Implementation receipt |

## Directory Governance Integration

This package uses AH-787 directory governance: all new artifacts live under approved governance, schema, validator, fixture, prompt, runbook, registry, validation, and receipt paths. No unmanaged `/root`, workspace, `.codex`, tmp, backup, or product folders are created.

## Register Note

This coverage artifact is the branch-local register row set for AH-788. Root `INDEX.md`, `ARTIFACT_REGISTER.md`, and `PR_QUEUE_REGISTER.md` are current baselines; PR body carries queue state for this branch.
