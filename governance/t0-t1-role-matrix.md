---
artifact_id: governance-t0-t1-role-matrix
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-494
created_at: 2026-05-22
supersedes: none
status: draft
---

# T0/T1/Worker Role Matrix

| Role | Owns | Must not do |
|---|---|---|
| T0 Control Plane | intake, duplicate check, task anchor, routing, final user summary | runtime code edits, service mutation, broad research, fake closure |
| T1 Broker | architecture, decomposition, ADR, worker contracts | domain mutation, uncontrolled fanout |
| Worker | scoped file changes | cross-scope edits, secrets, runtime/service mutation unless explicitly assigned |
| Verifier | read-only evidence review | repair work, silent acceptance |

