---
artifact_id: agenthub-universal-infrastructure-scope-broker-coverage-20260612
artifact_type: registry_coverage
source_task: AH-772
run_id: RUN-AGENTHUB-UNIVERSAL-INFRASTRUCTURE-SCOPE-BROKER-20260612
created_at: 2026-06-12
lifecycle_status: active_control_coverage
---

# AH-772 Universal Infrastructure Scope Broker Coverage

| Path | Coverage |
| --- | --- |
| `governance/agenthub-universal-infrastructure-scope-broker-policy.md` | Universal contour, lane, PackFix, sandbox, evidence, and anti-service-specific policy |
| `schemas/agenthub_universal_microservice_descriptor.schema.json` | Generic service/component descriptor |
| `schemas/agenthub_universal_authority_envelope.schema.json` | Lane-scoped authority envelope |
| `schemas/agenthub_universal_packfix_event.schema.json` | Same-RUN PackFix event |
| `schemas/agenthub_universal_sandbox_descriptor.schema.json` | Sandbox/rehearsal descriptor |
| `validators/agenthub_universal_infrastructure_scope_broker_validator.rb` | Fixture validator for descriptor and negative gates |
| `evals/agenthub-universal-infrastructure-scope-broker/fixtures.json` | Positive/negative fixture cases |
| `runbooks/agenthub-universal-infrastructure-scope-broker.md` | Operator runbook |
| `reports/docs/AH-772-UNIVERSAL-INFRASTRUCTURE-DOCS-SOURCE-PACKET-20260612.md` | Official docs packet |
| `reports/validations/AGENTHUB-UNIVERSAL-INFRASTRUCTURE-SCOPE-BROKER-VALIDATION-20260612.md` | Validation evidence |
| `reports/receipts/AGENTHUB-UNIVERSAL-INFRASTRUCTURE-SCOPE-BROKER-RECEIPT-20260612.md` | Receipt |

## Register Decision

This package is global AgentHub infrastructure governance. It is not service-local and not Komodo-specific. It should be consumed as a universal contour broker control for future infrastructure/microservice work.