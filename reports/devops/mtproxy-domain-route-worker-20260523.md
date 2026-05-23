---
artifact_id: mtproxy-domain-route-worker-20260523
artifact_type: devops-worker-report
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

# MTProxy Domain Route Worker Report

## Scope

This worker handled only the scoped Telegram MTProxy route surface:

- Docker service: `agenthub-mtproxy-obfs-ah468`
- Runtime image: `mtproxy/mtproxy:latest`
- Route type: direct public TCP endpoint
- Public host: `45.139.76.176`
- Public port: `21434`

No TeamLead/T0 architecture files were changed. No unrelated client project, AH-509, Backlog work, database migration, proxy-manager database edit, Docker prune, or volume deletion was performed.

## Route Decision

MTProto is TCP and is not an ordinary HTTP reverse-proxy route. The valid route for the current service is direct public TCP:

- endpoint: `45.139.76.176:21434`
- container port: `443/tcp`
- host binding: `0.0.0.0:21434 -> 443/tcp`
- Telegram link: available in final user output and in YouTrack AH-468; secret is redacted in GitHub artifacts.

A domain/subdomain or wildcard HTTP route was not required for the current working endpoint.

## Discovery Evidence

Existing task source:

- YouTrack `AH-468` records the accepted TimeWeb obfuscated MTProxy endpoint.
- User confirmation in AH-468 says the final accepted endpoint is the separate obfuscated endpoint on port `21434`.

Service state:

- Container `agenthub-mtproxy-obfs-ah468` is running.
- Docker port binding shows `443/tcp` published as `21434/tcp`.
- Container logs show MTProxy started and generated proxy links; secret values were redacted from this report.

## Validation

Validation performed:

- Container running: PASS.
- Public TCP connect to `45.139.76.176:21434`: PASS.
- MTProxy configuration present: PASS.
- Telegram/user-outcome evidence: PASS via AH-468 user confirmation.

External multi-region TCP proof was not added to GitHub because no non-secret, trusted external checker receipt was available inside the scoped worker. The user-outcome proof from AH-468 remains the accepted Telegram-level evidence.

## Rollback

No live mutation was required in this worker run because the scoped MTProxy endpoint already existed and was reachable.

Rollback path if future changes are made:

1. Preserve existing `agenthub-mtproxy-obfs-ah468` container and port `21434` before edits.
2. Do not touch old working endpoints or unrelated services.
3. If a replacement canary fails, restore route to direct `45.139.76.176:21434` and the existing saved secret reference.

## Result

PASS. The scoped MTProxy endpoint exists, is listening on a direct public TCP route, and has prior Telegram user-outcome confirmation in AH-468.
