---
artifact_id: agenthub-secrets-handle-registry-runbook
artifact_type: runbook
owner_role: T2 Secret Handle Registrar / Security Verifier
source_task: AH-590
run_id: RUN-P0-SELF-HEALING-CORE-20260528
created_at: 2026-05-28
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Secrets Handle Registry

## Decision

Control-spine stores only redacted secret-handle metadata. Secret values stay in
a secured local store or provider secret manager and must not be committed,
printed, pasted into chat, or included in receipts.

## Allowed Secure Store Shape

- `/secrets/manifest.redacted.yaml`
- `/secrets/services/<service-name>.env`
- `/secrets/providers/<provider-name>.env`
- `/secrets/owners/<owner-gate>.md`

The exact secure-store path is environment-owned and must not be discovered by
blind T0 scanning.

## Redacted Manifest Fields

- `secret_handle_id`
- `service`
- `provider`
- `required_for`
- `owner`
- `rotation_policy`
- `allowed_roles`
- `allowed_surfaces`
- `location_hint` without secret value
- `acquisition_guide` if absent

## Missing Handle Flow

1. Query the redacted manifest or approved handle registry.
2. If metadata is absent, create a metadata-only self-healing event.
3. If no agent can acquire the handle safely, write a two-or-three sentence
   owner acquisition guide.
4. Mark `WAITING_OWNER_SECRET_HANDLE` only for a true owner-only secret gate.

Forbidden: raw env dumps, token display, private-key display, broad filesystem
secret scanning by T0, and committing secret values.
