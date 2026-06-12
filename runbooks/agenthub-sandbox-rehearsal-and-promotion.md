---
artifact_id: agenthub-sandbox-rehearsal-and-promotion-runbook
artifact_type: runbook
owner_role: Sandbox Worker / Verifier
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Sandbox Rehearsal And Promotion

1. Write sandbox descriptor before risky work.
2. Use isolated inputs and no production secrets.
3. Run unit/static/API/browser/service checks matching scope.
4. Capture logs, screenshots, DOM, endpoint matrix, or health proof as applicable.
5. Document rollback.
6. Promote only with sandbox PASS, authority envelope, and live validation plan.
