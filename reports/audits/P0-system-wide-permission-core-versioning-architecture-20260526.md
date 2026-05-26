---
artifact_id: P0-system-wide-permission-core-versioning-architecture-20260526
artifact_type: architecture-audit
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-570
run_id: RUN-P0-system-permission-core-versioning-20260526
created_at: 2026-05-26
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 System-Wide Permission And Core Versioning Architecture

## Scope

This artifact defines the closed-contour AgentHub permission architecture and
core version-control lifecycle requested by the owner on 2026-05-26.

It is AgentHub-core governance only. It does not perform Docker, DB, Nginx,
proxy, firewall, VPN, Hiddify, Telegram proxy, product, client-project, or
runtime mutation.

## Parent Incident

- Parent task: AH-570.
- Control run: RUN-P0-system-permission-core-versioning-20260526.
- Branch: `agenthub/p0-system-permission-core-versioning`.
- Core release id: `agenthub-core.20260526.1`.

AH-570 remains the active AgentHub-core parent. AH-569, AH-536, and AH-554 stay
domain/runtime incidents and are not mixed into this architecture repair.

## Architecture Decision

The owner is correct that AgentHub must stop blocking safe work while preserving
strict control over live runtime operations. The corrected design is:

- safe control-plane actions are auto-allowed when scoped, redacted, and
  task-bound;
- dangerous actions require T2 profile, rollback, scope, validation, and
  receipt;
- missing permission produces one permission manifest, not a task loop;
- repeated blockers trigger quarantine and architecture repair;
- core changes are versioned through allowlisted files and sanitized manifests,
  not raw runtime-folder dumps.

## Installed Artifact Set

- `governance/permission-profiles/agenthub-permission-profile-matrix.md`
- `governance/permission-profiles/agenthub-permission-validator.md`
- `governance/core-versioning/codex-core-version-control-policy.md`
- `schemas/permission-manifest.schema.json`
- `schemas/core-change-receipt.schema.json`
- `runbooks/rollback/agenthub-core-rollback-runbook.md`
- `evals/agenthub-system-permission-core-versioning/fixtures.json`
- `reports/receipts/P0-system-wide-permission-core-versioning-installed-20260526.md`

## Permission Model

The profile matrix creates six durable roles:

- `T0_CONTROL_AUDIT`
- `REGISTRAR_CONTROL_SPINE`
- `T1_ARCHITECT_CONTROL`
- `T2_SCOPED_WORKER`
- `VERIFIER_READONLY`
- `BREAK_GLASS_CONTROLLED`

Safe actions are separated from dangerous actions so routine repo/report/task
work does not wait for live runtime authority. Dangerous operations remain
blocked until a scoped worker profile, rollback, validation, and receipt exist.

## Deadlock Controls

The validator policy requires quarantine when any of these happen:

- same blocker repeats twice without new evidence;
- more than one writer owns the same scope;
- duplicate task or PR is created while one covers the scope;
- T0 attempts shell, code, or runtime mutation;
- report exists without register coverage;
- worker runs without task id, run id, or profile;
- owner STOP/DANGER/BLOCK is ignored;
- sandbox-only proof is used as Done.

## Core Version Lifecycle

Core releases use `agenthub-core.YYYYMMDD.N`. This release is
`agenthub-core.20260526.1`.

The policy forbids raw `/root/.codex`, cache, transcript, env, token, and
runtime dumps. Core state is represented by allowlisted policy/schema/runbook
files and redacted hash/path-class manifests for non-committable surfaces.

## Validation Summary

Static validation fixtures cover:

- T0 shell/code attempt -> blocked;
- safe repo receipt -> allowed;
- missing permission -> manifest;
- repeated blocker -> quarantine;
- core change -> branch/checkpoint/rollback receipt;
- report without register -> not Done;
- owner STOP/DANGER -> mutation halt.

This pass installs repository policy and test fixtures. Runtime hook activation
still requires the approved AgentHub policy install path.

## Residual

`AGENTHUB_POLICY_INSTALL_PATH_REQUIRED`: the control-spine architecture is
installed in a scoped branch, but no runtime hook installation surface was
mutated by T0 in this pass.

## Secret Redaction

No secrets, private keys, tokens, raw env dumps, unredacted cookies, raw
transcript links, or unrelated logs are included.
