---
artifact_id: workspace-codex-directory-governance-testing-model-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Testing And User Outcome Coverage Model

## Evidence Hierarchy

1. Browser/user-outcome proof: authenticated path, visible user goal completed, screenshot/session proof when UI in scope.
2. API proof: endpoint contract and auth/error behavior.
3. Service proof: process health, logs, healthcheck, dependency connectivity.
4. Process/socket proof: port/listener/process only.
5. Static/code proof: diff, schema, lint, validator, fixture.

## Rule

Low-level checks support claims but never replace user-outcome proof when user-facing service is in scope.

## Claim Ledger Requirement

Every user-facing claim must map to:

- claim text;
- required evidence class;
- actual evidence;
- verdict: verified, partial, unverified, contradicted, excluded.

Claims without evidence must be removed from final owner report.

## Test Language Ban

Ban vague claims:

- many tests passed;
- service seems working;
- everything fixed;
- curl green means product done;
- screenshot means backend done.

Use exact evidence path and scope.
