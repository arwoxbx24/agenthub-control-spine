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
- Do not store credentials, tokens, key material, environment exports, verbatim session logs, or unredacted internal trace links.
- Do not fake SUCCESS from task creation, wrapper PASS, sandbox-only proof, or incomplete receipts.
- Do not create task explosions; use one controlling task and bounded child tasks.
- Every prompt/report update must update `INDEX.md`.
- Stable baselines such as AH-432, AH-441, AH-448, and AH-473/AH-476 remain preserved unless a new controlling task explicitly supersedes them.
- See `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` for GitHub usage boundaries.

## Default Load And Lifecycle Rules

- Agents must not load all reports by default.
- Default context is `AGENTS.md`, `INDEX.md`, `ARTIFACT_REGISTER.md`, `governance/control-spine-current-baseline.md`, and task-specific active controls only.
- `reports/`, `reports/receipts/`, `reports/handoffs/`, `reports/incidents/`, and `reports/security/` are audit evidence by default, not standing instructions.
- Archived, implemented, superseded, quarantined, and receipt artifacts require an explicit task-specific audit reason before loading.
- A report cannot override current governance unless its decision was promoted into an active governance, runbook, schema, skill, or baseline artifact.
- A prompt is executable only when `ARTIFACT_REGISTER.md` marks it active, not superseded, and `safe_to_replay=true`.
- If `INDEX.md` and `ARTIFACT_REGISTER.md` disagree, stop and repair the register before using stale artifacts as context.

## Language

- Technical files are English by default.
- User-facing output remains short Russian unless explicitly requested otherwise.
