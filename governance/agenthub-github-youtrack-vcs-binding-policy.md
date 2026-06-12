---
artifact_id: agenthub-github-youtrack-vcs-binding-policy
artifact_type: governance-policy
owner_role: T0 Registrar / GitHub-YouTrack Verifier
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub GitHub YouTrack VCS Binding Policy

Code/config tasks must bind YouTrack, GitHub branch, commit, PR, and receipt.

## Requirements

1. Include the issue ID in branch name where practical.
2. Include the issue ID in commit message and PR title or body.
3. Verify YouTrack GitHub/VCS integration when claiming activity-stream binding.
4. Verify repository URL and monitored branch coverage or record exact integration blocker.
5. Plain-text links are not enough for `GITHUB_YOUTRACK_BINDING_PASS` when integration proof is in scope.

If the integration cannot be configured automatically because of admin/token limits, final blocker must be `OWNER_ONLY_GITHUB_YOUTRACK_INTEGRATION_AUTHORITY_REQUIRED` with exact missing permission.
