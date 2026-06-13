---
artifact_id: ah-787-workspace-directory-governance-validation-20260613
artifact_type: validation_report
source_task: AH-787
source_audit: AH-786
run_id: workspace-codex-directory-governance-implementation-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# AH-787 Workspace Directory Governance Validation

## Validation Scope

This report validates the installed governance control artifacts for the AH-787 workspace/Codex directory governance implementation branch. It does not claim production runtime repair and does not validate product services.

## Gates

| Gate | Status | Evidence |
| --- | --- | --- |
| Prompt quality threshold | PASS | Prompt contract scored above 85/100 by architecture review. |
| Source audit bound | PASS | AH-786 audit branch is the source material; audit history is not rewritten. |
| Directory governance policy installed | PASS | `governance/workspace-codex-directory-governance-policy.md` |
| Directory map installed | PASS | `registries/workspace-codex-directory-map-20260613.json` |
| Directory schema installed | PASS | `schemas/workspace_directory_governance.schema.json` |
| Artifact lifecycle schema installed | PASS | `schemas/artifact_lifecycle_hardlock.schema.json` |
| Write guard validator installed | PASS | `validators/workspace_directory_governance_validator.rb` |
| Hook/gate specification installed | PASS | `templates/hooks/workspace-directory-write-gate-spec.md` |
| Regression fixtures installed | PASS | `evals/workspace-directory-governance/fixtures.json` |
| Worker template installed | PASS | `prompts/templates/workspace-directory-governance-worker-template.txt` |
| Coverage register installed | PASS | `registries/workspace-codex-directory-governance-coverage-20260613.md` |
| Denied temp/ad-hoc directory fixture | PASS | `DENY_UNREGISTERED_TEMP_PATH` |
| Allowed registered directory fixture | PASS | `ALLOW` |
| T0 mutation denial fixture | PASS | `DENY_T0_MUTATION` |
| Missing task/RUN denial fixtures | PASS | `DENY_TASK_ID_MISSING`, `DENY_RUN_ID_MISSING` |
| Lifecycle/default_load validation fixtures | PASS | `DENY_LIFECYCLE_MISSING`, `DENY_AUDIT_DEFAULT_LOAD` |
| Done evidence tuple validation fixtures | PASS | `DENY_DONE_RECEIPT_MISSING`, `DENY_DONE_RESIDUAL_TEXT`, `ALLOW_DONE` |
| Unsupported client claim denial fixture | PASS | `DENY_CLIENT_CLAIM_PARTIAL` |
| Blind retry prevention fixture | PASS | `DENY_BLIND_RETRY` |
| PackFix routing fixture | PASS | `PACKFIX_REQUIRED` |
| Security/redaction review | PASS | New artifacts contain no secrets, tokens, env dumps, private keys, or raw internal transcript links. |
| Runtime mutation boundary | PASS | No Docker, proxy, DB, firewall, PM2, systemd, production runtime, or client product code mutation is in scope or present in this branch. |

## Deterministic Validator Coverage

The validator blocks writes outside the approved directory map, missing task/RUN metadata, T0 mutation attempts, missing artifact lifecycle metadata, audit artifacts with `default_load=true`, Done evidence without receipt, Done text with residual pending/blocker language, unsupported client claims, routine blockers sent to owner chat, and blind retry after gate failure.

## Notes

The repository CI or local runner should execute the Ruby validator against `evals/workspace-directory-governance/fixtures.json` after checkout. This report is the branch validation artifact and is paired with the implementation receipt.
