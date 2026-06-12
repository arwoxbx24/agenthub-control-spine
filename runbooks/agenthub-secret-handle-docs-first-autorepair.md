---
artifact_id: agenthub-secret-handle-docs-first-autorepair-runbook
artifact_type: runbook
owner_role: Authority Broker / Secret Handle Resolver / Verifier
source_task: AH-771
run_id: RUN-AGENTHUB-SECRET-HANDLE-DOCS-FIRST-AUTOREPAIR-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Secret-Handle Docs-First Autorepair Runbook

## Purpose

Use this runbook when an active contour reaches an authentication or runtime route blocker. The worker must exhaust approved handle metadata, official docs, prior receipts, and scoped authority routes before owner chat.

## Flow

1. Bind to one task id and one RUN_ID.
2. Read the current task stage, blocker fields, and prior receipts.
3. Build or reuse an official docs packet for the target service.
4. Create a scope descriptor for the project, service, allowed surfaces, forbidden zones, rollback, and validation layers.
5. Create an authority envelope for the next lane.
6. Run secret-handle metadata lookup. Never print raw values.
7. Run auth probe through the approved worker. Return only redacted proof.
8. If a usable handle exists, run live-read diagnostics inside the same contour.
9. If official API or UI supports a reversible exact repair and Lane 6 authority exists, repair only the scoped target and validate before/after state.
10. If no usable handle exists, create the owner HTML mini-guide and keep the issue owner-gated, not Done.
11. If DB, volume, global proxy, firewall, or irreversible mutation is required, stop at Lane 7 owner approval.
12. Update YouTrack stage, evidence, receipt, and blocker fields with readback.

## Komodo AH-771 Pattern

Target schedule/procedure name: `AgentHub Auto Start Managed Stacks`.

Allowed before owner gate:
- official Komodo docs packet;
- secret-handle registry metadata lookup;
- redacted auth probe;
- read-only schedule/procedure discovery when a handle exists;
- exact reversible disable through supported API/UI when Lane 6 exists.

Forbidden without Lane 7:
- direct DB mutation;
- broad schedule cleanup;
- restart/down/delete/prune;
- raw secret or env dump;
- unrelated Komodo stack changes.

## Closure

Done is allowed only when the target action is completed and validated with readback. If the handle is missing after exhaustive internal resolution, final state is `OWNER_ONLY_SECRET_HANDLE_CREATION_REQUIRED` with the HTML guide path.