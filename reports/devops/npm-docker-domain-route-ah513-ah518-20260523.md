---
artifact_id: npm-docker-domain-route-ah513-ah518-20260523
artifact_type: devops-worker-report
owner_role: Scoped Implementation Worker
source_task: AH-513/AH-518
run_id: RUN-npm-docker-ah513-ah518-domain-route-20260523
created_at: 2026-05-23
status: partial-with-blocker
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
project_scope: proxy-manager/docker-addressing
---

# NPM Docker Addressing Worker Report

## Scope

Task ids: `AH-513`, `AH-518`.

This worker handled only Proxy Manager + Docker addressing. It did not perform Telegram MTProxy work and did not touch VPN, Railway, AH-509, unrelated client projects, secrets, databases, firewall broad rules, object storage, or product code.

## Problem Name

`raw-ip-upstream-addressing-in-proxy-manager`

Proxy Manager contained many `172.*` and `127.*` upstream destinations. The safe standard is not a single global mask. The selected route types are:

- Docker service DNS for containers already on `nginx-proxy-manager_default`.
- Scoped Docker TCP bridge containers for host/gateway services that are not resolvable through Docker DNS.
- Existing raw IP rows remain only where service ownership could not be proven.

## Implementation

Checkpoint/rollback:

- Pre-change NPM rows were saved under the run artifact directory as redacted and full rollback JSON.
- Active Proxy Manager compose files were backed up before changing `extra_hosts`.
- Rollback is to restore the saved compose files, recreate Proxy Manager, and PUT saved NPM row JSON back through the API.

Changed runtime services/config:

- Added scoped `extra_hosts` names to the active Proxy Manager compose files:
  - `host.docker.internal`
  - `host.npm.internal`
  - `host.gitmirror.internal`
- Recreated only `nginx-proxy-manager-app-1`.
- Created scoped bridge containers on `nginx-proxy-manager_default`:
  - `npm-route-host-20510`
  - `npm-route-host-4200`
  - `npm-route-host-9210`
  - `npm-route-host-3600`
  - `npm-route-host-3601`
  - `npm-route-host-9011`
  - `npm-route-host-3100`

Updated NPM destinations:

| Domain | Before | After |
|---|---|---|
| `b244.ru` | `172.17.0.1:3000` | `kutt-server-1:3000` |
| `www.b244.ru` | `172.17.0.1:3000` | `kutt-server-1:3000` |
| `arwox.b244.ru` | `172.17.0.1:20510` | `npm-route-host-20510:20510` |
| `pdf-generator.b244.ru` | `172.17.0.1:4200` | `npm-route-host-4200:4200` |
| `dash.b244.ru` | `172.20.0.1:9210` | `npm-route-host-9210:9210` |
| `pm2.b244.ru` | `172.22.0.1:9210` | `npm-route-host-9210:9210` |
| `transcribe.b244.ru` | `172.17.0.1:3600` | `npm-route-host-3600:3600` |
| `dev.transcribe.b244.ru` | `172.17.0.1:3601` | `npm-route-host-3601:3601` |
| `vphdffy.b244.ru` | `172.20.0.1:9011` | `npm-route-host-9011:9011` |
| `yubikey-v2.b244.ru` | `172.17.0.1:3100` | `npm-route-host-3100:3100` |
| `git.b244.ru` | `172.17.0.1:20001` | `cgit-nginx-proxy:8080` |

## Validation

NPM API/auth gate: PASS through saved NPM access file.

Docker/network validation:

- `kutt-server-1`, `cgit-nginx-proxy`, `minio`, `portainer`, `3x-ui`, `stroy-php`, and `youtrack-server` resolve on the Proxy Manager network.
- Scoped `npm-route-host-*` containers are running on `nginx-proxy-manager_default`.
- Proxy Manager can reach the upstream services through the bridge containers.

Public route checks after update:

| URL | Result |
|---|---|
| `https://b244.ru` | `302` |
| `https://www.b244.ru` | `302` |
| `https://arwox.b244.ru` | `404` from upstream |
| `https://pdf-generator.b244.ru` | `200` |
| `https://dash.b244.ru` | `200` |
| `https://pm2.b244.ru` | `200` |
| `https://transcribe.b244.ru` | `302` |
| `https://dev.transcribe.b244.ru` | `302` |
| `https://vphdffy.b244.ru` | `400` from upstream |
| `https://yubikey-v2.b244.ru` | `200` |

No raw secrets were printed or committed.

## Remaining Blocker

Primary blocker: `DOCKER_ROUTE_SCOPE_UNCLEAR`.

Rows not converted:

- `kpd.b244.ru` -> `172.17.0.1:3847`, enabled, public route currently returns `502`; no proven listening owner was found.
- `yubikey-v1.b244.ru` -> `172.17.0.1:4000`, enabled, public route currently returns `502`; no proven listening owner was found.
- Disabled/offline rows remain raw pending separate owner recovery: `claw.b244.ru`, `n8.b244.ru`, `openclaw.b244.ru`.

## Final State

Partial implementation complete. Most active raw-IP rows were converted to stable Docker service names or scoped Docker bridge route names. `AH-513` and `AH-518` must remain not-Done until the remaining owner-unclear rows are resolved or explicitly excluded.
