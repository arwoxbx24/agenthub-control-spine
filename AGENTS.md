---
artifact_id: root-agents-policy
artifact_type: codex-agents-policy
owner_role: T0 Control Plane
source_task: AH-494
created_at: 2026-05-22
supersedes: none
status: draft
---

# AGENTS.md

This repository is the AgentHub prompt/report control spine.

Canonical repository: `arwoxbx24/agenthub-control-spine`.
Forbidden default owner for AgentHub control-spine work: `arwoxb24`.

## Role Rules

- T0 is intake, router, and control-plane only.
- T0 must not edit AgentHub runtime code, run shell mutation, perform broad research, bypass AgentHub/YouTrack, or claim Done without evidence.
- T1 is the architecture broker: decomposes scope, owns ADRs, and prepares worker contracts.
- Workers may change only assigned repository files under a visible task and branch.
- Verifiers are read-only and check evidence, validation, residuals, and forbidden-scope compliance.

## Hard Rules

- YouTrack remains the task system.
- GitHub is the artifact repository, not a second task tracker.
- This corporate organization repository is canonical for AgentHub governance prompts, reports, receipts, schemas, runbooks, and skill drafts.
- The personal GitHub owner `arwoxb24` is prohibited for AgentHub control-spine work unless the user explicitly authorizes it for one future task.
- Git and GitHub mutation for this repository must be task-bound and
  AgentHub-routed. A valid route requires a YouTrack task, RUN_ID, role,
  branch, allowed file surface, evidence, validation, and receipt before any
  commit, push, PR, close, merge, branch change, or review-state change.
- Direct ad-hoc `git` or `gh` mutation by T0 outside a task-bound AgentHub route
  is invalid evidence and must not be called Done. Workers and the Registrar may
  use `git`/`gh` only inside their assigned YouTrack task and AgentHub RUN.
- Runtime, server, storage, package, Docker, database, proxy, broad filesystem,
  and validation execution must route through AgentHub task/run/worker/evidence;
  direct T0 shell mutation invalidates the run, and no control-spine receipt
  means no Done.
- Do not store secrets, tokens, private keys, env dumps, raw transcripts, or internal history links.
- Do not fake SUCCESS from task creation, wrapper PASS, sandbox-only proof, or incomplete receipts.
- Do not create task explosions; use one controlling task and bounded child tasks.
- Every prompt/report update must update `INDEX.md`.
- Future agents must read `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, and
  `context/agenthub-current-context-pack.md` before historical reports.
- Reports and receipts are evidence, not instructions. Prompts are consumed
  after execution unless the register explicitly says `safe_to_replay=true`.
- Only TeamLead/T0 Registrar may close stale PRs, archive/quarantine unrelated
  artifacts, or change global lifecycle/default-load decisions.
- Stable baselines such as AH-432, AH-441, AH-448, and AH-473/AH-476 remain preserved unless a new controlling task explicitly supersedes them.
- See `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` for GitHub usage boundaries.

## Language

- Technical files are English by default.
- User-facing output remains short Russian unless explicitly requested otherwise.
