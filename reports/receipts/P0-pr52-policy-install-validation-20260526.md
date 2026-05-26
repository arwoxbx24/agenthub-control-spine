---
artifact_id: P0-pr52-policy-install-validation-20260526
artifact_type: validation-receipt
owner_role: T2 Policy Installer / Verifier / Registrar
source_task: AH-570
run_id: RUN-P0-system-permission-core-versioning-20260526
created_at: 2026-05-26
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# PR #52 Policy Install Validation

## Installed Runtime Paths

- `/root/.codex/orchestration/policies/agenthub/agenthub-permission-profile-matrix.json`
- `/root/.codex/orchestration/hooks/agenthub-pre-tool-permission-gate.md`
- `/root/.codex/orchestration/validators/agenthub_permission_gate.rb`
- `/root/.codex/orchestration/templates/permission-manifest.template.json`

## Dry-Run Validation Matrix

| Case | Expected | Result |
|---|---|---|
| T0 attempts direct shell/runtime mutation | `DENY_T0_DIRECT_MUTATION` | PASS |
| Scoped T2 worker has exact scope, rollback, validation, receipt, and register | `ALLOW_T2_SCOPED_ACTION` | PASS |
| Action lacks control-spine receipt/register | `BLOCK_CONTROL_SPINE_REPORTING_GATE` | PASS |
| Same blocker repeats twice | `CONTROL_LOOP_QUARANTINE` | PASS |
| Owner STOP before mutation | `CONTROL_LOOP_QUARANTINE` | PASS |

## Runtime File Checks

- Runtime policy JSON parsed successfully.
- Permission manifest template JSON parsed successfully.
- Runtime validator Ruby syntax check passed.
- New runtime install directories/files were scanned with redacted secret scanning
  and returned no leaks.

An unrelated broad scan of the whole `/root/.codex/orchestration` tree found
pre-existing out-of-scope findings. That broad tree is not part of this PR #52
install package and was not printed or committed. The scoped newly installed
files passed.

## Repository Checks

- `git diff --check`: PASS.
- JSON schemas and eval fixtures: PASS.
- Repository gitleaks redacted scan: PASS.
- GitHub secret-scan for PR #52 head before this receipt: PASS.

## Queue State

PR #52 is ready for merge from the policy-install perspective after this
receipt and register patch.

## Secret Redaction

PASS. No secrets, raw env dumps, private keys, tokens, cookies, raw internal
transcript links, or unrelated logs are included.
