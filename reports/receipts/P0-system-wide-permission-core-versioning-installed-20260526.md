---
artifact_id: P0-system-wide-permission-core-versioning-installed-20260526
artifact_type: installation-receipt
owner_role: Registrar / Verifier
source_task: AH-570
run_id: RUN-P0-system-permission-core-versioning-20260526
created_at: 2026-05-26
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# P0 System-Wide Permission And Core Versioning Receipt

## Release

- Release id: `agenthub-core.20260526.1`.
- Source task: AH-570.
- Branch: `agenthub/p0-system-permission-core-versioning`.
- Scope signature: `P0_SYSTEM_PERMISSION_CORE_VERSIONING`.

## Installed Repository Artifacts

- `reports/audits/P0-system-wide-permission-core-versioning-architecture-20260526.md`
- `governance/permission-profiles/agenthub-permission-profile-matrix.md`
- `governance/permission-profiles/agenthub-permission-validator.md`
- `governance/core-versioning/codex-core-version-control-policy.md`
- `schemas/permission-manifest.schema.json`
- `schemas/core-change-receipt.schema.json`
- `runbooks/rollback/agenthub-core-rollback-runbook.md`
- `evals/agenthub-system-permission-core-versioning/fixtures.json`
- `quarantine/README.md`
- `reports/receipts/P0-system-wide-permission-core-versioning-installed-20260526.md`

## Validation

- AGENTS.md, INDEX.md, ARTIFACT_REGISTER.md, and PR_QUEUE_REGISTER.md were read
  before writing.
- Existing parent AH-570 was reused; no duplicate YouTrack parent was created.
- Open PR #51 was checked and kept separate because it covers AH-570 forensic
  recovery/reporting, not this permission/core-versioning scope.
- Register rows were added for this artifact set.
- Static fixtures cover safe auto-allow, T0 mutation denial, permission
  manifest generation, duplicate/loop quarantine, core release lifecycle,
  report-without-register failure, and owner STOP/DANGER halt.

## Runtime Hook Status

The approved install path set was selected and finalized in:

- `reports/receipts/P0-pr52-policy-install-path-decision-20260526.md`
- `reports/receipts/P0-pr52-policy-install-validation-20260526.md`

Runtime policy, hook instructions, validator, and permission-manifest template
were installed under the approved AgentHub orchestration paths. Dry-run
validation passed for T0 direct mutation denial, scoped T2 allow, reporting
gate failure, loop quarantine, and owner STOP handling.

Typed residual: none for PR #52 policy-install path.

## Forbidden Zones

Untouched:

- Docker;
- DB;
- Nginx/NPM/proxy/edge runtime;
- firewall/DNS/SSL;
- VPN/Hiddify/Telegram proxy runtime;
- product repositories;
- client projects;
- secrets/env/cookies/private keys/raw transcripts.

## Secret Redaction

PASS. No secrets, raw env dumps, private keys, tokens, cookies, raw transcript
links, or unrelated logs are included.
