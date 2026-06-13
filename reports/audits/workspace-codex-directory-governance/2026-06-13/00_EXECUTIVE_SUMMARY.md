---
artifact_id: workspace-codex-directory-governance-summary-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Executive Summary

This audit documents AgentHub/Codex/workspace/control-spine directory governance. It does not implement runtime or product repairs.

## Controlled

- Canonical control-spine repository exists at `arwoxbx24/agenthub-control-spine`.
- YouTrack task `AH-786` binds the audit.
- Audit branch exists: `audit/workspace-codex-directory-governance-20260613`.
- AgentHub MCP run exists: `global-workspace-codex-dir-audit-20260613`.
- Prior Done gate hardlock task `AH-785` is closed with evidence markers.

## Chaotic

- Workspace contains active projects, archived projects, runtime outputs, caches, DB-like directories, generated run folders, and unknown owner directories in the same top-level area.
- AgentHub run roots show repeated retry/final/patch naming patterns.
- `.codex` contains stable config, skills, plugins, runtime-state, sessions, logs, caches, generated images, and recovery folders in one broad tree.
- Some local shell gates block direct inspection, forcing MCP/safe-find/explorer fallback.

## Top Risks

1. Uncontrolled top-level project folders.
2. Runtime run-output growth.
3. Secret-risk directories under workspace projects.
4. Prompt/report artifacts reused as active instruction.
5. Fake Done by semantic claim instead of parser evidence.
6. Blind retry loops after gate errors.
7. User-interrupt blocker messages for routine PackFix work.
8. Git/local branch drift between local workspace and GitHub branch.
9. Low-level test claims presented as user-outcome proof.
10. Missing dry-run/explain endpoint for Done gates.

## Next Fixes

Install directory governance policy, write-location guard, temp-folder blocker, Done-gate dry-run, explain-gate endpoint, evidence ledger, browser-first testing contract, and no-blind-retry hook.
