---
artifact_id: agenthub-secret-handle-docs-first-autorepair-coverage-20260612
artifact_type: registry_coverage
source_task: AH-771
run_id: RUN-AGENTHUB-SECRET-HANDLE-DOCS-FIRST-AUTOREPAIR-20260612
created_at: 2026-06-12
lifecycle_status: active_control_coverage
---

# AH-771 Secret-Handle Autorepair Coverage

| Path | Coverage |
| --- | --- |
| `governance/agenthub-secret-handle-docs-first-autorepair-policy.md` | Secret-handle docs-first autorepair policy |
| `schemas/agenthub_secret_handle_resolution.schema.json` | Secret handle resolver receipt schema |
| `schemas/agenthub_auth_handle_probe.schema.json` | Redacted auth probe receipt schema |
| `schemas/agenthub_owner_auth_miniguide.schema.json` | Owner mini-guide artifact schema |
| `validators/agenthub_secret_handle_autorepair_validator.rb` | Policy fixture validator |
| `evals/agenthub-secret-handle-autorepair/fixtures.json` | Positive/negative cases |
| `runbooks/agenthub-secret-handle-docs-first-autorepair.md` | Operator/agent execution runbook |
| `reports/docs/AH-771-KOMODO-DOCS-SOURCE-PACKET-20260612.md` | Official Komodo docs packet |
| `reports/guides/AH-771-owner-auth-handle-guide-20260612.html` | Owner-only auth handle guide |
| `reports/validations/AGENTHUB-SECRET-HANDLE-DOCS-FIRST-AUTOREPAIR-VALIDATION-20260612.md` | Validation evidence |
| `reports/receipts/AGENTHUB-SECRET-HANDLE-DOCS-FIRST-AUTOREPAIR-RECEIPT-20260612.md` | Closure receipt |

## Register Decision

This package is active for AH-771 and reusable as a control-spine pattern. It does not mark AH-771 Done; it marks the residual as typed owner-only auth-handle creation.