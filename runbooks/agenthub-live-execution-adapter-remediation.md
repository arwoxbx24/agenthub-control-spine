---
artifact_id: agenthub-live-execution-adapter-remediation
artifact_type: platform-remediation-runbook
owner_role: T0 Control Plane Registrar
source_task: AH-537
related_tasks:
  - AH-536
run_id: RUN-live-502-portainer-docker-incident-20260525
created_at: 2026-05-25
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Live Execution Adapter Remediation

This runbook is the platform gate for live incident work when AgentHub rejects command-worker dispatch with `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`.

## Trigger

Use this runbook when all conditions are true:

- a live incident requires runtime diagnostics or repair;
- T0 direct Linux/runtime action is forbidden;
- the required worker route must run through AgentHub;
- AgentHub live execution adapter is unavailable or contract-only.

## Required Adapter Contract

A live worker adapter is valid only when the route receipt contains:

- `task_id`;
- `run_id`;
- `worker_id`;
- allowed surface;
- forbidden surface;
- rollback or checkpoint requirement;
- validation contract;
- evidence output path.

If any field is missing, dispatch remains blocked and the task state stays `READY_BLOCKED_BY_AGENTHUB_LIVE_ADAPTER`.

## AH-536 Worker Scope

For the current incident, the next valid worker is `T2 DevOps Incident Worker`.

Allowed first diagnostic surface:

- disk usage summary;
- Docker container status summary;
- Docker disk usage summary;
- HTTP status checks for `port.b244.ru`, `dash.b244.ru`, and `minio-admin.b244.ru`;
- service-owner mapping for the reported karaoke/Portainer symptoms.

Forbidden surface:

- direct T0 shell fallback;
- Docker prune, reset, delete, volume cleanup, image cleanup, or broad cleanup;
- DB dump, query, migration, restore, or volume inspection;
- Nginx/NPM generated config edits or reloads;
- secrets, env dumps, private keys, raw webhooks, and tokens;
- unrelated services, object storage mutation, firewall, DNS, or SSL changes.

## Safe Progression

1. Keep `AH-536` open until live validation proves user-visible recovery.
2. Keep or update `AH-537` as the platform blocker while adapter dispatch fails.
3. Do not dispatch a command worker until AgentHub accepts the exact adapter contract.
4. Require rollback/checkpoint proof before any mutation.
5. Require worker evidence before YouTrack Done.
6. If adapter remains unavailable, update the control-spine receipt and stop at `READY_BLOCKED_BY_AGENTHUB_LIVE_ADAPTER`.

## Done Gate

`AH-537` can close only after one of these is true:

- AgentHub live execution adapter accepts the scoped AH-536 worker contract and writes a route receipt; or
- an equivalent approved AgentHub worker route replaces the command adapter and proves the same fields; or
- a narrower owner-only or forbidden-scope blocker is recorded with evidence.

`AH-536` can close only after the worker evidence proves:

- affected service owner identified;
- container/process state checked;
- host path or route path checked without secret exposure;
- public route validated;
- user-visible endpoint outcome recorded;
- no unrelated service mutation happened.
