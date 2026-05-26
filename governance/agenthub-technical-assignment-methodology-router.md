---
artifact_id: agenthub-technical-assignment-methodology-router
artifact_type: governance_policy
owner_role: T1 Architect
source_task: AH-590
run_id: RUN-P0-FULL-REQ-BACKEND-ONLY-ARCH-20260526
created_at: 2026-05-26
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Technical Assignment Methodology Router

## Technical Assignment Before Implementation

Nontrivial implementation requires a technical assignment before worker
execution. Required fields:

- title;
- task class;
- source task;
- goal;
- current state;
- target state;
- stack and services;
- repositories and branch strategy;
- allowed and forbidden actions;
- implementation order;
- rollback plan;
- validation and test plan;
- security constraints;
- evidence plan;
- Done gate;
- blockers.

## Methodology Routing

Use methods by task class, not all at once:

- AgentHub/control-plane incident: SRE, 5 Whys, FMEA, ADR, evals.
- Product feature: stakeholder capture, user stories, ADR/C4, test pyramid.
- Code bug: debugging ladder, TDD when behavior is known, review checklist.
- DevOps incident: SRE, observability, rollback, no destructive action.
- Repo hygiene: registrar lifecycle, artifact register, PR queue model.

## Micro-TZ Rule

Use micro technical assignments when one task exceeds worker context. Each
micro-TZ has one scope signature and returns evidence to the parent task, not
to user chat.

