---
artifact_id: agenthub-global-control-spine-audit
artifact_type: architecture-audit
owner_role: T1 Architecture Broker
source_task: AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523
run_id: RUN-agenthub-global-control-spine-audit-20260523
created_at: 2026-05-23
status: active
---

# AgentHub Global Control Spine Audit

## Scope

This audit repairs the global AgentHub governance control spine. The VPN incident,
the "Строй ремонт" report, and domain project references are evidence examples
only. They are not the target and they do not define the closure state for this
repair.

The target is the multi-agent control architecture: role boundaries, worker
routing, blocker semantics, task-service materialization, evidence closure, Done
taxonomy, DevOps incident routing, and final-output discipline.

## Source Readback

| Source | Status | Use |
|---|---|---|
| `AGENTS.md` | read | Canonical repo, T0 boundary, GitHub artifact role, no fake success. |
| `INDEX.md` | read | Artifact index requirement. |
| `governance/t0-t1-role-matrix.md` | read | Urgency changes priority, not ownership. |
| `governance/teamlead-t0-emergency-stop-control.md` | read | Emergency stop controls T0 direct execution. |
| `runbooks/teamlead-t0-role-drift-emergency-stop.md` | read | Stop direct execution and require evidence before Done. |
| `schemas/t0-emergency-stop-receipt.schema.json` | read | Existing gate classes and receipt structure. |
| `reports/receipts/AH-510-t0-emergency-stop-control-receipt.md` | read | Emergency stop is recorded but not the whole global repair. |
| `reports/incidents/AH-511-agent-cycle-self-critique.md` | read | Role drift, missing service graph, missing closure loop. |
| `reports/строй ремонт строя россия, отчетный блок.md` | read | Hot-lane, blocker, payload materialization, and Done taxonomy failures. |
| `skills-drafts/t0-non-authoring-gate/SKILL.md` | read | Draft T0 non-authoring control. |
| `skills-drafts/devops-incident-diagnostics/SKILL.md` | read | Draft T2 DevOps incident workflow. |
| `skills-drafts/agenthub-evidence-loop-closure/SKILL.md` | read | Draft evidence closure workflow. |
| PR #15 / merge `4f6b813` | read from git history | AH-511 report and draft skills are present on `main`. |

## Root-Cause Matrix

| Root cause | Finding | Required control |
|---|---|---|
| Role-boundary failure | T0 could reason itself into execution under pressure. | T0 Action Boundary Gate before mutation. |
| Evidence-order failure | Ownership and evidence could appear after execution. | Route receipt -> worker ownership -> implementation evidence -> validation evidence -> forbidden-scope evidence -> task readback -> merge -> final. |
| Closure-loop failure | Missing proof could become a terminal chat blocker. | Missing in-scope proof becomes a same-run microtask. |
| Blocker-semantics failure | Blocker could be a refusal or status update. | A-G blocker alternative matrix before final blocker. |
| Task-service materialization failure | Payloads could require physical proof before writeback and omit stable identifiers. | Canonical task-service payload builder contract. |
| Scope-collapse failure | "Close all" could trigger broad backlog loops. | Client closure hot-lane ledger. |
| Done taxonomy failure | Governance Done, task Done, sandbox proof, runtime green, and client Done were mixed. | Done Taxonomy Guard. |
| DevOps incident modeling failure | Service dependencies were discovered manually. | Service dependency graph and T2 incident worker contract. |
| Communication failure | Agents sent partial status or confidence language instead of proof-backed final state. | Final Answer Guard. |

## Existing / Missing / Promotion Matrix

| Control family | Existing state | Gap | Repair |
|---|---|---|---|
| T0 non-authoring | Draft skill and AH-510 emergency policy. | Not integrated into a global closure policy. | Promoted into `governance/agenthub-global-role-and-closure-control.md`. |
| Worker ownership | Present in role matrix and emergency stop. | Missing full pre-bound contract fields. | Added global worker gate and receipt schema. |
| Evidence loop | Draft skill. | Missing global gate and runbook. | Added policy, runbook, and unified receipt schema. |
| Blocker matrix | Described in AH-509 report. | Not a reusable gate. | Added A-G matrix to policy and runbook. |
| Hot-lane | Described in AH-509 report. | Project report only. | Added global hot-lane gate. |
| Done taxonomy | Implied across reports. | Not explicitly enforced. | Added Done Taxonomy Guard. |
| Payload builder | AH-509 identified the need. | No schema contract. | Added `schemas/task-service-payload-builder-contract.schema.json`. |
| No-repeat same-gate loop | Identified in prompt/report. | Not enforceable. | Added no-repeat gate in policy and receipt schema. |
| Service dependency graph | AH-511 identified the need. | No schema. | Added `schemas/service-dependency-graph.schema.json`. |
| Final answer discipline | Scattered in policies. | Not unified. | Added Final Answer Guard. |

## Architecture Options

### Option A: Conservative

Keep AH-510 and AH-511 controls separate, then add only this synthesis report and a
receipt. This has the lowest change risk, but leaves controls fragmented and still
depends on humans to combine separate documents during an incident.

### Option B: Balanced

Add one integrated global architecture control policy, one closure runbook,
unified receipt schema, task-service payload-builder contract, service dependency
graph schema, reusable prompt, and receipt. Preserve existing reports and draft
skills as evidence sources. This is the selected option because it repairs the
control spine without mutating runtime, infrastructure, or client products.

### Option C: Progressive

Design a future policy-as-code or state-machine layer for AgentHub action gates.
This has higher payoff, but requires separate authorization and implementation
because it would change runtime behavior.

Decision: `Option B`.

## Control Package

The repair package installs these global controls:

- T0 Action Boundary Gate.
- Worker Ownership Contract.
- Evidence Loop Closure Gate.
- Blocker Alternative Matrix Gate.
- Client Closure Hot-Lane Gate.
- Done Taxonomy Guard.
- Task-Service Payload Builder Contract.
- No-Repeat Same-Gate Loop.
- DevOps Service Graph and T2 Incident Worker Contract.
- Final Answer Guard.

## Acceptance Gates

| Gate | Status |
|---|---|
| Canonical repo gate | PASS: `arwoxbx24/agenthub-control-spine` confirmed. |
| Source read gate | PASS: mandatory sources read and blob SHAs matched the supplied observations. |
| Duplicate gate | PASS: no equivalent global package existed; fragmented controls were promoted. |
| T0 boundary gate | PASS: governance-only repo artifacts under control-spine. |
| Worker gate | PASS: AgentHub MCP run and scoped repo-artifact worker receipt recorded. |
| Blocker matrix gate | PASS: A-G alternatives encoded. |
| Done taxonomy gate | PASS: final states separated. |
| Evidence loop gate | PASS: same-run microtask rule encoded. |
| Hot-lane gate | PASS: urgent/client closure semantics encoded. |
| No-repeat gate | PASS: repeated identical gate retries blocked. |
| Secret gate | pending final validation in receipt. |
| Index gate | pending final validation in receipt. |
| Changelog gate | pending final validation in receipt. |
| Runtime safety gate | PASS: no runtime, infrastructure, or client product mutation in this package. |
| Final receipt gate | pending final receipt. |

## Residual Risks

- The schemas are contract specifications, not a deployed runtime policy engine.
- Task-service live write enforcement remains owned by AgentHub runtime; this repo
  records the expected payload and closure contract.
- Future DevOps incident execution still requires a T2 worker and explicit
  authorization for any live environment surface.
