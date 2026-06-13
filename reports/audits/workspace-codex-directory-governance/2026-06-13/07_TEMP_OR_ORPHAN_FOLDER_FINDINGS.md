---
artifact_id: workspace-codex-directory-governance-temp-orphan-findings-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Temp Or Orphan Folder Findings

No deletion performed.

| Candidate | Why risky | Known purpose | Later action |
|---|---|---|---|
| `@runtime-root/.tmp` | transient data near stable config | plugin/runtime staging | classify, TTL, quarantine policy |
| `@runtime-root/tmp` | transient arguments/output | runtime temp | TTL policy |
| `@runtime-root/plugins/.remote-plugin-install-staging` | installer staging | plugin install | manifest/SHA gate |
| `@runtime-root/recovery-hook-kill-*` | recovery output in runtime root | prior recovery | register or quarantine |
| `@workspace/projects/backups` | backup area inside canonical project root | restore-only | move under archive policy later |
| `@workspace/projects/*/.tmp` | temp under client/project roots | varied | block final artifacts there |
| `@workspace/projects/*/__pycache__` | generated cache | Python cache | ignore/cleanup policy later |
| `@agenthub-state/runs/*retry*` | repeated route attempts | PackFix/retry evidence | lifecycle ledger |
| `@agenthub-state/runs/*final*` | final-like naming may fake closure | run evidence | require Done tuple |
| `@agenthub-state/project-clutter-quarantine` | quarantine already exists | old clutter cleanup | keep registered |

## Required Remediation

Install directory classifier and write-location guard before any cleanup. Cleanup without classification risks deleting evidence, state, or client data.
