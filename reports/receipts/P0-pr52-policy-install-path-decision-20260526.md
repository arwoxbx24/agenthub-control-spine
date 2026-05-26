---
artifact_id: P0-pr52-policy-install-path-decision-20260526
artifact_type: install-path-decision-receipt
owner_role: T1 Architect / T2 Policy Installer / Registrar
source_task: AH-570
run_id: RUN-P0-system-permission-core-versioning-20260526
created_at: 2026-05-26
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# PR #52 Policy Install Path Decision

## Decision

The approved install path set is available and sufficient. The prior
`AGENTHUB_POLICY_INSTALL_PATH_REQUIRED` residual is replaced by concrete
install paths from the owner-authorized set.

## Selected Runtime Paths

- `/root/.codex/orchestration/policies/agenthub/agenthub-permission-profile-matrix.json`
- `/root/.codex/orchestration/hooks/agenthub-pre-tool-permission-gate.md`
- `/root/.codex/orchestration/validators/agenthub_permission_gate.rb`
- `/root/.codex/orchestration/templates/permission-manifest.template.json`

The existing runtime directory `/root/.codex/orchestration/templates/` exists.
The policy, hook, and validator directories are narrow approved directories and
may be created for this incident.

## Selected Control-Spine Paths

- `governance/policies/agenthub/pr52-policy-install-control.md`
- `reports/receipts/P0-pr52-policy-install-path-decision-20260526.md`
- `reports/receipts/P0-pr52-policy-install-validation-20260526.md`
- `INDEX.md`
- `ARTIFACT_REGISTER.md`
- `PR_QUEUE_REGISTER.md`

## Rollback Metadata

Before runtime/core writes, this receipt records the intended runtime surfaces.
Rollback is removal of the four selected runtime files and, if empty, the
narrow created directories under `policies/agenthub`, `hooks`, and `validators`.
No broad runtime tree snapshot is taken and no raw runtime folder is committed.

## Forbidden Scope Check

Not touched:

- Docker;
- DB;
- Nginx/NPM/proxy/edge runtime;
- firewall/DNS/SSL;
- VPN/Hiddify/Telegram proxy runtime;
- product repositories;
- client projects;
- secrets/env/cookies/private keys/raw transcripts.

## Secret Redaction

PASS. This receipt contains no secrets, raw env dumps, private keys, tokens,
cookies, raw internal transcript links, or unrelated logs.
