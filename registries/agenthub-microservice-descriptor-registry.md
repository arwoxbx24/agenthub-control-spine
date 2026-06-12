---
artifact_id: agenthub-microservice-descriptor-registry
artifact_type: descriptor-registry
owner_role: Microservice Scope Broker
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: current_baseline
default_load: false
safe_to_replay: false
---

# AgentHub Microservice Descriptor Registry

This registry stores descriptor references, not secrets.

| service_id | service_name | project_root | repository | runtime_type | validation_profile | rollback_strategy | owner | last_verified_at | known_blockers |
|---|---|---|---|---|---|---|---|---|---|
| `agenthub-control-spine` | AgentHub Control Spine | `@workspace/projects/agenthub-control-spine` | `arwoxbx24/agenthub-control-spine` | repository-governance | validators plus GitHub/YouTrack readback | branch/PR rollback | T0 Registrar | 2026-06-12 | command-worker route blocked for live shell; repository connector path active |

New services must be added only after read-only descriptor intake.
