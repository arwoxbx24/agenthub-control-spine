---
artifact_id: pr52-policy-install-control
artifact_type: active-policy-install-control
owner_role: T1 Architect / T2 Policy Installer
source_task: AH-570
run_id: RUN-P0-system-permission-core-versioning-20260526
created_at: 2026-05-26
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# PR #52 AgentHub Policy Install Control

## Purpose

This control finalizes PR #52 by mapping repository policy to approved
AgentHub runtime policy, hook, validator, and template paths.

## Runtime Install Contract

Install exactly:

- policy profile data under `/root/.codex/orchestration/policies/agenthub/`;
- pre-tool hook instructions under `/root/.codex/orchestration/hooks/`;
- dry-run validator under `/root/.codex/orchestration/validators/`;
- permission manifest template under `/root/.codex/orchestration/templates/`.

Do not touch Docker, DB, Nginx/NPM, proxy, firewall, service runtime, VPN,
Hiddify, product repos, or client projects.

## Enforcement Outcomes

- T0 direct shell/code/runtime mutation -> `DENY_T0_DIRECT_MUTATION`.
- Scoped safe control/report/register action -> `ALLOW_SAFE_CONTROL_ACTION`.
- Scoped T2 worker action with rollback and validation -> `ALLOW_T2_SCOPED_ACTION`.
- Missing receipt/register evidence -> `BLOCK_CONTROL_SPINE_REPORTING_GATE`.
- Same blocker repeated twice -> `CONTROL_LOOP_QUARANTINE`.
- Owner STOP/DANGER/BLOCK before mutation -> `CONTROL_LOOP_QUARANTINE`.

## Done Gate

PR #52 can be treated as ready after:

- runtime files are installed at approved paths;
- dry-run validation cases pass;
- local and GitHub secret scans pass;
- `INDEX.md`, `ARTIFACT_REGISTER.md`, and `PR_QUEUE_REGISTER.md` include this
  install-path decision and validation receipt.
