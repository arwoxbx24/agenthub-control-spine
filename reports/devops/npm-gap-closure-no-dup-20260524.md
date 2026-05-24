---
artifact_id: npm-gap-closure-no-dup-20260524
artifact_type: devops-gap-closure-report
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

# NPM Gap Closure Without Duplicate Work

## Scope

This run closed only gaps discovered after the AH-513/AH-518 active NPM raw-IP cleanup. It did not repeat successful NPM/Docker migration work.

## Readback

- `AH-513`: Done.
- `AH-518`: Done.
- No existing YouTrack task was found for `CLAW_BACKEND_SERVICE_MISSING`.
- New gap task created: `AH-521`.

## Current Route State

| Route | State | Evidence |
|---|---|---|
| `n8.b244.ru` | Working | `https://n8.b244.ru/` returns `200`; NPM routes to `n8n:5678`. |
| `dash.b244.ru` | Working | `https://dash.b244.ru/` returns `200`; NPM routes to `grafana-dashboard-upstream:80`. |
| `claw.b244.ru` | Blocked | NPM routes to `claw-openclaw-upstream:80`, but backend port `18789` has no listener; public route returns `502`. |

Active raw-IP NPM readback for enabled routes remains clean.

## Actions

- Recreated missing runtime containers only when absent:
  - `n8n`
  - `grafana-dashboard-upstream`
  - `claw-openclaw-upstream`
- Did not change already-correct NPM rows beyond preserving their current semantic destinations.
- Created `AH-521` for the only remaining implementation gap.

## Blocker

Primary blocker: `CLAW_BACKEND_SERVICE_MISSING`.

The proxy layer for `claw.b244.ru` is named and reachable from NPM, but no OpenClaw backend process/container is listening on `18789`. A separate scoped recovery task must restore the canonical OpenClaw backend before the route can pass.

## Forbidden Zones

No VPN, Telegram MTProxy, database dump/query/migration, broad Docker cleanup, destructive prune/reset/delete, secrets output, firewall change, or unrelated NPM route change was performed.
