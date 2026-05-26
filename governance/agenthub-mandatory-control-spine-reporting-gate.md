---
artifact_id: agenthub-mandatory-control-spine-reporting-gate
artifact_type: governance-control
owner_role: T0_CONTROL / REGISTRAR
source_task: AH-570
run_id: RUN-P0-20260526-route-recovery
created_at: 2026-05-26
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Mandatory Control-Spine Reporting Gate

## Binding Status

This control applies before any previously issued recovery/runtime/task prompt for the active AH-567/AH-568/AH-569/AH-570 incident family.

If an older prompt allows execution before repository reporting, this control overrides that part.

## Canonical Systems

- YouTrack is the task system.
- GitHub control-spine is the artifact, report, and receipt store.
- AgentHub, Codex, and Linux are execution systems.
- ChatGPT web is a prompt and architecture assistant, not the server agent.
- Canonical artifact repository: `arwoxbx24/agenthub-control-spine`.

## Mandatory Report-First Rule

Before any action beyond reading repository metadata and current task identity, the active agent must create or update a repository journal artifact in control-spine.

Required incident journal path pattern:

- `reports/incidents/P0-agenthub-control-spine-reporting-gate-YYYYMMDD.md`

No successful or failed action may be recorded only in chat, terminal output, local run output, AgentHub run output, or YouTrack. AgentHub run evidence and YouTrack updates must be mirrored or summarized in control-spine.

## Journal Entry Requirements

Each action entry must include:

- timestamp UTC;
- task_id or issue_id;
- RUN_ID if applicable;
- role: T0, T1, T2, VERIFIER, or REGISTRAR;
- action class: READ, ROUTE, DISPATCH, MUTATE, VERIFY, REGISTER, CLOSE, or BLOCK;
- allowed scope;
- forbidden scope check;
- result: SUCCESS, FAIL, BLOCKED, or QUARANTINED;
- evidence artifact path;
- validation result;
- exact typed blocker if any;
- secret redaction statement.

## Forbidden Reporting Surfaces

The following are not sufficient as final reporting surfaces:

- chat-only reports;
- terminal-only reports;
- local-run-only reports;
- YouTrack-only reports;
- AgentHub-only run artifacts without control-spine summary;
- GitHub commit without queue/register state;
- receipt branch without queue state and register coverage or a registrar-owned patch blocker.

## Role Rules

T0 may classify, route, assign, verify, consolidate, and register. T0 must not run code, Linux, Docker, proxy, DB, firewall, product, or runtime mutation.

T1 may repair AgentHub route, hook, validator, config, and governance artifacts within the assigned control-plane scope.

T2 may execute scoped live/runtime work only if explicitly delegated by AgentHub and recorded in the journal first.

Verifier is read-only.

Registrar updates repository artifacts, registers, and queue state.

## Stop Conditions

Stop immediately and do not perform runtime, product, or code action if any of these are true:

- control-spine repository cannot be reached;
- `AGENTS.md` or `INDEX.md` cannot be read;
- repository journal cannot be created or updated;
- current action cannot be classified by role and scope;
- T0 attempts shell, code, Linux, Docker, proxy, DB, firewall, or runtime mutation;
- an agent ignores owner danger or stop messages;
- the same blocker has occurred twice;
- a new task would duplicate an existing active task for the same scope signature.

Allowed terminal blockers:

- `CONTROL_SPINE_REPORTING_ROUTE_REQUIRED`
- `GITHUB_CONTROL_SPINE_AUTH_REQUIRED`
- `CONTROL_SPINE_REGISTER_PATCH_ROUTE_REQUIRED`
- `INSTRUCTION_SOURCE_DRIFT`
- `T0_DIRECT_ACTION_BLOCKED`
- `AGENTHUB_LIVE_WORKER_ROUTE_REQUIRED`
- `SAFETY_QUARANTINE`

Generic blocked states are forbidden.

## Task Consolidation Rule

Do not create a new task unless duplicate check proves no active task exists.

For existing AH incident tasks:

- identify the single active parent incident;
- attach duplicate or zombie tasks to the parent;
- close or supersede duplicates only when evidence and Done/Blocked gates are satisfied;
- keep domain tasks separate from AgentHub-core repair;
- record all changes in the control-spine journal before and after YouTrack updates.

## Required Artifacts For This Incident

Minimum artifacts:

- `reports/incidents/P0-agenthub-control-spine-reporting-gate-YYYYMMDD.md`
- `reports/receipts/P0-control-spine-reporting-gate-YYYYMMDD.md`
- `reports/audits/P0-agenthub-reporting-failure-forensic-YYYYMMDD.md`
- `INDEX.md` update or `CONTROL_SPINE_REGISTER_PATCH_ROUTE_REQUIRED`
- `ARTIFACT_REGISTER.md` update or `CONTROL_SPINE_REGISTER_PATCH_ROUTE_REQUIRED`
- `PR_QUEUE_REGISTER.md` update when a branch or PR exists, or `CONTROL_SPINE_REGISTER_PATCH_ROUTE_REQUIRED`

If register/index patch cannot be safely completed, the incident journal and receipt must still exist in the repository, and final state must be `CONTROL_SPINE_REGISTER_PATCH_ROUTE_REQUIRED`, not a new loop.

## Validation Gates

PASS requires:

1. Repository journal exists in `arwoxbx24/agenthub-control-spine`.
2. Every action in the current incident has a journal entry or is explicitly marked missing with reason.
3. No T0 direct code, Linux, Docker, proxy, DB, firewall, or runtime action occurs after this control is accepted.
4. YouTrack entries point to repository reports; they are not the only report location.
5. AgentHub run artifacts are mirrored or summarized in control-spine.
6. Duplicates or zombie tasks are consolidated or explicitly blocked.
7. No secrets or raw transcript links are stored.
8. Final user answer is short Russian: problem, solution, required owner action only.

## Acceptance States

Allowed final states:

- `DONE_WITH_REPO_EVIDENCE`
- `REPORTING_GATE_INSTALLED`
- `TASKS_CONSOLIDATED_WITH_REPO_EVIDENCE`
- `CONTROL_SPINE_REPORTING_ROUTE_REQUIRED`
- `GITHUB_CONTROL_SPINE_AUTH_REQUIRED`
- `CONTROL_SPINE_REGISTER_PATCH_ROUTE_REQUIRED`
- `T0_DIRECT_ACTION_BLOCKED`
- `AGENTHUB_LIVE_WORKER_ROUTE_REQUIRED`
- `INSTRUCTION_SOURCE_DRIFT`
- `SAFETY_QUARANTINE`

Forbidden final states:

- generic `BLOCKED`;
- Done without repo evidence;
- YouTrack-only Done;
- terminal-only Done;
- local artifact-only Done;
- new task creation as success;
- new report-only loop without installed gate.
