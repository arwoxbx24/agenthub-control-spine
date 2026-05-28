---
artifact_id: p0-agenthub-self-healing-core-architecture-audit-20260528
artifact_type: audit_report
owner_role: T1 Architect / Truth Redteam / Verifier
source_task: AH-590
run_id: RUN-P0-SELF-HEALING-CORE-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 AgentHub Self-Healing Core Architecture Audit

## Scope

Control-spine governance, schemas, validators, eval fixtures, reports, receipts,
and registers only. This run does not mutate Docker, NPM, DB, proxy, firewall,
DNS, SSL, production runtime, product repos, or secret values.

## Fact Audit

| Root cause | Verdict | Evidence | Installed correction |
|---|---|---|---|
| R1 prompt-only controls are insufficient | CONFIRMED | Prior controls existed as policies and reports while owner still reported T0 direct-action drift. | `agenthub-self-healing-core-policy.md` requires policy-as-code receipts and evals before Done. |
| R2 generic blockers become terminal | CONFIRMED | Existing PR queue records live-route blockers and contract-only dispatch limits as residuals. | Self-healing event schema and route recovery runbook make ordinary defects internal same-RUN repair events. |
| R3 capability model incomplete at action boundary | PARTIAL | `agenthub_action_policy_validator.rb` enforces current action fields, but no standalone authorization receipt schema existed. | Added action authorization receipt schema and capability matrix schema/policy. |
| R4 model router incomplete | PARTIAL | PR #84 fixed fallback evidence for action policy; model router fixture existed separately. | Self-healing E5/E6 fixtures enforce Codex route and same-RUN fallback defect handling. |
| R5 registrar route not autonomous enough | CONFIRMED | Register gaps previously required follow-up PRs/readback. | E7/E10/E11 fixtures require registrar repair/readback instead of Done. |
| R6 task-debt controller incomplete | PARTIAL | PR queue contains superseded/stale examples and duplicate consolidation receipts. | Self-healing event model includes `TASK_DEBT_DEFECT`; E9/E10/E11 gate no blind loops and missing readback. |
| R7 session isolation incomplete | PARTIAL | Prior incident reports record mixed sessions and role drift. | Receipts must bind RUN/task/scope; event schema records same-RUN repair state. |
| R8 secrets/auth discovery not standardized | PARTIAL | Existing secrets-registry policy exists, but no self-healing runbook for handle acquisition was installed. | Added secrets handle registry runbook with redacted metadata-only flow. |
| R9 owner-facing backend-only communication not enforced enough | CONFIRMED | Earlier reports record verbose intermediate owner chat. | E15 fixture enforces final-only owner output mode. |

## 5 Whys

1. Why did repeated residuals reach the owner? Ordinary platform gaps were
   represented as blockers instead of repairable events.
2. Why did blockers repeat? The run state did not require a same-RUN repair
   owner after repeated failures.
3. Why did T0 drift into execution? Role rules existed in prose but action
   authorization receipts were not a first-class contract.
4. Why did model routing regress? Model-route proof was split across policy,
   fixtures, and PR receipts without a unified self-healing defect class.
5. Why did register/readback require follow-up prompts? Register coverage was a
   Done gate, but missing registrar route was not consistently modeled as an
   internal microtask.

## FMEA

| Failure mode | Effect | Control |
|---|---|---|
| T0 direct shell or code | unsafe bypass | E1/E2 deny before execution |
| Missing surface fields | unscoped worker action | E3/E4 policy defect |
| Non-Codex code route | wrong model/tool route | E5 model defect |
| Fallback without same-RUN proof | duplicate or unauthorized worker route | E6 model fallback defect |
| Missing registrar route | evidence gap becomes blocker | E7 registrar repair |
| Missing live worker route | repeated user-facing blocker | E8 live route repair first |
| Same blocker repeats | token burn | E9 self-healing escalation |
| Report without register | false Done | E10 register coverage gate |
| PR without task readback | false Done | E11 task readback gate |
| Green localhost only | false user outcome | E12 user outcome gate |
| Stale report replay | old prompt becomes instruction | E13 stale replay block |
| Wrong task class | wrong worker/surface | E14 class blocker |
| Intermediate owner logs | noise and leakage risk | E15 backend-only output |

## Evidence Map

- Policy: `governance/policies/agenthub-self-healing-core-policy.md`
- Matrix: `governance/policies/agenthub-capability-matrix.md`
- Schemas: `schemas/agenthub_action_authorization_receipt.schema.json`,
  `schemas/agenthub_capability_matrix.schema.json`,
  `schemas/agenthub_self_healing_event.schema.json`
- Runbooks: `runbooks/agenthub-self-healing-route-recovery.md`,
  `runbooks/agenthub-secrets-handle-registry.md`
- Validator: `validators/agenthub_self_healing_validator.rb`
- Evals: `evals/agenthub-self-healing/fixtures/fixtures.json`

## Residual Risk

This run installs and validates repository-governance controls. It does not
claim direct mutation of live Linux/Docker/proxy/DB hooks. If a future runtime
does not expose a pre-tool hook for a specific action class, that is
`ROUTE_DEFECT` and must become a same-RUN self-healing event, not a T0
workaround.
