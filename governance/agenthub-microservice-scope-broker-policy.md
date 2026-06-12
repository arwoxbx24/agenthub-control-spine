---
artifact_id: agenthub-microservice-scope-broker-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker / Microservice Scope Broker
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Microservice Scope Broker Policy

No agent may touch a microservice without identifying a descriptor or creating a read-only descriptor draft.

## Descriptor fields

`service_id`, `service_name`, `project_root`, `repository`, `runtime_type`, `ports`, `public_routes`, `health_endpoints`, `dependencies`, `upstream_services`, `downstream_services`, `data_owner`, `secret_handles`, `deployment_method`, `sandbox_strategy`, `validation_profile`, `rollback_strategy`, `owner`, `last_verified_at`, and `known_blockers`.

Unknown service becomes `SERVICE_DESCRIPTOR_MISSING` and must become same-RUN PackFix, not final chat blocker.
