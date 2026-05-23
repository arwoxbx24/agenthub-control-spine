---
artifact_id: mtproxy-domain-route-worker-receipt-20260523
artifact_type: operational-receipt
owner_role: T2 DevOps Incident Worker
source_task: AH-468
run_id: RUN-proxy-docker-mtproxy-domain-route-20260523
created_at: 2026-05-23
status: pass
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
project_scope: mtproxy/vpn/proxy-route
---

# MTProxy Domain Route Worker Receipt

## Identity

- RUN_ID: `RUN-proxy-docker-mtproxy-domain-route-20260523`
- worker_id: `proxy-docker-mtproxy-worker`
- task system: YouTrack
- source task: `AH-468`
- control-spine branch: `agenthub/proxy-docker-mtproxy-domain-route-20260523`

## Service Owner

- service owner: scoped Docker MTProxy service
- container: `agenthub-mtproxy-obfs-ah468`
- image: `mtproxy/mtproxy:latest`

## Route

- route chosen: direct public TCP endpoint
- public endpoint: `45.139.76.176:21434`
- route not chosen: HTTP proxy-manager host route
- reason: MTProto is TCP, and the existing working endpoint is a direct TCP service binding.

## Secret Handling

- MTProxy secret exists as a saved container secret/env reference.
- Secret value is not written to GitHub reports.
- Final user-facing connection format may include the connection link because the user explicitly requested the endpoint.

## Validation Evidence

- local service running: PASS
- port binding present: PASS
- public TCP connect to `45.139.76.176:21434`: PASS
- Telegram/MTProxy user-outcome evidence: PASS, accepted in `AH-468`
- unrelated services touched: none
- forbidden zones touched: none

## Rollback

No live mutation was performed in this worker run. Existing rollback is to leave the accepted `agenthub-mtproxy-obfs-ah468` endpoint on `21434` unchanged.

## Final Status

PASS. Working endpoint preserved and documented. No blocker.
