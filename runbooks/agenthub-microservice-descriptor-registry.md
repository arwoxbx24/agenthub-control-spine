---
artifact_id: agenthub-microservice-descriptor-registry-runbook
artifact_type: runbook
owner_role: Microservice Scope Broker
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Microservice Descriptor Registry

1. Identify service before touching it.
2. If descriptor exists, read it and bind task/RUN.
3. If descriptor is missing, create read-only descriptor draft with no secrets.
4. Record dependencies, routes, validation profile, rollback, and owner.
5. Unknown service becomes PackFix, not final blocker.
