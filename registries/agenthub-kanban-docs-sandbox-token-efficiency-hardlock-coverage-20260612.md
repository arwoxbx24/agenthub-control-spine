---
artifact_id: agenthub-kanban-docs-sandbox-token-efficiency-hardlock-coverage-20260612
artifact_type: coverage-register
owner_role: T0 Registrar / T1 Architecture Broker / Verifier
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: current_baseline
default_load: false
safe_to_replay: false
---

# AH-767 Hardlock Package Coverage Register

This register records the installed repository coverage for PR #160 after the large base registers could not be safely replaced through the available connector without truncation risk. It is a repository artifact, not a chat-only status.

## Package

| Field | Value |
|---|---|
| Task | AH-767 |
| PR | #160 |
| Branch | agenthub/AH-767-kanban-docs-sandbox-token-hardlock-20260612 |
| Run | RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612 |
| Status | merge-ready after coverage register |
| Blocker | none for repository-control scope |

## Coverage

| Surface | Paths | Lifecycle |
|---|---|---|
| Policies | governance/agenthub-kanban-task-lifecycle-hardlock-policy.md; governance/agenthub-docs-first-source-packet-policy.md; governance/agenthub-sandbox-rehearsal-promotion-policy.md; governance/agenthub-token-efficiency-and-prompt-garbage-policy.md; governance/agenthub-authority-broker-packfix-policy.md; governance/agenthub-microservice-scope-broker-policy.md; governance/agenthub-github-youtrack-vcs-binding-policy.md | active_policy |
| Schemas | schemas/agenthub_task_lifecycle.schema.json; schemas/agenthub_authority_envelope.schema.json; schemas/agenthub_packfix_event.schema.json; schemas/agenthub_docs_source_packet.schema.json; schemas/agenthub_sandbox_descriptor.schema.json; schemas/agenthub_microservice_descriptor.schema.json; schemas/agenthub_token_efficiency_receipt.schema.json; schemas/agenthub_github_youtrack_binding_receipt.schema.json | active_control |
| Validators | validators/agenthub_task_lifecycle_validator.rb; validators/agenthub_authority_envelope_validator.rb; validators/agenthub_packfix_loop_validator.rb; validators/agenthub_docs_first_validator.rb; validators/agenthub_sandbox_rehearsal_validator.rb; validators/agenthub_token_efficiency_validator.rb; validators/agenthub_github_youtrack_binding_validator.rb; validators/agenthub_no_prompt_dump_validator.rb | active_control |
| Fixtures | evals/agenthub-kanban-lifecycle/fixtures.json; evals/agenthub-docs-first/fixtures.json; evals/agenthub-sandbox-rehearsal/fixtures.json; evals/agenthub-token-efficiency/fixtures.json; evals/agenthub-packfix-loop/fixtures.json; evals/agenthub-github-youtrack-binding/fixtures.json | active_control |
| Runbooks | runbooks/agenthub-kanban-board-stage-governor.md; runbooks/agenthub-packfix-authority-broker.md; runbooks/agenthub-sandbox-rehearsal-and-promotion.md; runbooks/agenthub-docs-source-packet.md; runbooks/agenthub-token-efficiency-audit.md; runbooks/agenthub-microservice-descriptor-registry.md | active_control |
| Descriptor registry | registries/agenthub-microservice-descriptor-registry.md | current_baseline |
| Receipts and validations | reports/receipts/AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-RECEIPT-20260612.md; reports/validations/AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-VALIDATION-20260612.md; reports/patches/AH-767-register-coverage-append-patch-20260612.md | operational_receipt |

## Closure Decision

The previous AH-767 blocker `REGISTER_APPEND_ROUTE_PENDING` is closed for the repository-control scope by this dedicated coverage register plus the existing register patch receipt. The base register append remains a future registrar hygiene improvement, not a blocker for PR #160 merge.
