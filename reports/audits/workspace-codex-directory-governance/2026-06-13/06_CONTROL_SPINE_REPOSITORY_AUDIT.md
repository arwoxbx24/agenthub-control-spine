---
artifact_id: workspace-codex-directory-governance-control-spine-audit-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Control-Spine Repository Audit

## Canonical Repo

Canonical repository verified by task contract and GitHub connector: `arwoxbx24/agenthub-control-spine`.
No personal `arwoxb24/*` repo used as canonical for this audit.

## Required Surfaces Observed

- `AGENTS.md`
- `INDEX.md`
- `ARTIFACT_REGISTER.md`
- `PR_QUEUE_REGISTER.md`
- `governance/`
- `schemas/`
- `validators/`
- `evals/`
- `runbooks/`
- `prompts/`
- `reports/`
- `reports/receipts/`
- `reports/validations/`
- `youtrack-workflows/`
- `quarantine/`
- `registries/`

## Register Health

Registers exist. This audit must append or otherwise record audit package paths before closure. Reports remain `audit_only`, `default_load=false`, `safe_to_replay=false`.

## PR Queue Health

No PR merge requested. Audit branch must remain unmerged until owner explicitly authorizes review/merge.

## Stale Prompt Risk

Prompt text used for this audit is `consumed_prompt`, `default_load=false`, `safe_to_replay=false`. It must not become active policy. Next implementation prompt must be generated from audit findings, not replay this audit contract.
