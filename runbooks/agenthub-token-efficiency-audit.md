---
artifact_id: agenthub-token-efficiency-audit-runbook
artifact_type: runbook
owner_role: Token Efficiency Profiler
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Token Efficiency Audit

1. Count duplicate tasks, duplicate PRs, same-gate retries, prompt dumps, full artifact reloads, and owner chat messages.
2. Prefer exact artifact paths and hashes over pasted content.
3. Select MICRO/STANDARD/INCIDENT/FULL profile.
4. Record baseline and after metrics.
5. If target reduction is not met, create `TOKEN_EFFICIENCY_PACKFIX_REQUIRED` with concrete next controls.
