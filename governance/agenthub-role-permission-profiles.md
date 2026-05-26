---
artifact_id: agenthub-role-permission-profiles
artifact_type: governance_policy
owner_role: T1 Architect
source_task: AH-590
run_id: RUN-P0-FULL-REQ-BACKEND-ONLY-ARCH-20260526
created_at: 2026-05-26
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Role Permission Profiles

## Profiles

| Profile | Allows | Denies |
|---|---|---|
| `P0_T0_CONTROL_READ_ROUTE` | task readback, repo metadata, scope classification, dispatch, verification, receipts | code, shell, Docker, NPM, DB, proxy, firewall, product/runtime mutation |
| `P1_T1_ARCHITECT_TZ_ROUTE` | architecture, ADR, technical assignment, policy design | direct production mutation |
| `P2_REGISTRAR_REPO_PATCH_ROUTE` | control-spine reports, receipts, INDEX, ARTIFACT_REGISTER, PR_QUEUE_REGISTER, branch/PR lifecycle | product/runtime mutation and evidence deletion |
| `P3_CODEX_CODE_WORKER_ROUTE` | scoped code/config/test edits in assigned repo branch | production mutation unless separately granted |
| `P4_LIVE_RUNTIME_READ_ROUTE` | read-only Docker/NPM/system/service inventory with redaction | restart, edit, prune, delete, DB/proxy/firewall/DNS/SSL mutation |
| `P5_T2_LIVE_REPAIR_ROUTE` | targeted repair with rollback, service allowlist, validation | unrelated services, destructive global cleanup |
| `P6_QA_BROWSER_USER_OUTCOME_ROUTE` | browser/API validation and screenshots/evidence | mutation except authorized test data |

## T0 Boundary

T0 is never an implementation author. T0 may only route, verify, register,
classify, and escalate. Any T0 request for code, shell, Docker, NPM, DB, proxy,
firewall, runtime, product, or service mutation must fail before tool execution.

## Missing Profile Rule

If a safe profile is missing, AgentHub creates a same-run platform remediation
task and receipt. The owner is interrupted only for credentials, identity,
legal/payment, destructive/global infrastructure, or irreversible gates.

