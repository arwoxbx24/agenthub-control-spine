---
artifact_id: p0-agenthub-x-self-critique-correction-20260528
artifact_type: self_critique_report
owner_role: T1 Architect / Verifier
source_task: AH-590
run_id: RUN-P0-AGENTHUB-X-CAPABILITY-HARD-ENFORCEMENT-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 AgentHub X Self-Critique And Correction

## Reflexion Checks

| Check | Verdict | Correction |
|---|---|---|
| Did this run attempt direct T0 runtime/product mutation? | PASS | No product/runtime/Docker/NPM/DB/proxy/DNS/firewall mutation was performed. Repo edits are governance/control-spine only after MCP run creation and sandbox worker evidence. |
| Did this run overload context? | PASS | Source reading stayed in the control-spine repository and selected relevant policy, schema, eval, receipt, and PR queue files. |
| Did this run create duplicate tasks/PRs/RUNs? | PASS_WITH_NOTE | One new RUN was created for the new 2026-05-28 P0 scope. Task-service returned NOOP/non-actionable, so closure must rely on AH-590 lineage and register/readback rather than fake task creation. |
| Did this run ask the owner for routine action? | PASS | Routine capability gaps are handled as repo controls and typed remediation gates. |
| Did this run risk GitHub-only Done? | PASS | Receipt, audit, evals, validators, registers, PR, and AgentHub merge are required. |
| Did this run risk fake runtime Done? | PASS | Reports state that runtime hook activation is not claimed unless adapter readback proves it. |

## 5 Whys

1. Why did bypass pressure recur? AgentHub route blockers stopped useful work
   before a scoped worker could act.
2. Why did blockers become owner-visible? Missing routine capability was treated
   like terminal blocked instead of same-RUN remediation.
3. Why did T0-like streams run commands? Role policy was not represented as a
   deterministic pre-action matrix and eval at every route.
4. Why did report-first drift persist? Done evidence was distributed across
   reports, PR queue, and task readback without one executable gate.
5. Why did token burn happen? Same-gate failures lacked a hard two-failure
   stop with same-RUN remediation.

## FMEA Summary

| Failure mode | Effect | Control |
|---|---|---|
| T0 executes command | Role breach and unsafe runtime mutation | T0 negative fixtures and hard-stop validator |
| Missing live capability | Bypass pressure or owner blocker | Internal remediation rule and typed hook blockers |
| Code/config handled by broad model | Weak implementation and cost waste | model-token router eval |
| Report without receipt | Fake Done | repo-first receipt validator |
| Secret handle missing | Raw credential request risk | `SECRET_HANDLE_MISSING` owner guide only |

## Negative Tests

Required negative tests are represented in
`evals/t0-direct-action-negative-tests/fixtures.json` and are executed by
`validators/t0_direct_action_hard_stop.rb`.

## Residual Typed Defects

Runtime hook/adapters are treated as installed only when live runtime readback
proves the path. If a future run cannot find a hook path, it must return one of
the exact typed blockers from `runbooks/agenthub-x-capability-remediation.md`.
