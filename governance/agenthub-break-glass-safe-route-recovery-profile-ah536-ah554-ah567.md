---
artifact_id: agenthub-break-glass-safe-route-recovery-profile-ah536-ah554-ah567
artifact_type: permission-profile
owner_role: T1 Route Architect
source_task: AH-567 / AH-536 / AH-554
run_id: RUN-agenthub-p0-break-glass-safe-route-20260525
created_at: 2026-05-25
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# P0 Break-Glass Safe AgentHub Route Recovery Profile

Profile name:

`P0_BREAK_GLASS_SAFE_AGENTHUB_ROUTE_RECOVERY`

## Decision

This profile supersedes freeze-first, report-first, and permission-blocker-loop
behavior for the AH-536/AH-554/AH-567 chain. It authorizes one controlled
AgentHub live worker route for safe scoped recovery while preserving role
separation, rollback, redaction, and forbidden-contour gates.

## Role Boundary

| Role | Allowed | Forbidden |
|---|---|---|
| `T0_CONTROL` | read, classify, delegate, register, task readback, final user status | code/runtime/Docker/NPM/proxy/DB/firewall/product mutation |
| `T1_ROUTE_ARCHITECT` | attach this profile to the run, unblock stale route gates for this profile only | product/runtime repair, broad policy disable |
| `REGISTRAR` | repository receipt, index/register/queue update, stale artifact lifecycle update | runtime mutation, secret storage |
| `T2_CODEX_LIVE_WORKER` | scoped diagnostics and safe repair through AgentHub only | broad cleanup, DB mutation, secret dump, forbidden contours |
| `VERIFIER` | read-only public endpoint/service/repo/task readback | mutation, fake PASS |

## Allowed Scope

- AH-536/AH-554 public runtime/edge closure chain.
- AH-567 route-block/freeze-loop correction.
- AgentHub route-gate repair for this profile.
- Docker/runtime/edge checks and safe repair only by `T2_CODEX_LIVE_WORKER`
  through the AgentHub run.

## Forbidden Contours

- BMC / Appsmith / Margin Cockpit / port `20120`.
- n8n / `http://n8n:5678`.
- Stroyremont HTML/editor/content work.
- Unrelated client product code/HTML.
- Unrelated Docker projects/services.
- DB schema/data changes.
- Broad firewall/DNS/global proxy changes.

## T2 Safe Actions

- Read endpoint/service/Docker state.
- Read bounded recent logs without secrets.
- Inspect ports/listeners and existing compose/project metadata without env dumps.
- Start/restart only a known stopped in-scope service/container.
- Run `docker compose up -d` only for an existing authorized compose project
  while preserving named volumes.
- Correct only a known in-scope NPM/edge upstream.
- Run public endpoint readback.
- Produce redacted evidence.

## T2 Blocked Actions

- `docker system prune`, broad reset, wildcard delete, broad cleanup.
- Volume deletion or running-container deletion.
- DB schema/data mutation.
- Secret/env/private-key dump.
- Broad infrastructure rebuild.
- Unrelated restart.
- BMC/Appsmith/n8n/client-code mutation.
- Global firewall/DNS/proxy mutation.

## Blocker Mapping

Forbidden final blockers:

- `AGENTHUB_LIVE_WORKER_ROUTE_BLOCKED`
- `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`
- `AGENTHUB_PERMISSION_AUTH_REQUIRED`
- generic `blocked`

Allowed terminal blockers after safe alternate route is attempted:

- `AGENTHUB_PLATFORM_ADMIN_CREDENTIAL_REQUIRED`
- `GITHUB_CONTROL_SPINE_AUTH_REQUIRED`
- `YOUTRACK_AUTH_REQUIRED`
- `DOCKER_RUNTIME_AUTH_REQUIRED`
- `EDGE_NPM_AUTH_REQUIRED`
- `OWNER_ONLY_DESTRUCTIVE_AUTH_REQUIRED`

