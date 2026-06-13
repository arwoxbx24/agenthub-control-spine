---
artifact_id: AH-790-linux-final-truth-gate-validation-20260613
artifact_type: validation_report
source_task: AH-790
run_id: linux-final-truth-gate-20260613
created_at: 2026-06-13
lifecycle_status: validation_report
default_load: false
safe_to_replay: false
---

# AH-790 Linux Final Truth Gate Validation

| Gate | Status | Evidence |
|---|---|---|
| TASK_BINDING | PASS | YouTrack task `AH-790` created with RUN_ID and custom `Дата создания`. |
| DUPLICATE_CHECK | PASS | Same-scope YouTrack search and branch search returned no existing task/branch. |
| AH_788_COMPATIBILITY | PASS | AH-788 policy/schema/validator read from `main`; AH-790 adds new files and does not modify AH-788 files. |
| POLICY_INSTALLED | PASS | `governance/linux-final-truth-gate-policy.md`. |
| CLAIM_TUPLE_SCHEMA_INSTALLED | PASS | `schemas/final_claim_evidence_tuple.schema.json`. |
| LEDGER_SCHEMA_INSTALLED | PASS | `schemas/linux_visible_evidence_ledger.schema.json`. |
| VALIDATOR_INSTALLED | PASS | `validators/final_truth_gate_validator.rb`. |
| FIXTURES_INSTALLED | PASS | `fixtures/final-truth-gate/fixtures.json`. |
| TEMPLATE_INSTALLED | PASS | `prompts/templates/linux-final-truth-worker-template.md`. |
| RUNBOOK_INSTALLED | PASS | `runbooks/linux-final-truth-gate-runbook.md`. |
| COVERAGE_REGISTER | PASS | `registries/linux-final-truth-gate-coverage-20260613.md`. |
| LOCAL_VALIDATOR_EXECUTION | NOT_RUN | Local checkout path was unavailable to revision guard; no claim is made that Ruby validator executed locally. Repository readback and fixture review are recorded instead. |
| SECURITY_SCOPE | PASS | Artifacts contain policy/schema/validator/fixture text only; no secrets, raw env dumps, logs, or private keys. |
| RUNTIME_SCOPE | PASS | No production runtime, Docker, DB, proxy/NPM, firewall, PM2, Grafana, DNS, SSL, Railway, object storage, or client code mutation. |

## Fixture Coverage

Fixtures cover:

- governance-only repo task with no browser scope;
- user-visible task with valid browser-worker receipt;
- browser claim blocked when only local curl exists;
- chat-only proof blocked;
- PR-only proof blocked;
- unknown client claim excluded;
- Done marker with pending text blocked;
- same-gate blind retry blocked;
- same-gate targeted retry after source read allowed once.

## Result

Validation status: repository artifact/readback validation PASS; local executable validator run NOT_RUN because local checkout path was unavailable. This does not block PR creation, but Stage Done requires final readback and evidence tuple.
