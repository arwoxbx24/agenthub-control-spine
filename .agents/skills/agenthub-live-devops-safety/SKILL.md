---
name: agenthub-live-devops-safety
description: Enforce safe live DevOps worker execution for Docker, DB, proxy, firewall, endpoint, and service recovery tasks with rollback and validation.
---

# AgentHub Live DevOps Safety

Use only for task-bound T2 DevOps worker routes that touch live services.

## Required Before Mutation

1. Task id, RUN_ID, worker id.
2. Permission class P4/P5/P6/P8 as needed.
3. Exact service and endpoint list.
4. Read-only preflight.
5. Backup/checkpoint/rollback for every touched surface.
6. Redacted evidence output path.

## Forbidden

- T0 direct mutation.
- Broad Docker prune/reset/delete.
- Running container deletion.
- Active volume or linked-network deletion.
- DB mutation without backup.
- Proxy/firewall/DNS global change.
- Secret/raw env/log dump.

## Done Gate

Done requires before/after validation, no unrelated service breakage, no secrets,
receipt, and task readback.
