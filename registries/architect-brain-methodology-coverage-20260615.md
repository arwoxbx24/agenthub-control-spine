---
artifact_id: architect-brain-methodology-coverage-20260615
artifact_type: coverage-register
source_task: AH-794
run_id: ARCHITECT-BRAIN-UNIVERSAL-AGENT-PROTOCOL-V5-20260615
lifecycle: active_control_candidate
default_load: false
safe_to_replay: false
---

# Architect Brain Methodology Coverage

| Artifact | Type | Source task | Status |
|---|---|---|---|
| `governance/methodologies/architect-brain-universal-agent-protocol-v5.md` | methodology registry | AH-794 | active-control-candidate |
| `schemas/architect_brain_methodology_receipt.schema.json` | schema | AH-794 | active-control-candidate |
| `validators/architect_brain_methodology_validator.rb` | validator | AH-794 | active-control-candidate |
| `fixtures/architect-brain-methodology/fixtures.json` | eval fixtures | AH-794 | active-control-candidate |
| `registries/architect-brain-methodology-coverage-20260615.md` | coverage register | AH-794 | current-baseline-candidate |
| `reports/receipts/AH-794-architect-brain-methodology-receipt-20260615.md` | implementation receipt | AH-794 | operational-receipt-candidate |

## Control Mapping

- Full eight-phase evidence cycle: ALLOW.
- Missing phase: BLOCK.
- Missing hallucination guard: BLOCK.
- Missing mutation guard: BLOCK.
- Attempted system policy override: BLOCK.
- Done without evidence/readback: BLOCK.
