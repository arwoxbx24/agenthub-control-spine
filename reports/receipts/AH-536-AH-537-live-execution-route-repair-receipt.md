---
artifact_id: AH-536-AH-537-live-execution-route-repair-receipt
artifact_type: incident-receipt
owner_role: T0 Control Plane Registrar
source_task: AH-537
related_tasks:
  - AH-536
  - AH-537
  - AH-533
run_id: RUN-live-502-portainer-docker-incident-20260525
created_at: 2026-05-25
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
final_state: READY_BLOCKED_BY_AGENTHUB_LIVE_ADAPTER
---

# AH-536/AH-537 Live Execution Route Repair Receipt

## Verified Readback

- `AH-536` exists and is the live 502 incident for `port.b244.ru`, `dash.b244.ru`, and `minio-admin.b244.ru`; it remains open in `Develop` with show-stopper priority.
- `AH-537` exists and is the platform blocker for enabling an authorized AgentHub live execution adapter; it remains open in `Develop` with show-stopper priority.
- `AH-533` exists, is resolved, and installed the narrower Git/GitHub AgentHub-route rule through PR `#37` at commit `329b920d89caf0465293d4747b9106b9531257ee`.
- PR `#39` exists and remains the single open control-spine PR tail for AgentHub-only execution discipline; no duplicate PR was opened for this incident.

## Incident Evidence

User-reported symptoms:

- `port.b244.ru` returned `502 Bad Gateway`.
- `dash.b244.ru` returned `502 Bad Gateway`.
- `minio-admin.b244.ru` returned `502 Bad Gateway`.
- User reported Docker/Portainer/karaoke cascade failure.

AgentHub route evidence:

- AgentHub run: `RUN-live-502-portainer-docker-incident-20260525`.
- AgentHub status and runtime contract were readable through MCP.
- Protected-link read for the named endpoints was blocked by intake classification, so endpoint state is recorded as user-reported and not independently validated by T0.
- Live command worker dispatch was blocked by `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`.

Route-bypass evidence:

- Earlier T0 direct Linux cleanup happened in this session before the AgentHub-only correction.
- The prior runtime mutation attempt is quarantined as `INVALID_T0_RUNTIME_ROUTE_BYPASS`.
- The receipt does not treat that work as valid repair evidence and does not claim live incident Done.
- No raw terminal transcript, secret, environment dump, database content, proxy config, or token is recorded here.

## Invalidation Classes

Applied classes:

- `DIRECT_SHELL_MUTATION_BY_T0`
- `DIRECT_RUNTIME_MUTATION_WITHOUT_AGENTHUB`
- `AGENTHUB_EXECUTION_ADAPTER_UNAVAILABLE`

Watch classes retained by the control package:

- `YOLO_RUNTIME_MODE_FORBIDDEN`
- `NO_CONTROL_SPINE_RECEIPT`
- `CHAT_REPORT_INSTEAD_OF_REPO_RECEIPT`
- `REPORT_THEN_STOP_LOOP`
- `FAKE_DONE_FROM_REPORT`
- `BROAD_COMMAND_WITHOUT_TASK`
- `UNSAFE_STORAGE_WRITE`
- `IMAGE_OR_LINK_NOT_VALIDATED`
- `TASK_SERVICE_WRITEBACK_BYPASS`

## Worker Contract For Next Safe Live Step

Role: `T2 DevOps Incident Worker`.

Allowed only when AgentHub live execution adapter explicitly authorizes:

- `task_id`: `AH-536`
- `run_id`: `RUN-live-502-portainer-docker-incident-20260525`
- `worker_id`: exact worker id issued by AgentHub
- allowed surface: scoped diagnostics and repair for `port.b244.ru`, `dash.b244.ru`, `minio-admin.b244.ru`, and the exact current Docker/Portainer/karaoke incident
- forbidden surface: DB dump/query/migration, broad Docker prune/delete, Nginx/NPM generated config edits, secrets/env inspection, unrelated services, object storage mutation, firewall, DNS, SSL
- rollback/checkpoint: required before any mutation
- validation: service owner, container/process state, host path, public route, and user-visible outcome
- evidence output: AgentHub task/run/worker receipt plus redacted diagnostics artifact

## Remediation Gate

Current final state: `READY_BLOCKED_BY_AGENTHUB_LIVE_ADAPTER`.

Exact blocker: `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` prevents the approved AgentHub live worker from collecting diagnostics or repairing the live 502 incident. T0 must not fall back to direct shell.

## Machine Receipt

```json
{
  "schema": "agenthub_only_execution_receipt.v1",
  "task_id": "AH-537",
  "run_id": "RUN-live-502-portainer-docker-incident-20260525",
  "repository": "arwoxbx24/agenthub-control-spine",
  "final_state": "READY_BLOCKED_BY_AGENTHUB_LIVE_ADAPTER",
  "route": {
    "youtrack_task": "AH-537",
    "agenthub_run": "RUN-live-502-portainer-docker-incident-20260525",
    "branch": "agenthub/agenthub-only-execution-discipline-20260525",
    "worker_or_registrar": "T0 Control Plane Registrar",
    "worker_id": "T2-devops-incident-worker-not-dispatched-adapter-blocked",
    "allowed_surface": [
      "AgentHub MCP readback",
      "YouTrack AH-536/AH-537/AH-533 readback",
      "control-spine artifact updates",
      "future scoped live diagnostics only after adapter authorization"
    ],
    "forbidden_surface": [
      "direct T0 shell",
      "Docker prune/delete/reset",
      "DB query/dump/migration",
      "Nginx/NPM generated config mutation",
      "secrets/env inspection",
      "unrelated production services"
    ],
    "validation_contract": [
      "YouTrack task readback",
      "PR queue readback",
      "control-spine receipt exists",
      "live worker evidence required before incident Done"
    ],
    "rollback_or_checkpoint": "required before any future live mutation by authorized worker",
    "evidence_output": "reports/receipts/AH-536-AH-537-live-execution-route-repair-receipt.md"
  },
  "invalidation_classes": [
    "DIRECT_SHELL_MUTATION_BY_T0",
    "DIRECT_RUNTIME_MUTATION_WITHOUT_AGENTHUB",
    "AGENTHUB_EXECUTION_ADAPTER_UNAVAILABLE"
  ],
  "changed_artifacts": [
    "reports/receipts/AH-536-AH-537-live-execution-route-repair-receipt.md",
    "runbooks/agenthub-live-execution-adapter-remediation.md",
    "schemas/agenthub-only-execution-receipt.schema.json",
    "PR_QUEUE_REGISTER.md",
    "CHANGELOG.md"
  ],
  "validation": {
    "youtrack_ah_536_readback": "PASS",
    "youtrack_ah_537_readback": "PASS",
    "youtrack_ah_533_readback": "PASS",
    "duplicate_youtrack_search": "PASS_NO_NEW_DUPLICATE",
    "open_pr_duplicate_check": "PASS_REUSE_PR_39",
    "runtime_mutation_by_t0_after_freeze": "PASS_NONE",
    "live_worker_dispatch": "BLOCKED_CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED",
    "secret_redaction_review": "PASS_NO_SECRETS_RECORDED",
    "forbidden_surface_diff": "PASS_CONTROL_SPINE_ONLY"
  },
  "forbidden_surface_touched": false,
  "blocker": "CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED"
}
```
