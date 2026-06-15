---
artifact_id: agenthub-four-prompt-architecture-hardlock-policy
artifact_type: governance-policy
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-796
run_id: four-prompt-architecture-hardlock-20260615
created_at: 2026-06-15
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
supersedes: none
superseded_by: none
---

# AgentHub Four Prompt Architecture Hardlock Policy

## Purpose

This policy installs the four owner-provided architect prompts as one durable
AgentHub/Codex governance package. The prompts are source data, not local notes,
and must not be closed by creating a priority index or chat report.

Source prompt order:

1. Prod incident recovery and test-first hardlock: primary architecture.
2. Test-first production deploy lock: supplement.
3. Owner-distress production recovery control: supplement.
4. PR171/gitleaks merge-gate closure: point-fix gate.

This package is limited to `arwoxbx24/agenthub-control-spine` governance
artifacts. It does not authorize product repository changes, production/test
site actions, workflow dispatch, database access, Docker, proxy, firewall, DNS,
SSL, PM2, tmux, secrets, broad cleanup, branch-protection weakening, or bypass of
AgentHub gates.

## Required Contour

The only accepted execution flow is:

capture -> classify -> bind task/run -> route AgentHub worker -> prove
environment -> audit workflow impact -> act only in allowed scope -> validate ->
receipt -> register -> task readback -> final.

During an active contour, owner-facing progress/status output is blocked unless
there is an `OWNER_ONLY_PLATFORM_GATE` or `SAFETY_QUARANTINE`.

## Environment and Route Proof

Every action must carry `environment_route_proof` before mutation:

- task id and RUN id;
- canonical repo and branch;
- target environment classification;
- proof that product `main`/`master` is not used for test work;
- proof that local prompt-folder notes are not implementation evidence;
- proof that the action is AgentHub-routed and not direct shell bypass.

Product `main`/`master`, production-linked workflow, unknown workflow effect,
unknown remote, public/client domain, or ambiguous deploy route is
`PROD_RISK_UNKNOWN` until proven otherwise.

## Workflow Impact Audit

Before workflow run/watch/dispatch, merge, or closure that depends on workflow
state, the worker must audit:

- workflow file;
- triggers;
- target environments;
- deploy jobs;
- secrets and env names;
- branch conditions;
- remote targets;
- reusable workflows;
- branch protection and protected environment reviewers.

Workflow action without this audit is blocked. A workflow name containing
`test` is not proof.

## Owner Incident and Recovery Lane

Owner phrases such as `site broken`, `production broken`, `client screaming`,
`сайт сломан`, `прод сломан`, `караул`, and equivalents are incident signals.
The agent must start the safe recovery lane instead of apology loops, stop-only
chat, or owner handoff for routine technical steps.

Safe recovery requires task/RUN binding, read-only state capture, blast-radius
classification, environment proof, last-known-change ledger, safe recovery
option, receipt, and browser/user outcome validation when applicable.

Rollback requires last-known-good evidence, checkpoint, reversibility, and a
pre-registered scoped route. Feature fixes on production are blocked.

## PR171/Gitleaks Point-Fix Gate

PR171/AH-794 style closure is a named point-fix gate. It requires PR state,
branch state, gitleaks/security proof, task readback, register coverage, and no
same-scope open tail.

Repeated merge attempts with the same branch-protection/check failure are token
burn, not progress. After the second identical platform response, stop with
`GITHUB_BRANCH_PROTECTION_PLATFORM_GATE`.

## Done Gate

Done requires all gates:

- `TASK_BINDING_GATE`
- `RUN_ID_GATE`
- `AGENTHUB_ROUTE_GATE`
- `SOURCE_PROMPT_CONSUMPTION_GATE`
- `INSTALLED_CONTROL_GATE`
- `NO_PRODUCT_TOUCH_GATE`
- `VALIDATOR_FIXTURE_GATE`
- `REGISTER_COVERAGE_GATE`
- `PR_QUEUE_GATE`
- `MAIN_READBACK_GATE`
- `YOUTRACK_DONE_GATE`

Rejected Done evidence:

- local prompt-folder index;
- chat report;
- PR existence or merge alone;
- workflow success alone;
- sandbox-only proof;
- blocked runtime command;
- owner shell handoff;
- repeated blocked command retry.

## Typed Blockers

Allowed terminal blockers:

- `AGENTHUB_ROUTE_MISSING`
- `CONTROL_SPINE_WRITE_ROUTE_MISSING`
- `GITHUB_BRANCH_PROTECTION_PLATFORM_GATE`
- `YOUTRACK_READBACK_UNAVAILABLE`
- `REGISTER_UPDATE_UNAVAILABLE`
- `OWNER_ONLY_PLATFORM_GATE`
- `SAFETY_QUARANTINE`

