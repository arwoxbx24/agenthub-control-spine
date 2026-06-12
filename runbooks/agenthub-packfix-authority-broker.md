---
artifact_id: agenthub-packfix-authority-broker-runbook
artifact_type: runbook
owner_role: T1 Architecture Broker / Authority Broker
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub PackFix Authority Broker

1. Normalize blocker.
2. Classify lane 0-7.
3. Decide routine vs owner-only.
4. For routine blockers, create PackFix event in the same RUN.
5. Issue the narrowest authority envelope.
6. Dispatch one scoped worker.
7. Validate repair.
8. Continue original lifecycle.
9. Stop after two same-gate failures with one typed blocker.
