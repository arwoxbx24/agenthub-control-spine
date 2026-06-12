---
artifact_id: agenthub-docs-source-packet-runbook
artifact_type: runbook
owner_role: Docs Worker / T1 Architect
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Docs Source Packet

1. Identify every product, API, CLI, model, service, framework, or integration claim.
2. Fetch official docs first.
3. Record URL, version/page family, retrieval timestamp, sections, supported claims, stale risk, and confidence.
4. Reuse packet inside the same RUN unless stale.
5. If docs cannot be acquired, create `DOCS_ACQUISITION_PACKFIX_REQUIRED`.
