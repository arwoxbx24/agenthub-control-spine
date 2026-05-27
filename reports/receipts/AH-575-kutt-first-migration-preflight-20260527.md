---
artifact_id: AH-575-kutt-first-migration-preflight-20260527
artifact_type: operational_receipt
owner_role: T2 Live Runtime Read Worker / Registrar / Verifier
source_task: AH-575
run_id: RUN-P0-KOMODO-KUTT-FIRST-MIGRATION-20260527
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
created_at: 2026-05-27
---

# AH-575 Kutt First Migration Preflight Receipt

## Scope

Select `kutt-server-1` as the first Komodo Docker-orchestrator migration
candidate and collect rollback/readiness metadata through AgentHub scoped T2
read-only routes.

This is not a public edge, DNS, SSL, firewall, database, or proxy change. It is
also not a service restart or destructive Docker operation.

## AgentHub Runs

- `RUN-P0-KOMODO-KUTT-FIRST-MIGRATION-20260527`: candidate readiness,
  rollback facts, local app readback.
- `RUN-P0-KOMODO-KUTT-STACK-METADATA-20260527`: compose project metadata for
  Komodo stack import.

Both merge reports returned `SUCCESS` with no blocking residuals.

## Readback

- Candidate: `kutt-server-1`.
- Candidate state: running and healthy.
- Local application readback: HTTP 302 on the local published port.
- Komodo local panel readback: HTTP 200.
- Compose project: `kutt`.
- Compose service: `server`.
- Compose project file: `docker-compose.yml` in the project working directory.
- Related services: `kutt-postgres-1`, `kutt-redis-1`, `kutt-server-1`.

## Import Contract

The safe Komodo import shape is:

- resource type: compose stack;
- stack name: `kutt`;
- server: local Komodo server;
- project name: `kutt`;
- run directory: existing short-links service directory;
- compose file: `docker-compose.yml`;
- primary service: `server`;
- dependency services: postgres and redis from the same compose project.

The next mutation must be a scoped Komodo stack registration/import worker. It
must not change public edge routing unless a separate public-edge scope is
present.

## Forbidden Scope Audit

- No environment dump.
- No secret read.
- No compose edit.
- No service restart.
- No Docker network mutation.
- No database access.
- No public edge, DNS, SSL, firewall, or proxy mutation.
- No client project write.

## Evidence Artifacts

- `@agenthub-runs/p0-komodo-kutt-first-migration-20260527/komodo-kutt-preflight-readonly.md`
- `@agenthub-runs/p0-komodo-kutt-stack-metadata-20260527/komodo-kutt-stack-metadata-readonly.md`

## Final State

`READY_FOR_SCOPED_KOMODO_STACK_IMPORT`
