---
artifact_id: claw-backend-deferred-no-start-20260524
artifact_type: devops-deferred-blocker-report
owner_role: Scoped Claw Backend Worker
source_task: AH-521
run_id: RUN-claw-backend-deferred-no-start-20260524
created_at: 2026-05-24
status: deferred-blocker
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
project_scope: proxy-manager/docker-addressing/claw
---

# Claw Backend Deferred No-Start Report

## Decision

`claw.b244.ru` backend restoration is intentionally not executed in this run.

The current user instruction explicitly forbids starting the `claw` service now. Therefore this run records the remaining gap as a scoped deferred blocker and does not mutate runtime, Docker, Proxy Manager, VPN, firewall, databases, or existing working routes.

## Current Known State

- `claw.b244.ru` NPM destination is already semantic: `claw-openclaw-upstream:80`.
- The expected backend port remains `18789`.
- Prior validation showed no listener on `18789`.
- Public `claw.b244.ru` remained `502`.
- `n8.b244.ru` and `dash.b244.ru` are outside this run and must not be repeated.

## Task Handling

- Task anchor: `AH-521`.
- `AH-513` and `AH-518` completed work remains unchanged.
- No duplicate task was created.
- The correct state for `AH-521` is not Done while backend startup is intentionally deferred.

## Blocker

Primary blocker: `CLAW_BACKEND_SERVICE_MISSING`.

The blocker is intentionally preserved until a future scoped run is allowed to identify and restore the canonical OpenClaw backend service that listens on `18789`.

## Safety

No service start, restart, proxy row rewrite, database action, firewall action, VPN action, Telegram/MTProxy action, broad Docker operation, or secret read/output was performed.
