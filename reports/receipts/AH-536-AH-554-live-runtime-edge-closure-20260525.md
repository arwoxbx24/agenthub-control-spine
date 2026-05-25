---
artifact_id: AH-536-AH-554-live-runtime-edge-closure-20260525
artifact_type: operational-receipt
owner_role: T2 Scoped Live DevOps Worker + T0 Registrar Readback
source_task: AH-536/AH-554
run_id: RUN-ah554-live-devops-worker-4-20260525-continuation
created_at: 2026-05-25
status: done-with-evidence
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
project_scope: live-runtime/proxy-edge-upstream
---

# AH-536 / AH-554 Live Runtime Edge Closure

## Scope

This receipt continues the existing AH-536/AH-554 closure chain. No new
YouTrack task, PR, architecture prompt, report branch, Bitrix/Appsmith work, or
n8n work was opened.

Explicitly excluded by latest owner instruction:

- `http://45.139.76.176:20120/applications` / Appsmith Margin Cockpit was not
  touched.
- `n8.b244.ru` / `http://n8n:5678` was not touched and remains a later task.
- DB mutation, Docker prune/delete/reset, firewall broad changes, secret/env
  dumps, and live volume deletion were not performed.

## Backup / Rollback

Rollback snapshots were captured before the live edge repair:

- `@agenthub-runs/ah536-ah554-live-closure-20260525/npm-live-database.sqlite.before`
  sha256 `60a9dde9d14b9966d3afe42975cdc0cf0a2708e77a046ab16ca8f45dd73cbab5`.
- `@agenthub-runs/ah536-ah554-live-closure-20260525/proxy-hosts-live-before.tgz`
  sha256 `d66664511e005ab8eccc114737999e7cc161441e3c935a7275898e982b003edf`.

Post-change snapshots:

- `@agenthub-runs/ah536-ah554-live-closure-20260525/npm-live-database.sqlite.after`
  sha256 `c8f7fa34db4fffef16bfec578e4043fca712779b6ee8018fa1d2ab023ebf0bea`.
- `@agenthub-runs/ah536-ah554-live-closure-20260525/proxy-hosts-live-after.tgz`
  sha256 `f772d2071237f855a70432911be4e68baa8c79a3a1a78ddd9cdda1f9bdd75f1e`.

Rollback command class: restore the before SQLite/config snapshots for the
affected proxy hosts and reload only Nginx Proxy Manager.

## Implementation Evidence

The repair kept the semantic upstream pattern in NPM instead of leaving direct
host-IP rows where bridge names were intended.

Actions performed:

- Started existing canonical compose services for `portainer`, `minio`, and
  `gitmirror/cgit` from their known compose files.
- Re-created missing semantic upstream bridge containers on
  `nginx-proxy-manager_default`:
  - `pdf-generator-upstream -> 172.17.0.1:4200`
  - `yubikey-v1-upstream -> 172.17.0.1:4000`
  - `yubikey-v2-upstream -> 172.17.0.1:3100`
  - `transcribe-upstream -> 172.17.0.1:3600`
  - `dev-transcribe-upstream -> 172.17.0.1:3601`
  - `arwox-upstream -> 172.17.0.1:20510`
  - `kpd-proxy-upstream -> 172.17.0.1:3847`
  - `vphdffy-upstream -> https://172.17.0.1:9444`
- Reloaded only Nginx Proxy Manager after the scoped edge changes.
- Reverted the temporary direct `vphdffy.b244.ru` target back to the intended
  semantic NPM destination `http://vphdffy-upstream:80`.

No Appsmith/BMC process, `20120` service, n8n project, DB content, firewall,
or unrelated domain was changed.

## Public Validation

Post-repair public endpoint matrix:

| Endpoint | Result |
|---|---|
| `https://port.b244.ru/` | `200` |
| `https://dash.b244.ru/` | `200` |
| `https://minio-admin.b244.ru/` | `200` |
| `https://git.b244.ru/` | `200` |
| `https://yubikey-v1.b244.ru/` | `200` |
| `https://yubikey-v2.b244.ru/` | `200` |
| `https://transcribe.b244.ru/` | `200` after redirect to `/login` |
| `https://dev.transcribe.b244.ru/` | `200` after redirect to `/login` |
| `https://pdf-generator.b244.ru/` | `200` |
| `https://vphdffy.b244.ru/` | `200` |
| `https://arwox.b244.ru/` | `404` from reachable upstream, not 502 |
| `https://kpd.b244.ru/` | `404` from reachable upstream, not 502 |
| `https://yt.b244.ru/` | `200` |

`n8.b244.ru` is intentionally excluded by owner instruction and was not repaired
in this closure pass.

## Final State

Status: `DONE_WITH_EVIDENCE` for the AH-536/AH-554 live runtime edge/upstream
scope, excluding n8n and the Appsmith/BMC project by explicit owner instruction.

Remaining active blocker in this scope: none.
