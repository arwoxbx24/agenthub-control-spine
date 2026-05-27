---
artifact_id: AH-575-komodo-import-route-discovery-20260527
artifact_type: operational_receipt
owner_role: T2 Live Runtime Read Worker / Registrar / Verifier
source_task: AH-575
run_id: RUN-P0-KOMODO-KUTT-IMPORT-ROUTE-DISCOVERY-20260527
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
created_at: 2026-05-27
---

# AH-575 Komodo Import Route Discovery Receipt

## Scope

Discover the safe import route for registering the prepared `kutt` compose
project in Komodo after the first migration preflight.

This receipt is read-only. It does not import the stack, read admin secrets,
create API keys, edit compose, restart services, or change public edge routing.

## Readback

- Local Komodo panel: reachable.
- Local Komodo CLI binaries checked: not installed.
- Public docs route: reachable.
- Public API docs route exposed authentication and API-key management routes.
- Unauthenticated generic API routes were not usable for stack import.

## Decision

The next implementation step requires an authenticated Komodo API/UI route:

- preferred: a scoped Komodo API key/handle already created by the owner or by
  an approved authenticated worker route;
- action: register/import the `kutt` compose project as a Komodo stack using the
  preflight metadata from `AH-575-kutt-first-migration-preflight-20260527`;
- forbidden in that next step: raw secret printing, environment dumps, database
  access, service restart, destructive Docker action, or public edge mutation.

## Evidence Artifacts

- `@agenthub-runs/p0-komodo-kutt-import-route-discovery-20260527/komodo-import-route-discovery-readonly.md`
- `@agenthub-runs/p0-komodo-kutt-docs-hints-20260527/komodo-docs-hints-readonly.md`

## Residual

`KOMODO_AUTHENTICATED_IMPORT_ROUTE_REQUIRED`

This is a route gate, not a server outage. The server and candidate service were
already verified as running.

## Final State

`READY_BLOCKED_BY_AUTHENTICATED_IMPORT_ROUTE`
