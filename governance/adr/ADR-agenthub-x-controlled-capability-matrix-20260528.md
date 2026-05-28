---
artifact_id: adr-agenthub-x-controlled-capability-matrix-20260528
artifact_type: architecture_decision_record
owner_role: T1 Architect / Registrar
source_task: AH-590
run_id: RUN-P0-AGENTHUB-X-CAPABILITY-HARD-ENFORCEMENT-20260528
created_at: 2026-05-28
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# ADR: AgentHub X Controlled Capability Matrix

## Status

Accepted.

## Context

Owner evidence and prior control-spine receipts show that T0 direct-action
controls exist, but runtime-route blockers and schema/report drift still create
bypass pressure. A strict blocker-only posture causes useful work to stop before
reaching the correct worker. Unrestricted root access would break role,
secret, runtime, and production safety boundaries.

## Decision

Use a controlled AgentHub X capability matrix. Each action must resolve to a
profile, role, authority, allowed surface, forbidden surface, rollback rule,
validation rule, evidence path, and receipt path before execution.

T0 is permanently `T0_CONTROL_ONLY`. Code/config work routes to
`T2_CODEX_IMPLEMENTER`. Runtime read and repair work routes to P4 profiles.
Registrar and Verifier remain bounded to their surfaces.

## Rejected Options

- Strict blockers everywhere: rejected because it creates blocker loops and
  black-box fallback pressure.
- Unrestricted root/global rights: rejected because it is unsafe for secrets,
  Docker, DB, proxy, DNS, firewall, payments, and client projects.

## Consequences

- Missing routine capability becomes an internal remediation task, not an owner
  blocker.
- Owner-only blockers remain narrow and explicit.
- `DONE_WITH_EVIDENCE` requires matrix validation, negative and positive evals,
  repo-first receipt, register coverage, and task readback.

## Rollback

Revert this policy and schema/eval package as one control-spine PR if it blocks
authorized worker routes that should pass. Do not bypass by granting T0 shell or
runtime authority.
