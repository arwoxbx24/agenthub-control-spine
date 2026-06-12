---
artifact_id: agenthub-authority-broker-packfix-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker / Authority Broker
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Authority Broker PackFix Policy

T0 does not receive universal power. Scoped workers receive precise authority envelopes inside one task, RUN, lane, and scope.

## Lanes

- Lane 0: read-only discovery and docs packet
- Lane 1: repository artifact write
- Lane 2: register/index/PR queue update
- Lane 3: validator execution
- Lane 4: sandbox rehearsal
- Lane 5: browser/API/user outcome QA
- Lane 6: scoped live repair with rollback
- Lane 7: destructive or irreversible action, owner-only unless explicit policy pre-approves exact target class

## PackFix loop

Routine blockers must be normalized, assigned a lane, repaired once in the same RUN, validated, and recorded. The same blocker may retry once with new evidence. A third equivalent attempt is forbidden.

Allowed final blockers are only owner-only irreversible, owner-only integration/secret/account/payment/legal authority, forbidden scope, or destructive DB/Docker-volume approval.
