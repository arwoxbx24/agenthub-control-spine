---
artifact_id: workspace-codex-directory-governance-coverage-20260613
artifact_type: registry_coverage
source_task: AH-787
run_id: workspace-codex-directory-governance-implementation-20260613
lifecycle: active_control_coverage
default_load: false
safe_to_replay: false
---

# Workspace Codex Directory Governance Coverage

| Path | Coverage |
|---|---|
| `governance/workspace-codex-directory-governance-policy.md` | directory governance, agent cycle, PackFix, testing, claim ledger, interaction protocol |
| `registries/workspace-codex-directory-map-20260613.json` | machine-readable directory map |
| `schemas/workspace_directory_governance.schema.json` | directory map schema |
| `schemas/artifact_lifecycle_hardlock.schema.json` | artifact lifecycle/default_load/safe_to_replay schema |
| `validators/workspace_directory_governance_validator.rb` | deterministic fixture validator |
| `evals/workspace-directory-governance/fixtures.json` | allow/deny, Done, PackFix, blind retry, claim ledger fixtures |
| `templates/hooks/workspace-directory-write-gate-spec.md` | pre-write hook/gate spec |
| `prompts/templates/workspace-directory-governance-worker-template.txt` | worker prompt template |
| `reports/validations/AH-787-workspace-directory-governance-validation-20260613.md` | validation report |
| `reports/receipts/AH-787-workspace-directory-governance-implementation-receipt-20260613.md` | implementation receipt |

## Queue Decision

Implementation branch: `agenthub/workspace-codex-directory-governance-implementation-20260613`.
Current refresh branch is based on main after PR #168/#169/#170 merges.
