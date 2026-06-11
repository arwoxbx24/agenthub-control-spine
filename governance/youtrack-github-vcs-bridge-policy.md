---
artifact_id: youtrack-github-vcs-bridge-policy-20260611
artifact_type: governance_policy
source_task: AH-743
run_id: RUN-AGENTHUB-YOUTRACK-GITHUB-BOARD-FINAL-CLOSURE-20260611
status: active
---

# YouTrack GitHub VCS Bridge Policy

## Purpose

AgentHub tasks must carry GitHub/VCS evidence inside the controlling YouTrack issue. Official YouTrack GitHub/VCS integration is preferred. Custom adapters are allowed only when the official mechanism is unavailable, insufficient, and an ADR approves the gap.

## Required Check

Before final closure, the worker must record whether YouTrack has an official VCS integration for the repository and project. The bridge receipt must include:

- repository URL and YouTrack project mapping;
- webhook or import state;
- monitored branches, including the task branch when possible;
- branch-name issue reference support;
- processing scheme for commit attachment and optional commands;
- committer group and user matching status when commands are expected;
- import commits/open pull requests action when enabled;
- evidence that commits or PRs are visible in the issue, or an owner-only gate reason.

## Manual Metadata Fallback

When owner credentials or admin permissions block official integration configuration, the task may still record manual GitHub metadata in YouTrack, but final closure must preserve the blocker as `OWNER_ONLY_GITHUB_YOUTRACK_TOKEN_GATE`, `YOUTRACK_VCS_INTEGRATION_PERMISSION_MISSING`, or `GITHUB_REPOSITORY_ADMIN_PERMISSION_MISSING` unless official visibility is proven.

## Required Issue Metadata

Each controlling issue must contain repository, branch, PR number or URL, head SHA, merge SHA when available, commit list or latest commit SHA, receipt path, validation path, RUN_ID, agent role, and Done gate text.

## Forbidden Shortcuts

- Do not use PR merged state as task Done.
- Do not create duplicate issues for VCS blockers.
- Do not put tokens, OAuth secrets, cookies, env dumps, or raw internal links into issue comments, GitHub artifacts, or receipts.
