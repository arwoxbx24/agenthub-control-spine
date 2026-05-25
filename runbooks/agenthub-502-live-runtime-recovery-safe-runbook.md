---
artifact_id: agenthub-502-live-runtime-recovery-safe-runbook
artifact_type: runbook
owner_role: T2 DevOps Incident Worker
source_task: AH-554
related_tasks:
  - AH-536
run_id: AGENTHUB-P0-ACCESS-RIGHTS-AUDIT-LIVE-DEVOPS-ENABLEMENT-20260525
created_at: 2026-05-25
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub 502 Live Runtime Recovery Safe Runbook

## Worker Contract

This runbook is for T2 DevOps worker use only. T0/T1 may read it, route it,
and validate evidence. T0/T1 must not execute live runtime mutation.

## AH-554 Scope

In scope:

- public endpoints from AH-554 matrix;
- user-pasted NPM upstream destinations except excluded `claw` and `kpd`;
- service-specific Docker/compose/process/proxy repairs when authorized.

Out of scope:

- OpenClaw/claw, tracked by AH-521;
- kpd, deferred by user;
- broad Docker cleanup;
- DB/proxy/firewall changes without exact P6/P8 authorization.

## Read-Only Preflight

Collect bounded, redacted summaries:

- endpoint status matrix;
- DNS resolution for public hosts;
- Docker container summary for named services;
- compose project mapping for named services;
- listener and port mapping for named services;
- recent service logs summary, bounded and redacted;
- disk, inode, memory, and CPU summary;
- NPM upstream read for named proxy hosts when P4/P8 route exists.

## Backup And Rollback

Before mutation:

- record current container ids/images/networks/volumes for named services;
- copy compose/config files that will be touched;
- export or snapshot proxy config if P8 is used;
- create DB backup if P6 is used;
- write rollback steps before action.

## Allowed Actions With P5

- start an existing stopped scoped service;
- restart an unhealthy scoped service;
- recreate a scoped service from verified compose;
- restore a named upstream bridge when the real process is healthy and upstream
  DNS target is missing;
- reconnect scoped service to required network when mismatch is proven.

## Forbidden Actions

- broad `docker system prune`, reset, delete, or wildcard cleanup;
- deleting running containers, active volumes, linked networks, or live compose
  projects;
- DB mutation without backup;
- NPM/proxy/firewall/DNS global changes;
- secrets, raw env, private keys, tokens, cookies, or raw transcripts.

## Per-Endpoint Result

Each endpoint must end as:

- `RESTORED_WITH_EVIDENCE`;
- `EXCLUDED_BY_SCOPE`;
- `VALID_LOCAL_SAFETY_GATE`;
- `AGENTHUB_LIVE_WORKER_AUTH_MISSING`;
- `DOCKER_HOST_ACCESS_MISSING`;
- `PROXY_CONFIG_AUTH_MISSING`;
- `DB_BACKUP_AUTH_MISSING`;
- `FIREWALL_DNS_SSL_OWNER_GATE`.

## Done Gate

AH-554 can move to Done only when every in-scope endpoint is restored or has a
typed per-endpoint blocker, with worker receipt and YouTrack readback.
