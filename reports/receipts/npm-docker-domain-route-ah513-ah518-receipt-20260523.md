---
artifact_id: npm-docker-domain-route-ah513-ah518-receipt-20260523
artifact_type: operational-receipt
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

# NPM Docker Addressing Receipt

## Identity

- RUN_ID: `RUN-npm-docker-ah513-ah518-domain-route-20260523`
- worker_id: `cdx-NPM-docker`
- branch: `agenthub/npm-docker-ah513-ah518-domain-route-20260523`
- task ids: `AH-513`, `AH-518`

## Source Readback

- `AH-513` read: PASS.
- `AH-518` read: PASS.
- Scope correction applied: this was not Telegram MTProxy work.

## Implementation Evidence

- NPM saved API access discovered and used without printing secrets.
- NPM rows for `b244.ru`, `www.b244.ru`, `arwox.b244.ru`, `pdf-generator.b244.ru`, `dash.b244.ru`, `pm2.b244.ru`, `transcribe.b244.ru`, `dev.transcribe.b244.ru`, `vphdffy.b244.ru`, `yubikey-v2.b244.ru`, and disabled `git.b244.ru` were changed away from raw IP upstream values.
- Scoped bridge containers `npm-route-host-*` were created for host/gateway upstreams.
- Active Proxy Manager compose received scoped host aliases and was recreated once.

## Validation Evidence

- NPM API update responses: PASS.
- NPM final readback: PASS.
- Docker bridge containers running: PASS.
- Public route validation: PASS for converted routes, with upstream-native codes recorded.
- No Telegram MTProxy work: PASS.
- No database dump/query/migration: PASS.
- No secrets committed: PASS.

## Rollback

- Saved row JSON and compose backups exist in the run artifact directory.
- Rollback command class: restore compose backups, recreate Proxy Manager, and PUT saved proxy-host JSON via NPM API.

## Follow-up Closure

Follow-up RUN_ID: `FIX-20260523-NPM-RAW-IP-TAIL-CLOSURE`.

The previous primary blocker `DOCKER_ROUTE_SCOPE_UNCLEAR` was resolved for enabled traffic routes:

- `kpd.b244.ru` changed from `172.17.0.1:3847` to `kpd-proxy-upstream:80`.
- `yubikey-v1.b244.ru` changed from `172.17.0.1:4000` to `yubikey-v1-upstream:80`.
- `kpd-proxy` PM2 service was restored without deleting PM2 entries.
- Canonical `yubikey-v1` PM2 service was started.
- Active raw-IP NPM readback returned an empty list.

Validation:

- `https://kpd.b244.ru/api/kpd/health` returned `200`.
- `https://yubikey-v1.b244.ru/` returned `200`.
- NPM container resolved `kpd-proxy-upstream` and `yubikey-v1-upstream`.
- No VPN, Telegram, database dump/query/migration, broad firewall, or unrelated route change was performed.

## Final Status

Done for enabled Proxy Manager raw-IP upstream cleanup. Disabled/offline archival rows remain raw by deliberate exclusion, not active-route blocker.
