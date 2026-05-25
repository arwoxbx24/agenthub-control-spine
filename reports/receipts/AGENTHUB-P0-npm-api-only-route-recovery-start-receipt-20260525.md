---
artifact_id: AGENTHUB-P0-npm-api-only-route-recovery-start-receipt-20260525
artifact_type: route-unblock-start-receipt
owner_role: Registrar / T2 Worker
source_task: AH-567 / AH-536 / AH-554
run_id: agenthub-emergency-worker-route-unblock-npm-api-ah536-ah554-20260525
created_at: 2026-05-25
status: npm-api-route-started
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
---

# P0 NPM API-Only Route Recovery Start Receipt

## Owner Clarification

The owner clarified that all Nginx Proxy Manager access must use API access
only. Direct NPM file access, UI automation, container exec, generated config
inspection, and proxy-manager filesystem reads are forbidden for agents.

## Route Rule

Allowed:

- Use only secret handles from the local secret store.
- Use only NPM API calls for readback and scoped repair.
- Do not print secret values.
- Do not write secrets into repository artifacts.

Forbidden:

- NPM UI access.
- Direct proxy-manager files or generated config files.
- Container exec into proxy-manager.
- Direct DB access.
- BMC/Appsmith/port `20120`.
- n8n.
- Unrelated services or client product code.

## Active Route

- RUN_ID: `agenthub-emergency-worker-route-unblock-npm-api-ah536-ah554-20260525`
- Worker role: `T2_CODEX_LIVE_WORKER`
- Task: AH-536/AH-554 affected public `502` chain under AH-567.

## Next Action

Run one scoped AgentHub T2 worker that discovers NPM API secret handles without
printing values, authenticates through the NPM API, reads affected proxy hosts,
and applies only scoped upstream corrections if the API evidence is sufficient.

