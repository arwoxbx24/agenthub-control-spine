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

## AH-511 Clarification

T0 is not an emergency implementer. Urgency changes priority, not ownership.

Before any mutation, T0 must prove one of:

- the task is explicitly governance-only and the changed surface is limited to governance, reports, schemas, runbooks, or skill drafts;
- a scoped worker owns the mutation surface;
- a fallback worker receipt was registered before mutation because normal worker dispatch was unavailable.

If T0 mutates product code, runtime state, Docker, systemd, proxy, database, firewall, tests, or deployment behavior before worker ownership exists, the run is invalid. A green health check does not repair that violation.

The control-plane sequence is:

1. task id;
2. RUN_ID;
3. worker ownership;
4. implementation evidence;
5. validation evidence;
6. task readback;
7. AgentHub merge success;
8. short Russian user report.

Missing evidence is a same-run microtask, not a reason to stop.
