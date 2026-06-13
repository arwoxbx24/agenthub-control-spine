---
artifact_id: linux-final-truth-gate-coverage-20260613
artifact_type: registry_coverage
source_task: AH-790
run_id: linux-final-truth-gate-20260613
created_at: 2026-06-13
lifecycle_status: active_control_coverage
default_load: false
safe_to_replay: false
---

# Linux Final Truth Gate Coverage

| Path | Type | Lifecycle | Coverage |
|---|---|---|---|
| `governance/linux-final-truth-gate-policy.md` | policy | active_control | Linux-visible final claim rule; extends AH-788 without replacement. |
| `schemas/final_claim_evidence_tuple.schema.json` | schema | active_control | Per-claim evidence tuple. |
| `schemas/linux_visible_evidence_ledger.schema.json` | schema | active_control | Final answer claim ledger. |
| `validators/final_truth_gate_validator.rb` | validator | active_control | Blocks chat proof, PR-only proof, local-only browser proof, pending Done, blind retry, unsupported final claims. |
| `fixtures/final-truth-gate/fixtures.json` | fixtures | active_control | Positive and negative final truth cases. |
| `prompts/templates/linux-final-truth-worker-template.md` | template | active_control | Worker closure contract. |
| `runbooks/linux-final-truth-gate-runbook.md` | runbook | active_control | Execution and PackFix process. |
| `reports/validations/AH-790-linux-final-truth-gate-validation-20260613.md` | validation | operational_receipt | Repository readback and validation scope. |
| `reports/receipts/AH-790-linux-final-truth-gate-receipt-20260613.md` | receipt | operational_receipt | Implementation receipt. |

## Compatibility

AH-790 is additive to AH-788 / PR #167. It does not modify AH-788 files and does not loosen browser-first validation.

## Forbidden Scope Readback

No production runtime, Docker, DB, proxy/NPM, firewall, PM2, Grafana, DNS, SSL, Railway, object storage, client product code, secrets, raw env/log dumps, broad cleanup/delete/prune/reset, or unmanaged temporary folders are part of this package.
