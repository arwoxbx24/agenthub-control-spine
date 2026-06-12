---
artifact_id: ah-767-register-coverage-append-patch-20260612
artifact_type: register-patch-proposal
owner_role: Registrar
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: patch-proposal
default_load: false
safe_to_replay: false
---

# AH-767 Register Coverage Append Patch

Append the following coverage rows before PR #160 merge if a safe append route is available.

## INDEX.md

Add section `PR #160 AgentHub Kanban Docs Sandbox Token Efficiency Hardlock Coverage` with rows for all AH-767 governance policies, schemas, validators, eval fixtures, runbooks, registry, validation report, and receipt.

## ARTIFACT_REGISTER.md

Add the same artifacts as `active_policy`, `active_control`, `current_baseline`, or `operational_receipt`; `default_load=false`; `safe_to_replay=false`; source task `AH-767`.

## PR_QUEUE_REGISTER.md

Add row:

| `#160` | `AH-767` | `RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612` | `agenthub/AH-767-kanban-docs-sandbox-token-hardlock-20260612` | T1 Architecture Broker / T0 Registrar / Verifier | `ACTIVE_CONTROL_CANDIDATE` | Installs AgentHub kanban/docs/sandbox/token-efficiency hardlock package. | PR `#160`; receipt; validation report; changed-file readback. | `REGISTER_APPEND_ROUTE_PENDING` until physical register append is applied. |

## Reason this patch exists

The current GitHub connector route supports full-file replace but not safe append for very large registers. Replacing large registers without a deterministic append tool risks accidental truncation. This patch records exact required content and blocker scope.
