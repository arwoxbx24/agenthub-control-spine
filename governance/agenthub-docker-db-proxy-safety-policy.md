---
artifact_id: agenthub-docker-db-proxy-safety-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-554
related_tasks:
  - AH-536
  - AH-537
run_id: AGENTHUB-P0-ACCESS-RIGHTS-AUDIT-LIVE-DEVOPS-ENABLEMENT-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Docker DB Proxy Safety Policy

## Safety Baseline

Runtime recovery must be narrow, reversible, and task-bound. Safety gates are
local to the affected service and must not become a global AgentHub stop.

## Read Before Write

Before P5-P8 action, the worker records:

- task id, RUN_ID, worker id, service name, host/domain, permission class;
- current endpoint result;
- container/process/listener/compose mapping;
- relevant recent logs or health summary, redacted and bounded;
- disk/inode/host health summary when Docker is involved;
- exact config or compose file that may change;
- rollback command or restoration note.

## Docker Rules

Allowed with P5:

- restart a named unhealthy container;
- recreate a named container from verified existing compose;
- reconnect a named service to a required network when mismatch is proven;
- start an existing stopped service that belongs to the task.

Denied:

- `docker system prune`, broad cleanup, reset, or wildcard delete;
- deleting running containers;
- deleting active volumes or linked networks;
- mutating unrelated compose projects;
- changing secrets or raw env files.

P7 cleanup is allowed only for exact stopped, detached, obsolete resources with
proof and owner/task authorization.

## DB Rules

DB actions require P6. Backup/snapshot/export proof comes first. Raw records,
tokens, hashes, and connection strings must not be printed. If a service can be
recovered without DB mutation, choose the no-DB route.

## Proxy/NPM/Firewall/DNS/SSL Rules

Proxy and edge changes require P8. The worker must name the exact host, current
target, intended target, config backup, rollback, and external validation.

Nginx Proxy Manager / Proxy Manager / NPM / Docker routing is not Telegram
MTProxy. Do not route NPM work through MTProxy runbooks or terminology.

## Destructive Preflight

Before any destructive or semi-destructive action, the worker answers in the
receipt:

1. What exactly changes?
2. What data could be lost?
3. What live service could break?
4. What backup/rollback exists?
5. Why is this safer than alternatives?

If any answer is missing, action stops with `OWNER_ONLY_DESTRUCTIVE_DELETE_GATE`
or the narrower typed blocker.

## Validation

Done requires before/after endpoint matrix, no unrelated service stopped, no
secret exposure, and YouTrack readback. A login page, homepage, or generic 200
is sufficient only when it is the expected user outcome for that endpoint.
