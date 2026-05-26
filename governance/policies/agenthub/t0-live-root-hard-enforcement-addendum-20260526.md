---
artifact_id: t0-live-root-hard-enforcement-addendum-20260526
artifact_type: active_policy
owner_role: T1 Architect / T2 Policy Installer / Registrar
source_task: AH-554
run_id: RUN-P0-T0-LIVE-ROOT-HARD-ENFORCEMENT-20260526
created_at: 2026-05-26
lifecycle: active_policy
default_load: false
safe_to_replay: false
supersedes: none
---

# P0 AgentHub T0 Live-Root Hard Enforcement Addendum

## Decision

The live-route restore contract is approved only with installed runtime enforcement. The defect is not wording-only. It is an enforcement defect: T0/TeamLead must not be able to reach shell, command workers, Docker, NPM, DB, firewall, proxy, PM2, runtime, product files, or client projects.

## Scope

Source task: AH-554, related to AH-570 AgentHub-core controls and AH-572 live-route audit blocker.

This policy does not authorize domain-service repair, Docker repair, NPM repair, DB access, firewall work, product code edits, or broad runtime diagnostics.

## Mandatory Role Metadata

Every AgentHub action that can mutate state must carry:

- actor_role
- worker_role
- RUN_ID
- task_id
- authority_profile
- scope_signature
- allowed_surfaces
- forbidden_surfaces
- evidence_path
- receipt_path

Missing role metadata or missing authority profile must deny before tool execution with `ROLE_AUTHORITY_MISSING`.

## T0 Pre-Tool Deny

When `actor_role=T0_CONTROL`, the following action classes must be denied before execution:

- SHELL
- COMMAND
- CODE_EDIT
- FILESYSTEM_WRITE outside repo artifact scope
- DOCKER
- DOCKER_COMPOSE
- SYSTEMD
- NPM_PROXY_MANAGER
- DB
- FIREWALL
- PROXY
- APP_RUNTIME
- PM2
- SSH
- SECRET_READ

Deny code: `BLOCKED_T0_DIRECT_AUTHORSHIP`.

## Command Adapter Gate

`adapter=command` is allowed only when all conditions are true:

- worker_role is `T2_WORKER` or `T2_LIVE_WORKER`;
- Lifecycle Controller issued scoped authority for this RUN_ID;
- scope_signature matches task_id;
- rollback, evidence, and receipt paths exist;
- forbidden surface list is non-empty;
- timeout and token budget are bounded;
- no duplicate active writer exists on the same surface.

Otherwise deny with `COMMAND_ADAPTER_REQUIRES_SCOPED_T2_AUTHORITY`.

## Owner Interrupt Gate

Owner danger/stop/control-boundary messages must interrupt non-read-only execution immediately. After the interrupt, only read/classify/route/register/verify actions may run until a new T0 route decision is recorded.

## Same-Gate Loop Limit

The same blocker may appear at most twice for the same RUN_ID and scope_signature. A third retry must be denied with `SAME_GATE_LOOP_BLOCKED` and routed to architecture repair or one typed blocker.

## Stale Instruction Replay Gate

Reports, receipts, old prompts, and handoffs are evidence only unless the artifact register marks them active source/policy/schema/current context. Attempting to load an audit-only report as an active instruction must deny with `STALE_REPORT_REPLAY_BLOCKED`.

## Required Negative Tests

1. T0 attempts shell: `BLOCKED_T0_DIRECT_AUTHORSHIP`.
2. T0 attempts Docker: `BLOCKED_T0_DIRECT_AUTHORSHIP`.
3. T0 attempts code edit: `BLOCKED_T0_DIRECT_AUTHORSHIP`.
4. T0 attempts command adapter without scoped T2 authority: `COMMAND_ADAPTER_REQUIRES_SCOPED_T2_AUTHORITY`.
5. T2 policy installer updates allowed policy file with receipt: PASS.
6. T2 live worker read-only triage with scoped authority: PASS.
7. T2 attempts destructive cleanup: `BLOCKED_DESTRUCTIVE_ACTION`.
8. Missing role metadata: `ROLE_AUTHORITY_MISSING`.
9. Audit-only report replay: `STALE_REPORT_REPLAY_BLOCKED`.
10. Third same-gate retry: `SAME_GATE_LOOP_BLOCKED`.

## Current Platform Gate

The repository policy package can be recorded safely. Runtime/core install or patching must not be performed by T0. If the Lifecycle Controller cannot grant T2_POLICY_INSTALLER authority for the approved AgentHub policy/hook/validator paths, the final state is `READY_BLOCKED_BY_PLATFORM_GATE`, not Done.
