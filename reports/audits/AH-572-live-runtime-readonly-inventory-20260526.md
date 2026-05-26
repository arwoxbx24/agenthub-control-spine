---
artifact_id: AH-572-live-runtime-readonly-inventory-20260526
artifact_type: audit_report
owner_role: T2/P4 Live Runtime Read Worker / Registrar
source_task: AH-572
run_id: RUN-P0-AH572-LIVE-READONLY-INVENTORY-20260526
created_at: 2026-05-26
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# AH-572 Live Runtime Read-Only Inventory

## Scope

This report records the AH-572 read-only Docker/NPM inventory after the scoped
T2/P4 live runtime read route was registered through AgentHub.

No Docker, Compose, NPM, database, proxy, firewall, DNS, SSL, package,
container, service, product, or client-project mutation was performed.

## Route Evidence

| Item | Result |
|---|---|
| Route id | `AH-572-T2P4-LIVE-READ-ONLY` |
| Route registration RUN | `RUN-P0-AH572-LIVE-READ-ROUTE-20260526` |
| Inventory RUN | `RUN-P0-AH572-LIVE-READONLY-INVENTORY-20260526` |
| Worker role | `T2_P4_LIVE_RUNTIME_READ_WORKER` |
| AgentHub merge status | SUCCESS |
| Path safety | PASS |
| Secret redaction | PASS |
| Client project write | false |
| Runtime mutation | none |

## Runtime Summary

| Check | Result |
|---|---|
| Docker daemon read | PASS; server and client version read successfully. |
| Container inventory read | PASS; bounded summary collected. |
| Network inventory read | PASS; bounded summary collected. |
| Compose project inventory read | PASS; bounded summary collected with internal paths categorized, not copied raw. |
| NPM reachability by container inventory | PASS; NPM container is present and running from container inventory view. |

## Container Inventory Summary

The read-only route observed ten running containers:

| Service family | Observed state | Public/bound ports summary |
|---|---|---|
| NPM edge manager | running | public 80, 81, and 443 bindings observed |
| Kutt application | running and healthy | public 3000 binding observed |
| Kutt database | running and healthy | internal database port only |
| Kutt cache | running | internal cache port only |
| MTProxy service | running | public Telegram proxy binding observed |
| YouTrack service | running | loopback-only management binding observed |
| Hiddify manager | running | no direct host port binding observed in Docker inventory |
| Stroy application service | running | internal web/runtime ports observed |
| 3x-ui service | running | several public service bindings observed |
| Stroy database | running | loopback database binding plus internal database port observed |

## Network Inventory Summary

The read-only route observed bridge, host, null, and service-specific bridge
networks. The report intentionally does not include raw internal paths, secrets,
or environment values.

## Compose Inventory Summary

The read-only route observed compose projects for service families including
3x-ui, Hiddify manager, Kutt, NPM edge manager, and Stroy. Some compose file
locations are in canonical workspace areas and some are legacy/non-canonical
path classes. This report records the class of evidence only and does not copy
raw internal paths.

## NPM Readback

NPM was verified only through Docker container inventory. No NPM UI/API edit,
proxy-host edit, generated config read, database read, or container exec was
performed.

## Validation

- `env_dump=false`.
- `secret_read=false`.
- `mutation=none`.
- `path_safety_gate=PASS`.
- `secret_redaction_gate=PASS`.
- `no_forbidden_zone_touched=true`.
- `client_project_write=false`.

## Result

AH-572 read-only live Docker/NPM inventory is complete with AgentHub-routed
evidence. This does not authorize or perform runtime repair.

Final state for this inventory scope: `DONE_WITH_EVIDENCE`.

