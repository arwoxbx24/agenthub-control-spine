---
artifact_id: agenthub-task-cycle-full-closure-policy
artifact_type: governance-policy
owner_role: T0 Control Plane Registrar
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

# AgentHub Task Cycle Full Closure Policy

## Full Cycle

Every actionable task must have:

1. task exists or duplicate is linked;
2. owner assigned;
3. worker route selected;
4. implementation or typed blocker recorded;
5. validation evidence recorded;
6. receipt recorded;
7. YouTrack readback confirms state;
8. parent/child rule satisfied.

Task creation is not progress unless route and next action are recorded.

## Parent And Child Rule

An implementation parent cannot move to Done while child implementation tasks
remain open. A parent may be tracking-only only when the description says so and
does not claim child implementation Done.

For AH-536:

- AH-554 is an implementation child for public endpoint restoration.
- AH-536 must remain open while AH-554 has in-scope 502/DNS blockers, unless
  AH-536 is explicitly converted to tracking-only and the residual runtime task
  remains open with exact owner and blocker.
- AH-537 is historical adapter evidence for an older scoped route; it does not
  prove current AH-554 live-worker mutation authority.

## Closure Evidence

Done is invalid when based only on:

- GitHub PR/commit/merge;
- sandbox proof;
- stale NPM UI status;
- wrapper PASS without worker evidence;
- T0 direct runtime note;
- endpoint 200 that is not the expected service outcome;
- old report or receipt replay.

## Blocker Taxonomy

Use typed blockers only:

- `GITHUB_WRITE_ROUTE_REQUIRED`
- `GITHUB_PROTECTED_MAIN_GITLEAKS_GATE`
- `YOUTRACK_API_AUTH_REQUIRED`
- `AGENTHUB_MCP_TOOL_UNAVAILABLE`
- `AGENTHUB_LIVE_WORKER_AUTH_MISSING`
- `AGENTHUB_LIVE_ADAPTER_MISSING`
- `DOCKER_HOST_ACCESS_MISSING`
- `PORTAINER_ACCESS_MISSING`
- `DB_BACKUP_AUTH_MISSING`
- `PROXY_CONFIG_AUTH_MISSING`
- `FIREWALL_DNS_SSL_OWNER_GATE`
- `MINIO_AGENT_SHARE_EVIDENCE_TRANSPORT_DOWN`
- `OWNER_ONLY_DESTRUCTIVE_DELETE_GATE`
- `INSTRUCTION_SOURCE_DRIFT`
- `TASK_GRAPH_DEFECT`
- `SAFETY_QUARANTINE`

Each blocker must name affected lane/task/service, missing capability, why it
cannot be solved autonomously, next remediation, and whether it is local or
global.
