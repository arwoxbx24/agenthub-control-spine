---
artifact_id: AGENTHUB-P0-controlled-unfreeze-safe-permission-expansion-20260525
artifact_type: corrective-incident-report
owner_role: T0 Registrar / T1 Route Architect
source_task: AH-567 / AH-536 / AH-554
run_id: RUN-agenthub-p0-controlled-unfreeze-20260525
created_at: 2026-05-25
status: permission-profile-recorded
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# AgentHub P0 Controlled Unfreeze And Safe Permission Expansion

## Executive Decision

The previous broad freeze behavior is superseded for AH-536/AH-554/AH-567.
Repository evidence remains mandatory, but repository-first evidence must not
become a self-consuming blocker. The correct control is role-bound execution:
T0 audits, T1 repairs or grants the route, Registrar records evidence, T2 acts
inside the profile, and Verifier validates.

## Existing Tasks Reused

- `AH-567`: controlling P0 repo-first execution freeze/unfreeze incident.
- `AH-536`: parent live runtime incident.
- `AH-554`: child live runtime repair.

No new YouTrack task was created for this contract.

## Repository Binding

- Canonical repository: `arwoxbx24/agenthub-control-spine`.
- Branch reused: `agenthub/ah536-ah554-final-receipt-20260525`.
- Personal owner `arwoxb24` was not used.

## Permission Expansion

Profile installed:

`governance/agenthub-controlled-live-devops-permission-profile-ah536-ah554-ah567.md`

Profile name:

`P0_CONTROLLED_LIVE_DEVOPS_REPAIR_AH_536_AH_554_AH_567`

The profile authorizes only a future accepted T2 live worker route. It does not
authorize T0 runtime mutation.

## Current Route State

T0 can write repository and YouTrack evidence. AgentHub MCP sandbox routing is
available. A verified accepted live T2 route for Docker/NPM/edge repair has not
yet been proven in this session.

Therefore the previous terminal blocker
`AGENTHUB_LIVE_WORKER_ROUTE_BLOCKED` is remapped to the allowed owner/route
blocker `AGENTHUB_PERMISSION_AUTH_REQUIRED` until a live T2 route is actually
granted.

## Self-Critique

### What went wrong

The prior agent path mixed control-plane and runtime duties. It used direct
shell/runtime actions while the repository policies require T2 worker-owned
live mutation. It then wrote repository receipts that over-claimed closure, and
later had to contradict itself after fresh public readback showed active 502s.

### Five Whys

1. Why did the closure claim become wrong?
   Because `DONE_WITH_EVIDENCE` was written from a temporary endpoint state and
   T0-driven shell activity, not from accepted T2 worker evidence plus stable
   verifier readback.

2. Why did T0 touch runtime surfaces?
   Because the incident pressure was treated as permission to continue with
   direct shell actions when the live route was unclear.

3. Why did the live route stay unclear?
   Because `AGENTHUB_LIVE_WORKER_ROUTE_BLOCKED` was used as a terminal report
   loop instead of being converted into a T1 route/permission repair task inside
   the same control chain.

4. Why did reports multiply?
   Because each correction tried to document the previous contradiction without
   changing the permission model that caused the contradiction.

5. Why was the permission model insufficient?
   Because the control-spine had strong "do not bypass" rules but lacked a
   narrow "controlled unfreeze" profile that says how to proceed when safe work
   is possible but the worker route is missing.

### Corrective Architecture

The high-level fix is not another status receipt. The fix is a bounded
permission architecture:

- T0 cannot repair runtime.
- T1 must convert route blockers into permission profiles or exact owner-only
  blockers.
- T2 can repair only named, scoped, reversible live surfaces.
- Verifier must invalidate runtime Done when public readback contradicts it.
- Registrar must mark stale or contradicted receipts as evidence, not active
  instructions.

## Required Next Action

Grant or provide an accepted AgentHub live T2 worker route for:

`P0_CONTROLLED_LIVE_DEVOPS_REPAIR_AH_536_AH_554_AH_567`.

If the route cannot be granted by the platform/owner, the valid terminal blocker
is:

`AGENTHUB_PERMISSION_AUTH_REQUIRED`.

## Exclusions Confirmed

- BMC/Appsmith/Margin Cockpit/port `20120`: excluded.
- n8n / `http://n8n:5678`: excluded.
- Stroyremont HTML/editor/content: excluded.
- Client product code/HTML: excluded unless separately authorized.

## Status

Controlled unfreeze policy is recorded. Runtime repair is not executed by T0.
The next safe runtime action requires accepted T2 route authority.
