---
artifact_id: workspace-codex-directory-governance-scope-method-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Scope And Method

## Classification

Prompt classification: `new_contract`.
Prompt Quality Score: 91/100. Meets threshold because task class, scope, branch, forbidden zones, outputs, validation, and terminal rules are explicit.

## Source Hierarchy

1. Active system/developer instructions.
2. Root and runtime AGENTS policy.
3. AgentHub master/project artifacts when available.
4. Canonical repository and YouTrack state.
5. Official vendor docs.

## Official Docs Packet

Verified 2026-06-13:

- OpenAI Codex sandboxing: `https://developers.openai.com/codex/concepts/sandboxing`
- OpenAI Codex approvals/security: `https://developers.openai.com/codex/agent-approvals-security`
- OpenAI Codex skills: `https://developers.openai.com/codex/skills`
- OpenAI Codex rules: `https://developers.openai.com/codex/rules`
- YouTrack workflow rules: `https://www.jetbrains.com/help/youtrack/server/workflow-rules.html`
- YouTrack state-machine rules: `https://www.jetbrains.com/help/youtrack/devportal/state-machine-per-issue-type.html`
- GitHub branch protection: `https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule`
- GitHub CODEOWNERS: `https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners`

## Method

- Bounded `find` metadata only.
- No secret file content.
- No env dump.
- No DB/proxy/Docker/firewall mutation.
- No product repair.
- No deletion.
- Reports written only to audit branch.

## Inventory Limits

Heavy trees are summarized by max-depth, timestamps, and classifications. `.git/objects`, `node_modules`, logs, sessions, DB-like paths, and secret-risk folders are not exhaustively listed.
