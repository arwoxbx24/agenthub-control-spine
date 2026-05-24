---
artifact_id: npm-gap-closure-no-dup-receipt-20260524
artifact_type: operational-receipt
owner_role: Scoped Closure Worker
source_task: AH-513/AH-518 follow-up
run_id: CLOSE-20260524-NPM-GAPS-NO-DUP
created_at: 2026-05-24
status: partial-with-one-blocker
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
project_scope: proxy-manager/docker-addressing
---

# NPM Gap Closure Receipt

## Identity

- RUN_ID: `CLOSE-20260524-NPM-GAPS-NO-DUP`
- worker_id: `cdx-NPM-gap-closure-no-dup`
- task anchor: `AH-518`
- new blocker task: `AH-521`

## Duplicate Guard

Duplicate check found no existing task for `CLAW_BACKEND_SERVICE_MISSING`. Completed AH-513/AH-518 work was not repeated.

## Evidence

- `n8.b244.ru`: `200`.
- `dash.b244.ru`: `200`.
- `claw.b244.ru`: `502`.
- NPM route state:
  - `n8.b244.ru -> n8n:5678`
  - `dash.b244.ru -> grafana-dashboard-upstream:80`
  - `claw.b244.ru -> claw-openclaw-upstream:80`
- Port `18789`: no listener.

## Rollback

Rollback artifacts are stored under the AgentHub run directory. Route rollback uses the saved NPM row snapshots from the run evidence and the existing NPM API wrapper.

## Blocker

Primary blocker: `CLAW_BACKEND_SERVICE_MISSING`.

Required system action: restore/deploy the canonical OpenClaw backend service that listens on `18789`, then validate local port, NPM bridge, and public `claw.b244.ru`.

## Final Status

`n8` and `dash` are closed. `claw` is tracked by `AH-521` and is not Done.
