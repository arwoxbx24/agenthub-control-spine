---
artifact_id: agenthub-controlled-live-devops-permission-profile-ah536-ah554-ah567
artifact_type: permission-profile
owner_role: T1 Route / Permission Architect
source_task: AH-567 / AH-536 / AH-554
run_id: RUN-agenthub-p0-controlled-unfreeze-20260525
created_at: 2026-05-25
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# P0 Controlled Live DevOps Repair Permission Profile

Profile name:

`P0_CONTROLLED_LIVE_DEVOPS_REPAIR_AH_536_AH_554_AH_567`

## Purpose

This profile replaces the self-consuming freeze loop for the AH-536/AH-554/AH-567
chain. Repository evidence remains mandatory, but `AGENTHUB_LIVE_WORKER_ROUTE_BLOCKED`
is no longer a terminal state for this chain. It is a route defect that must be
repaired or escalated to an owner-only permission blocker.

## Roles

| Role | Allowed | Forbidden |
|---|---|---|
| `T0_CONTROL` | audit, classify, route, register, YouTrack/repo evidence, final readback | runtime mutation, Docker/proxy/DB/firewall/service/product repair |
| `T1_ROUTE_ARCHITECT` | route repair, permission profile updates, guardrail updates | product code, live repair unless separately assigned as T2 |
| `REGISTRAR` | repository evidence, `INDEX.md`, `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, YouTrack evidence comments | runtime mutation, task-service replacement, secret storage |
| `T2_DEVOPS_WORKER` | scoped live diagnostics and safe repair after authorization | broad cleanup, destructive actions, DB mutation, BMC/Appsmith/n8n/client product code |
| `VERIFIER` | read-only endpoint/service/repo/task validation | mutation, fake PASS, sandbox-only Done |

## Allowed Incident Scope

- AH-536/AH-554 public `502` runtime edge closure chain.
- AH-567 controlled unfreeze and route defect correction.
- AgentHub route repair required to unblock the chain.

## Forbidden Contours

- BMC / Appsmith / Margin Cockpit / port `20120`.
- n8n / `http://n8n:5678`.
- Stroyremont HTML/editor/content/news/image work.
- Client product code/HTML unless a separate current task authorizes it.
- Unrelated Docker projects, containers, services, databases, firewall, DNS, or
  global proxy state.

## T2 Permission Classes

| Class | Scope |
|---|---|
| `P4_LIVE_RUNTIME_READ` | public endpoint matrix, bounded Docker inventory, port/listener checks, bounded redacted logs, NPM upstream readback |
| `P5_LIVE_RUNTIME_MUTATE` | start/restart a known existing service/container, compose up a verified existing compose project preserving named volumes, recreate a missing known container from existing compose |
| `P8_PROXY_EDGE_SCOPED` | exact NPM/edge upstream correction for the authorized host only, with backup and rollback note |

## T2 Allowed Actions

- Read before write.
- Start/restart only named in-scope services proven down or unhealthy.
- Run targeted compose up for existing compose files while preserving named
  volumes.
- Recreate missing containers only from existing compose/config evidence.
- Restore known semantic upstream bridge targets already established by accepted
  prior evidence.
- Reload/restart only the exact in-scope proxy component when required.
- Run public endpoint readback after repair.

## T2 Forbidden Actions

- `docker system prune`, broad reset, wildcard delete, broad cleanup.
- Running container deletion.
- Active volume deletion.
- DB schema/data mutation.
- Secret/env dump.
- Global firewall/DNS/proxy mutation.
- BMC/Appsmith/n8n mutation.
- Client product code or HTML mutation.
- Unrelated service restart.

## Required Evidence Before Mutation

- Task ids: `AH-536`, `AH-554`, `AH-567`.
- RUN_ID.
- Worker id and role.
- Exact endpoint list.
- Exact service/container/NPM host list.
- Forbidden contours listed.
- Rollback/checkpoint reference.
- Redaction statement.

## Required Evidence After Mutation

- Before/after endpoint matrix.
- Changed component list.
- Rollback snapshot or restore note.
- No-secret statement.
- No-BMC/Appsmith/n8n statement.
- Verifier readback.
- YouTrack comments and field readback.
- Repository final receipt.

## Blocker Mapping

Forbidden terminal blockers:

- `AGENTHUB_LIVE_WORKER_ROUTE_BLOCKED`
- `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`
- generic `blocked`

Allowed terminal blockers:

- `AGENTHUB_PERMISSION_AUTH_REQUIRED`
- `DOCKER_RUNTIME_AUTH_REQUIRED`
- `EDGE_NPM_AUTH_REQUIRED`
- `OWNER_ONLY_DESTRUCTIVE_AUTH_REQUIRED`

If the live worker route cannot be granted or repaired inside AgentHub, the
correct final blocker is `AGENTHUB_PERMISSION_AUTH_REQUIRED`.
