---
artifact_id: workspace-codex-directory-governance-inventory-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Directory Inventory

| Path | Classification | Owner system | Purpose | Lifecycle | Mutation authority | Evidence | Confidence |
|---|---|---|---|---|---|---|---|
| `@workspace/projects/agenthub-control-spine` | ACTIVE_SOURCE_CONTROL | AgentHub/control-spine | Canonical governance repo | active | scoped branch/PR only | GitHub + local bounded listing | high |
| `@workspace/projects/3x-ui` | CLIENT_PRODUCT_REPO | unknown/product | Service/application project | active/unknown | project task only | bounded listing | medium |
| `@workspace/projects/arwox-biz` | CLIENT_PRODUCT_REPO + SECRET_RISK_SURFACE | business/project | Contains business folders and `secrets` directory | active/unknown | project task only | bounded listing | medium |
| `@workspace/projects/backups` | WORKSPACE_PROJECT_ARCHIVED | workspace | Backup area inside project root | archive | restore-only | bounded listing | high |
| `@workspace/projects/bitrix*` | CLIENT_PRODUCT_REPO | product | Bitrix-related projects | active/unknown | task-specific only | bounded listing | medium |
| `@workspace/projects/client-video-transcription` | CLIENT_PRODUCT_REPO | client/product | Client app repo with reports/logs/admin | active | project task only | bounded listing | medium |
| `@workspace/projects/data` | SECRET_RISK_SURFACE | unknown | DB-like/state files including `AppSettings.db`, `wal` | state/unknown | DB gate required | bounded names only | high |
| `@workspace/projects/failover-agents` | SECRET_RISK_SURFACE | unknown | agent config/research with `secrets` dir | unknown | owner/project gate | bounded listing | medium |
| `@runtime-root/skills` | CODEX_RULES_OR_SKILLS | Codex | Local skill instructions | active config | skill governance route | bounded listing | high |
| `@runtime-root/plugins` | CODEX_RULES_OR_SKILLS | Codex/plugin system | Plugin cache and local plugin bundles | active/cache mixed | plugin intake route | bounded listing | high |
| `@runtime-root/rules` | CODEX_STABLE_CONFIG | Codex | Runtime rules | active config | runtime governance route | bounded listing | medium |
| `@runtime-root/sessions` | SECRET_RISK_SURFACE | Codex | Session history | volatile/private | never expose raw | bounded listing only | high |
| `@runtime-root/log` | SECRET_RISK_SURFACE | Codex | Logs | volatile/private | no raw dump | bounded listing only | high |
| `@runtime-root/runtime-state` | AGENTHUB_RUNTIME_STATE | AgentHub/Codex | hardlock and hook receipts | operational state | AgentHub runtime route | bounded listing | high |
| `@runtime-root/orchestration` | CODEX_STABLE_CONFIG + AGENTHUB_RUNTIME_STATE | AgentHub | Runtime scripts/templates/hooks/schemas/state | active/runtime mixed | runtime governance route | bounded listing | high |
| `@agenthub-state/runs` | AGENTHUB_RUN_OUTPUT | AgentHub | Run outputs, receipts, sandboxes | operational/transient | AgentHub lifecycle only | bounded listing | high |
| `@agenthub-state/runs-archive` | OPERATIONAL_RECEIPT | AgentHub | Archived run outputs | archive | archive policy only | bounded listing | high |
| `@agenthub-state/project-clutter-quarantine` | QUARANTINE_CANDIDATE | AgentHub | Prior clutter quarantine | quarantine | governance route | bounded listing | high |
| `@control-spine/reports/audits/workspace-codex-directory-governance/2026-06-13` | AUDIT_REPORT | control-spine | This audit package | audit_only | audit branch only | branch file readback | high |

## Observed Pattern

Workspace root mixes active code, client code, runtime/state-like folders, archive/backup names, and secret-risk names. Governance must separate final artifacts, runtime outputs, restore-only backups, and client projects by policy and write guard.
