---
artifact_id: owner-input-validation-priority-guard-coverage-20260615
artifact_type: coverage-register
source_task: AH-803
run_id: AGENTHUB-OWNER-INPUT-VALIDATION-AND-PRIORITY-GUARD-20260615
lifecycle: active_control_candidate
default_load: false
safe_to_replay: false
---

# Owner Input Validation Priority Guard Coverage

| Artifact | Type | Source task | Status |
|---|---|---|---|
| `governance/owner-input-validation-and-priority-guard-policy.md` | governance policy | AH-803 | active-control-candidate |
| `schemas/owner_message_classification.schema.json` | schema | AH-803 | active-control-candidate |
| `schemas/owner_instruction_priority_decision.schema.json` | schema | AH-803 | active-control-candidate |
| `schemas/action_bound_owner_message.schema.json` | schema | AH-803 | active-control-candidate |
| `validators/owner_input_validation_priority_guard_validator.rb` | validator | AH-803 | active-control-candidate |
| `fixtures/owner-input-validation-priority-guard/fixtures.json` | eval fixtures | AH-803 | active-control-candidate |
| `runbooks/owner-input-validation-priority-guard-runbook.md` | runbook | AH-803 | active-control-candidate |
| `prompts/templates/owner-input-validation-priority-guard-worker-template.txt` | worker template | AH-803 | active-control-candidate |
| `reports/validations/AH-803-owner-input-validation-priority-guard-validation-20260615.md` | validation report | AH-803 | operational-receipt-candidate |
| `reports/receipts/AH-803-owner-input-validation-priority-guard-receipt-20260615.md` | implementation receipt | AH-803 | operational-receipt-candidate |

## Gate Coverage

- unsafe instruction rejection.
- priority conflict handling.
- no blind agreement.
- action-bound communication.
- scoped permission lanes.
- owner claim as investigation input.
- fake Done denial.
