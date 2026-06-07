---
artifact_id: p1-document-dedupe-gate-validation-20260607
artifact_type: validation_report
owner_role: Verifier
source_task: AGENTHUB_DOCUMENT_DEDUPE_GATE_REPAIR_PROMPT_20260607
run_id: RUN-P1-DOCUMENT-DEDUPE-GATE-20260607
created_at: 2026-06-07
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P1 Document Dedupe Gate Validation

## Scope

Repository governance/control-spine only. No runtime, Docker, DB, proxy,
firewall, DNS, SSL, server, secret, or product surface was touched.

## Checks

| Check | Result |
|---|---|
| `ruby -c validators/document_dedupe_gate_validator.rb` | PASS |
| `ruby validators/document_dedupe_gate_validator.rb evals/document-dedupe-gate/fixtures.json` | PASS, 9 cases |
| `ruby validators/document_dedupe_gate_validator.rb` | PASS, live `INDEX.md` / `ARTIFACT_REGISTER.md` scan |
| Policy exists: `governance/document-dedupe-gate-policy.md` | PASS |
| Eval fixtures exist: `evals/document-dedupe-gate/fixtures.json` | PASS |
| Validator exists: `validators/document_dedupe_gate_validator.rb` | PASS |
| Existing duplicate model-portfolio register/index rows deduped without deleting artifacts | PASS |
| `INDEX.md` coverage | PASS |
| `ARTIFACT_REGISTER.md` coverage | PASS |
| `PR_QUEUE_REGISTER.md` update | not_applicable; no PR created in this turn |
| Secret/raw link check | PASS; no secret values, env dumps, raw transcript links, or private keys added |

## Required Negative Coverage

| Required case | Fixture status |
|---|---|
| duplicate `artifact_id` | PASS |
| duplicate path/register entry | PASS |
| active duplicate prompt/report family | PASS |
| `consumed_prompt` replayed as active | PASS |
| `audit_only` report used as instruction | PASS |
| same `source_task` + `scope_signature` active twice | PASS |
| superseded artifact preserved with `default_load=false` | PASS |
| harmless historical receipt duplicate label is WARN, not FAIL | PASS |

## Residuals

Task-service MCP returned contract PASS with `status=NOOP` and
`task_state_verified=false` for the prompt-scoped task id. Repository evidence
is complete. `attach_evidence` and `report_blocker` both returned
`PHYSICAL_TASK_WRITE_MISSING`; physical tracker write/readback remains not
proven in this local turn.
