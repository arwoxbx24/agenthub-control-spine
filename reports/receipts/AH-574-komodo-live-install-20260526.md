---
artifact_id: ah-574-komodo-live-install-20260526
artifact_type: operational-receipt
owner_role: T2 Live Runtime Worker / Verifier / Registrar
source_task: AH-574
run_id: RUN-P0-KOMODO-VERIFY-AND-RECEIPT-20260526
created_at: 2026-05-26
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# AH-574 Komodo Live Install Receipt

## Scope

This receipt records the controlled Komodo baseline installation and
post-install validation for the Komodo task family under AH-571.

Runtime scope was limited to the Komodo Docker project and local panel
validation. Nginx Proxy Manager, external proxy hosts, DNS, SSL, firewall, PM2,
client product code, and unrelated databases were not changed.

## Implementation Evidence

- Komodo stack was moved from the failed v1/Mongo-auth attempt to the Komodo v2
  compose model.
- Only the Komodo Docker project was reset after the first failed, unused
  install attempts left an incompatible Mongo auth volume.
- Containers validated by the AgentHub verifier:
  - `komodo-core-1`: `Up`, image `ghcr.io/moghtech/komodo-core:2`.
  - `komodo-periphery-1`: `Up`, image `ghcr.io/moghtech/komodo-periphery:2`.
  - `komodo-mongo-1`: `Up`, image `mongo:8`.
- Local panel validation returned `http_code=200` for
  `http://127.0.0.1:9120/`.
- Initial admin credentials were stored server-side in a root-only file with
  mode `600`; credentials are intentionally not recorded in this repository.

## Validation Evidence

AgentHub verifier:

- RUN_ID: `RUN-P0-KOMODO-VERIFY-AND-RECEIPT-20260526`
- Worker: `VERIFIER-komodo-local-panel`
- Task: `AH-574-komodo-local-panel-validation`
- Evidence path:
  `@agenthub-runs/p0-komodo-verify-and-receipt-20260526/komodo-local-panel-validation.md`
- Validation: `PASS`
- Secret redaction gate: `PASS`
- Path safety gate: `PASS`

Verifier summary:

- Local panel: `http_code=200`.
- Komodo Core log tail reports `Komodo Core version: v2.2.0`.
- No recent panic/authentication failure was present in the verifier evidence.
- Forbidden-scope checks recorded:
  - NPM/proxy mutation: false.
  - Other-service DB mutation: false.
  - Firewall mutation: false.
  - PM2 mutation: false.
  - Client project write: false.

## Task Impact

- AH-578 live route blocker is resolved for the Komodo preflight path because
  scoped live read/install evidence now exists.
- AH-574 local Core/Periphery baseline is complete with evidence.
- AH-571 production rollout is no longer blocked on Komodo local baseline.

External public-domain exposure is deliberately not claimed here. If public
Komodo access is required, it must be a separate scoped NPM/proxy task with an
explicit allowed proxy-host action and rollback plan.

## Final State

DONE_WITH_EVIDENCE for the AH-574 local Komodo Core/Periphery baseline.
