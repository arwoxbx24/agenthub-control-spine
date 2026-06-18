---
artifact_id: agenthub-scoped-permission-elevation-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker / T0 Registrar / T2 Worker / Verifier
source_task: AH-743
run_id: RUN-AGENTHUB-YOUTRACK-BOARD-LIFECYCLE-SCOPED-AUTONOMY-20260611
created_at: 2026-06-11
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Scoped Permission Elevation Policy

## Purpose

Routine task, route, board, register, PR, and read-only diagnostic failures must be repaired inside the same contour when the action is task-bound, non-destructive, and receipt-backed.

## Lanes

| Lane | Surface | Allowed roles | Allowed actions | Hard stops |
|---|---|---|---|---|
| 0 | Prompt, policy, register | T0, T1, Registrar, Verifier | governance artifacts, schemas, validators, receipts, issue comments | runtime mutation |
| 1 | YouTrack task system | T0/T1 route, T2 YouTrack Worker, Verifier | create/update/comment/link, duplicate search, stage movement, board readback | broad backlog closure |
| 2 | GitHub control-spine | Registrar, T2 Git Worker | branch/PR/artifact/register updates, SHA-pinned stale branch delete | branch protection or CODEOWNERS mutation |
| 3 | Microservice read-only diagnostics | T2 diagnostic worker | process/container status, recent redacted logs, healthcheck | restart, delete, DB write, secret dump |
| 4 | Microservice scoped repair | T2 repair worker | one-service restart, one config repair, rollback, healthcheck | broad Docker/DB/proxy/firewall mutation |
| 5 | Deployment/config change | T2 deploy worker | scoped deploy or config patch with rollback | unscoped rollout |
| 6 | Destructive/irreversible | T2 destructive worker plus owner or pre-approved proof | exact target delete with backup/replacement/receipt | wildcard cleanup and active production delete |

## Permission manifest

Every elevated action must record `run_id`, `task_id`, `lane`, `role`, `allowed_surfaces`, `forbidden_surfaces`, `rollback`, `evidence`, `expiry`, and `receipt_path`.

## Safety

Owner approval can widen only the declared lane. It cannot silently authorize secret exposure, broad prune/reset, production destructive mutation, or bypassing board lifecycle evidence.
