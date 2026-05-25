---
artifact_id: AGENTHUB-P0-repo-first-agent-execution-freeze-20260525
artifact_type: corrective-incident-audit
owner_role: T0 Registrar / Control Plane
source_task: AH-567 / AH-536 / AH-554 / AH-542 / AH-534 / AH-537
run_id: RUN-agenthub-p0-repo-first-freeze-20260525
created_at: 2026-05-25
status: frozen-with-blocker
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# AgentHub P0 Repo-First Agent Execution Freeze

## Classification

Task class: `INCIDENT_CORRECTION + AGENTHUB_SYSTEM_PROCESS + CONTROL_SPINE_REGISTRAR`.

Severity: `P0_CONTROL_PLANE_SAFETY_INCIDENT`.

Scope signature:

`AH-536/AH-554 repo-first runtime closure safety incident; AgentHub-only; no BMC/Appsmith/n8n/Stroyremont; no direct T0 runtime mutation.`

## Controlling Task

- Controlling issue: `AH-567`.
- Parent runtime incident: `AH-536`.
- Child runtime repair: `AH-554`.
- Related control tasks: `AH-542`, `AH-534`, `AH-537`.
- Duplicate check result: no existing issue matched the exact repo-first
  execution-freeze contract, so `AH-567` was created as the controlling P0
  safety incident.

## Canonical Repo Gate

- Canonical repo: `arwoxbx24/agenthub-control-spine`.
- GitHub app readback: repo exists under `arwoxbx24`, push/admin permissions are
  available.
- Forbidden personal owner `arwoxb24` was not used as canonical.
- Working branch: `agenthub/ah536-ah554-final-receipt-20260525`.

## Source Files Read

- `AGENTS.md`
- `INDEX.md`
- `ARTIFACT_REGISTER.md`
- `PR_QUEUE_REGISTER.md`
- `context/agenthub-current-context-pack.md`
- `governance/agenthub-only-execution-discipline.md`
- `governance/agenthub-docker-db-proxy-safety-policy.md`
- `governance/agenthub-access-rights-and-live-worker-enablement-policy.md`
- `governance/agenthub-task-cycle-full-closure-policy.md`
- `runbooks/agenthub-502-live-runtime-recovery-safe-runbook.md`

## Active Skills

- `agenthub-task-first-router`
- `agenthub-role-boundary-t0`
- `agenthub-registrar-artifact-lifecycle`
- `agenthub-git-pr-queue-control`
- `agenthub-truth-redteam`
- `agenthub-security-redaction`
- `agenthub-prompt-architect`
- `caveman-user-communication`
- `agenthub-permission-gate-router`

`agenthub-live-devops-safety` remains gated until a valid live T2 worker route is
available.

## Forbidden Skills / Surfaces

Forbidden before a new repo-first gate and live-worker authorization:

- direct backend/frontend implementation skills;
- direct Docker/proxy/DB/firewall/runtime skills;
- broad cleanup workers;
- Stroyremont/HTML/editor/content work;
- BMC/Appsmith/n8n work;
- Telegram MTProxy routing for this NPM/Docker incident.

Explicit exclusions:

- BMC/Appsmith/Margin Cockpit / port `20120`;
- n8n / `http://n8n:5678`;
- Stroyremont HTML/editor/content/news/image surfaces.

## Contradiction Summary

Two repo evidence states conflict:

- Commit `16bde31` recorded `DONE_WITH_EVIDENCE` for the AH-536/AH-554 live
  edge closure.
- Commit `eebdb85` recorded a repo-first corrective audit showing fresh public
  readback still returned active `502` outcomes and set
  `AGENTHUB_LIVE_WORKER_ROUTE_BLOCKED`.

Current controlling interpretation: `eebdb85` supersedes the earlier closure
claim because current public/user outcome evidence is required for runtime Done.

## Freeze Decision

T0 direct mutation is frozen. Further code, shell, Docker, proxy, DB, firewall,
runtime, or product mutation is not allowed from T0.

No live runtime repair may continue until:

- repo-first receipt exists;
- task readback exists;
- live T2 worker authorization exists;
- rollback/checkpoint contract exists;
- public endpoint/user outcome validation is defined.

## Current Gate State

| Gate | State |
|---|---|
| `REPO_BINDING_GATE` | PASS |
| `ARTIFACT_LIFECYCLE_GATE` | PASS after this artifact is registered |
| `TASK_FIRST_GATE` | PASS via `AH-567`, `AH-536`, `AH-554` |
| `ROLE_BOUNDARY_GATE` | FAIL for prior direct T0 runtime mutation evidence |
| `LIVE_AUTH_GATE` | FAIL |
| `NO_SECRET_GATE` | PASS |
| `NO_BMC_GATE` | PASS |
| `RUNTIME_REPAIR_GATE` | FAIL / not accepted |
| `DONE_GATE` | FAIL for AH-536/AH-554 runtime closure |

## Next Authorized Action

One of:

1. install or verify durable repo-first/pretool/final validators under the
   control-spine, if not already enforceable; or
2. after repo-first gate passes, dispatch exactly one accepted live T2 DevOps
   worker for AH-536/AH-554 with P5/P8 scope, rollback/checkpoint, exclusions,
   and public endpoint validation.

## Typed Blocker

`AGENTHUB_LIVE_WORKER_ROUTE_BLOCKED`.

Exact blocker meaning: no accepted live T2 worker route is currently available
that can be used as valid runtime closure evidence for AH-536/AH-554.
