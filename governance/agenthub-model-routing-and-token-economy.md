---
artifact_id: agenthub-model-routing-and-token-economy
artifact_type: governance_policy
owner_role: T1 Architect
source_task: AH-590
run_id: RUN-P0-FULL-REQ-BACKEND-ONLY-ARCH-20260526
created_at: 2026-05-26
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Model Routing And Token Economy

## Routing Policy

Agents must read the approved runtime model registry before choosing a model.
Do not hardcode unavailable model names.

| Task class | Default route |
|---|---|
| P0 architecture/control decision | top reasoning model, bounded context |
| technical assignment / ADR | strong reasoning model with compact source packet |
| code/config/YAML/Bash/frontend/backend/tests | approved Codex/code-specialized worker |
| registrar/register/PR queue hygiene | low or medium cost model or deterministic tool |
| verification/QA/browser | verifier-capable model/tool route |
| security redaction | deterministic scanner first, model second |

## Cost Guards

- no full chat history to workers;
- pass artifact paths and compact extracts;
- stop same-gate loops after two failures;
- use one RUN with fallback instead of repeated RUNs;
- expensive models are forbidden for routine register formatting and PR queue
  updates.

## Codex Worker Requirement

Any code, shell script, YAML, Compose, frontend, backend, migration, build,
test, or DevOps code task must be routed to a code-specialized worker. T0 must
not manually author or patch the implementation.

