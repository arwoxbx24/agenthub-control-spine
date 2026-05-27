---
artifact_id: t0-direct-action-violation-response
artifact_type: runbook
owner_role: T0 Control / Verifier
source_task: AH-590
run_id: RUN-P0-GLOBAL-AGENT-CONTROL-SECRETS-REPO-AUDIT-20260527
created_at: 2026-05-27
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# T0 Direct Action Violation Response

1. Stop the direct action path before any further mutation.
2. Preserve the minimal redacted evidence: run id if present, task id if present, action class, denied surface, timestamp, and receipt path.
3. Do not paste commands, secrets, env values, raw logs, or transcript links into owner chat.
4. Quarantine unlabeled sessions that lack `run_id`, `task_id`, role, and scope.
5. Re-route through AgentHub Lifecycle Controller with a scoped T2/Registrar/Verifier worker.
6. If the same blocker has already repeated twice, stop retrying and open architecture repair or record the typed blocker.

Required receipt fields: `run_id`, `task_id`, `actor_role`, `blocked_action_class`, `deny_code`, `evidence_path`, `secret_redaction_gate`, `next_route`.
