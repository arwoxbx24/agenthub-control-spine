---
artifact_id: p0-task-debt-consolidation-receipt-20260527
artifact_type: operational_receipt
owner_role: Registrar / Verifier
source_task: AH-590
run_id: RUN-P0-T0-HARD-STOP-ISOLATION-20260527
created_at: 2026-05-27
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# P0 Task-Debt Consolidation Receipt

## Decision

No new YouTrack task was created for this corrective package because current
scope is covered by existing AgentHub-core parents:

- AH-590: backend-only repo-first architecture governance.
- AH-570: AgentHub-core permission/hook/policy control.
- AH-554: live-root hard enforcement and live-worker safety lineage.

## Scope Families

Task-debt grouping for future agents:

| Scope family | Parent / anchor | Closure rule |
|---|---|---|
| AgentHub core/control-plane | AH-590 / AH-570 | Close only from policy, runtime enforcement, register, and YouTrack evidence. |
| Docker/NPM/live-runtime route | AH-554 / AH-572 | Close only from scoped T2/P4 route evidence; T0 shell proof is invalid. |
| Komodo | AH-571 family | Keep local baseline, NPM public route, migration, procedures, and final acceptance separate. |
| VPN/Hiddify/MTProxy | AH-569 | Domain-isolated; do not mix with NPM/Komodo. |
| Product apps | product-specific tasks | App login/homepage or container Up is not product Done. |
| Repository hygiene | AH-585 / registrar | Registrar only; no evidence deletion. |

## Task Explosion Breaker

Before creating any new task, agents must compare:

- normalized problem statement;
- `scope_signature`;
- parent issue;
- repo and branch;
- RUN_ID;
- intended role and worker profile;
- blocker type.

If an active matching task exists, update/link that task. Do not create a
duplicate.

## Final State

Task-debt receipt created for governance/control-spine scope. It does not close
domain/runtime/product tasks and does not claim public product outcomes.
