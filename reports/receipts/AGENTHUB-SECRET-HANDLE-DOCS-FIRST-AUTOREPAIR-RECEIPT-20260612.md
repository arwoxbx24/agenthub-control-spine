---
artifact_id: agenthub-secret-handle-docs-first-autorepair-receipt-20260612
artifact_type: receipt
source_task: AH-771
run_id: RUN-AGENTHUB-SECRET-HANDLE-DOCS-FIRST-AUTOREPAIR-20260612
created_at: 2026-06-12
lifecycle_status: owner_gated_not_done
---

# AH-771 Secret-Handle Docs-First Autorepair Receipt

## Installed Controls

- `governance/agenthub-secret-handle-docs-first-autorepair-policy.md`
- `schemas/agenthub_secret_handle_resolution.schema.json`
- `schemas/agenthub_auth_handle_probe.schema.json`
- `schemas/agenthub_owner_auth_miniguide.schema.json`
- `validators/agenthub_secret_handle_autorepair_validator.rb`
- `evals/agenthub-secret-handle-autorepair/fixtures.json`
- `runbooks/agenthub-secret-handle-docs-first-autorepair.md`
- `reports/docs/AH-771-KOMODO-DOCS-SOURCE-PACKET-20260612.md`
- `reports/guides/AH-771-owner-auth-handle-guide-20260612.html`
- `reports/validations/AGENTHUB-SECRET-HANDLE-DOCS-FIRST-AUTOREPAIR-VALIDATION-20260612.md`
- `registries/agenthub-secret-handle-docs-first-autorepair-coverage-20260612.md`

## AH-771 Runtime Decision

The control package confirms that `KOMODO_AUTH_HANDLE_MISSING` is not a generic routine final blocker. For AH-771, the current evidence shows no preserved reusable Komodo auth handle after prior recovery work and no safe live repair path without a current approved handle or explicit Lane 7 owner approval.

## Safety

- No raw secrets, tokens, env dumps, or private keys are stored.
- No Komodo DB mutation was performed.
- No Docker, proxy, Nginx, firewall, prune, restart, down, or delete operation was performed.
- No unrelated project or service was touched.

## Current Terminal State

AH-771 must remain open in owner-gated state, not Done.

Typed blocker: `OWNER_ONLY_SECRET_HANDLE_CREATION_REQUIRED`.

Owner guide: `reports/guides/AH-771-owner-auth-handle-guide-20260612.html`.

After the owner creates/stores the scoped handle in the approved registry, the same contour can continue with auth probe, exact schedule readback, scoped repair, validation, and Done readback.