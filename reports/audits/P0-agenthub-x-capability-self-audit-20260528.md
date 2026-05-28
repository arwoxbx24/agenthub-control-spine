---
artifact_id: p0-agenthub-x-capability-self-audit-20260528
artifact_type: audit_report
owner_role: T1 Architect / Lifecycle Controller / Registrar / Verifier
source_task: AH-590
run_id: RUN-P0-AGENTHUB-X-CAPABILITY-HARD-ENFORCEMENT-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 AgentHub X Capability Self-Audit

## Scope

This audit covers AgentHub/control-spine governance, capability routing,
T0 hard-stop policy, repo-first reporting, methodology gates, model/token
routing, and self-audit controls. It does not claim product/runtime/Docker/NPM/
DB/proxy/DNS/firewall mutation.

## Methodology Selection

Selected profile: FULL. Reason: P0 architecture/control defect with safety,
role-boundary, routing, evidence, and enforcement impact.

Activated methods: 5 Whys, FMEA, ADR, Plan-and-Execute, DevSecOps, SRE-style
evidence gates, code-review checklist, and repo-first receipt validation.

Not activated: DDD/Event Storming, browser QA, mutation testing, and product
contract testing because this scope is not a domain/product implementation.

## Evidence Table

| Finding | Status | Evidence | Resolution |
|---|---|---|---|
| F1. T0 direct CLI/shell/code attempt exists | CONFIRMED | Owner-provided transcript shows direct `twc`, `yc`, `docker`, `python`, `php/node`, `curl`, `sed`, `git`, and ad-hoc script patterns in a TeamLead-like stream; prior incident `reports/incidents/P0-t0-boundary-violation-multi-agent-runaway-20260527.md` records the same failure class. | `governance/agenthub-x-capability-matrix.md`, `validators/t0_direct_action_hard_stop.rb`, and negative fixtures block T0 direct actions before execution. |
| F2. AgentHub route blocks useful live work and causes bypass pressure | CONFIRMED | `reports/receipts/P0-global-agent-control-secrets-and-repo-receipt-20260527.md` records `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`; AH-536/AH-537 receipt records live route repair as platform-gated. | Missing routine route now becomes `INTERNAL_CAPABILITY_REMEDIATION_REQUIRED` or exact hook-path blocker, not T0 fallback. |
| F3. AgentHub X lacks a complete capability matrix | PARTIAL | AH-554 has P0-P9 access matrix, but it does not encode the requested AgentHub X profiles and owner-only/remediation semantics. | Added `governance/agenthub-x-capability-matrix.md` and `schemas/agenthub-x-capability-matrix.schema.json`. |
| F4. Repo-first/report-first enforcement is incomplete | PARTIAL | PR queue and artifact registers exist, but owner evidence and prior receipts show actions may precede visible receipt/readback. | Added `validators/repo_first_receipt_gate.rb` and repo-first evals requiring audit, receipt, registers, PR queue, task readback, and secret scan. |
| F5. Methodologies exist but are not enforced | PARTIAL | `governance/agenthub-technical-assignment-methodology-router.md` exists; owner evidence reports blind enumeration and repeated attempts. | Matrix adds pre-action methodology gate and audit records selected profile. |
| F6. Task debt and duplicate task loops exist | CONFIRMED | PR queue shows multiple AH-590 and AH-571/AH-575 tails; prior incident records task multiplication. | Same scope must consolidate under AH-590 lineage; missing capability remediates same RUN, no duplicate RUN by default. |
| F7. Model/token routing is weak | PARTIAL | Model/token policies exist, but owner evidence reports expensive loops and inconsistent Codex worker routing. | Added `validators/model_token_router_validator.rb` and evals enforcing Codex-capable route for code/config and same-gate stop after two failures. |
| F8. Owner communication is not backend-only | CONFIRMED | Owner evidence reports verbose intermediate technical stream; prior backend-only policy exists. | Capability matrix and receipt keep owner-facing output final-only; final format remains compact Russian. |

## Root Causes

- Prompt-level role boundaries were stronger than runtime-adapter enforcement.
- Prior access matrices covered permissions but not the closed-contour
  remediation rule for missing routine capability.
- Report/register controls existed but were not represented as a deterministic
  Done gate.
- Model routing rules were policy text without a small executable eval.

## Installed Controls Needed And Added

- Capability matrix: `governance/agenthub-x-capability-matrix.md`.
- ADR: `governance/adr/ADR-agenthub-x-controlled-capability-matrix-20260528.md`.
- Schemas: `schemas/agenthub-x-capability-matrix.schema.json`,
  `schemas/agent-action-request.schema.json`.
- Validators: `validators/agenthub_action_policy_validator.rb`,
  `validators/t0_direct_action_hard_stop.rb`,
  `validators/model_token_router_validator.rb`,
  `validators/repo_first_receipt_gate.rb`.
- Evals: `evals/t0-direct-action-negative-tests/`,
  `evals/agenthub-x-capability-matrix/`,
  `evals/agenthub-x-capability-positive-tests/`,
  `evals/model-token-routing/`, `evals/repo-first-reporting/`.
- Runbook: `runbooks/agenthub-x-capability-remediation.md`.

## Risk And Rollback

Risk: a future adapter may not yet call these validators. Mitigation: final
state must remain repository-governance Done only unless runtime hook readback
proves installation. If a hook path is unknown, use the exact typed blocker from
the remediation runbook.

Rollback: revert this package as one control-spine PR; do not grant T0 direct
shell/runtime authority as rollback.
