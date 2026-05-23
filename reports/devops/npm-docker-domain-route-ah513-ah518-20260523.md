---
artifact_id: npm-docker-domain-route-ah513-ah518-20260523
artifact_type: devops-worker-report
owner_role: Scoped Implementation Worker
source_task: AH-513/AH-518
run_id: RUN-npm-docker-ah513-ah518-domain-route-20260523
created_at: 2026-05-23
status: complete
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

## Follow-up Closure: Active Raw-IP Tail

Follow-up RUN_ID: `FIX-20260523-NPM-RAW-IP-TAIL-CLOSURE`.

The previously blocked active rows were recovered and converted after service-owner proof was found:

| Domain | Before | After | Validation |
|---|---|---|---|
| `kpd.b244.ru` | `172.17.0.1:3847` | `kpd-proxy-upstream:80` | `https://kpd.b244.ru/api/kpd/health` returns `200` |
| `yubikey-v1.b244.ru` | `172.17.0.1:4000` | `yubikey-v1-upstream:80` | `https://yubikey-v1.b244.ru/` returns `200` |

Additional scoped repair:

- Restored `kpd-proxy` PM2 execution by adding a compatibility symlink from the stale PM2 script path to the canonical project path, without deleting any PM2 entry.
- Started canonical `yubikey-v1` PM2 process from `/root/workspaces/projects/yubikey-v1`.
- Created semantic Docker bridge containers on `nginx-proxy-manager_default`:
  - `kpd-proxy-upstream`
  - `yubikey-v1-upstream`

Final active raw-IP check: `[]`.

Disabled/offline archival rows still contain raw IPs and were deliberately not changed because they are not active traffic routes: `claw.b244.ru`, `n8.b244.ru`, `openclaw.b244.ru`.

## Final State

Implementation complete for active Proxy Manager traffic routes. All enabled raw-IP upstream rows have been converted to stable Docker service names or scoped semantic Docker bridge route names. `AH-518` can be closed for the implementation slice; `AH-513` can be treated as closed for the addressed active-route architecture scope unless a separate future task explicitly reopens disabled archival rows.
