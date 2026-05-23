---
artifact_id: governance-control-spine-current-baseline
artifact_type: current-baseline
owner_role: T1 Architecture Broker
source_task: AH-CONTROL-SPINE-LIFECYCLE-20260523
created_at: 2026-05-23
last_reviewed_at: 2026-05-23
lifecycle_status: active
execution_status: pass
load_policy: default
safe_to_replay: false
supersedes: none
superseded_by: none
canonical_decision_ref: self
status: active
---

# Control-Spine Current Baseline

## Default Agent Baseline

This is the compact current baseline for AgentHub control-spine work. Agents load
this baseline by default instead of reading every report.

## Canonical Boundaries

- Canonical repository: `arwoxbx24/agenthub-control-spine`.
- Forbidden default owner: `arwoxb24`.
- GitHub stores versioned artifacts only.
- YouTrack remains the task system.
- AgentHub/Codex and approved MCP routes remain the execution environment.
- No runtime, production, infrastructure, storage, network-edge, database, or
  client-project mutation is authorized by this repository.

## Active Control Surface

Load these only as needed for the task:

- `AGENTS.md`: repository role and safety rules.
- `INDEX.md`: compact artifact index and register pointer.
- `ARTIFACT_REGISTER.md`: lifecycle metadata and load policy.
- `governance/artifact-lifecycle-policy.md`: artifact retention and context hygiene.
- `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt`: GitHub bridge.
- `governance/agenthub-single-ingress-control.md`: single AgentHub ingress rule.
- `governance/teamlead-t0-emergency-stop-control.md`: T0 direct-execution stop rule.
- `governance/task-first-policy.md`: task-first governance.
- `governance/done-gate-policy.md`: Done gate semantics.
- `governance/secret-protection-policy.md`: secret handling.
- `runbooks/agenthub-locked-run-recovery.md`: locked run recovery.
- `runbooks/teamlead-t0-role-drift-emergency-stop.md`: role drift stop procedure.
- `schemas/agenthub-run-preflight.schema.json`: run preflight schema.
- `schemas/t0-emergency-stop-receipt.schema.json`: T0 emergency stop receipt schema.

## Extracted Historical Decisions

These reports are evidence only. Their durable decisions have been extracted into
the active control surface or this baseline:

- `reports/incidents/AH-511-agent-cycle-self-critique.md`: T0 cannot implement
  under urgency; worker ownership must precede mutation; service dependency
  graphs and evidence-before-Done are required.
- `reports/строй ремонт строя россия, отчетный блок.md`: client delivery
  hot-lane, blocker-as-checkpoint, task-service payload materialization, and
  Done taxonomy are global lessons; the project-specific details are not default
  context.
- `reports/receipts/*`: proof records only, not prompt or governance sources.
- `reports/handoffs/*`: historical handoff evidence only.

## Default Load Exclusions

Do not load these by default:

- `reports/`;
- `reports/receipts/`;
- `reports/handoffs/`;
- `reports/incidents/`;
- `reports/security/`;
- `reports/apps/`;
- `prompts/` unless `safe_to_replay=true`;
- `apps/` as governance instruction source.

## Current Replay Rule

Prompts are executable only when `ARTIFACT_REGISTER.md` marks them
`lifecycle_status=active`, `load_policy=task_specific` or `default`, and
`safe_to_replay=true`. No current prompt in this repository is default-load
replay material.
