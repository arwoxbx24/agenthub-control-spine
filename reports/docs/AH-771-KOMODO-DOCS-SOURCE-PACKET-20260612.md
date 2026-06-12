---
artifact_id: ah-771-komodo-docs-source-packet-20260612
artifact_type: docs-source-packet
owner_role: Docs Worker / Verifier
source_task: AH-771
run_id: RUN-AGENTHUB-SECRET-HANDLE-DOCS-FIRST-AUTOREPAIR-20260612
created_at: 2026-06-12
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# AH-771 Komodo Docs Source Packet

Retrieval date: 2026-06-12.

## Official sources

| Claim | Official source | Applicability |
|---|---|---|
| Komodo has Core and Periphery components. Core hosts API/browser UI; Periphery is a stateless agent used by Core for actions, usage, and logs. | https://komo.do/docs/intro | Supports service contour and live-read route model. |
| Komodo Core exposes REST and WebSocket API and supports CLI/NPM/curl programmatic access. | https://komo.do/docs/intro | Supports API-first auth/repair path before DB mutation. |
| Komodo supports role-based permissioning with Read, Execute, and Write levels. | https://komo.do/docs/configuration/permissioning | Supports scoped auth handle requirement. |
| Procedures and Actions orchestrate automation; procedures compose actions and can run stages. | https://komo.do/docs/resources | Supports schedule/procedure loop diagnosis. |
| Resources include Stacks, Procedures, Actions, Resource Sync, and built-in credential management for repos/registries. | https://komo.do/docs/resources | Supports microservice/schedule scope descriptor. |
| Server onboarding uses UI/API onboarding key, Periphery sends public key to Core, and subsequent communication uses key handshake. | https://komo.do/docs/setup/connect-servers | Supports Periphery/key/auth contour and owner-only key creation guide. |
| Configuration may be passed by env or mounted config file; env takes precedence. | https://komo.do/docs/setup/advanced | Supports config-metadata lookup without raw secret output. |
| Resource Sync can create/update/delete/deploy resources from TOML with computed sync actions. | https://komo.do/docs/automate/sync-resources | Supports caution that DB mutation is not first repair path. |

## Decision

For AH-771, official docs support API/UI/CLI and resource-level permissioning as first repair paths. Direct DB mutation is not first-line and requires Lane 7 with explicit owner approval, backup, exact target, dry-run, and rollback receipt.

## Stale risk

Medium. Komodo docs are current public docs, but live service version and local configuration were not re-read through a valid auth handle in this package.
