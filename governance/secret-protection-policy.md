---
artifact_id: secret-protection-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-500
created_at: 2026-05-22
supersedes: none
status: active
---

# Secret Protection Policy

## Purpose

Prevent secret values from entering AgentHub-managed repositories, prompts, reports, receipts, task cards, handoffs, logs, and user-facing chat.

GitHub is an artifact spine and repository protection surface. YouTrack remains the task system. GitHub commits alone do not prove task Done.

## Rules

- Never commit secret values, private keys, passwords, tokens, `.env` files, raw scanner matches, raw logs with credentials, or transcript/history links.
- Commit only placeholder files such as `.env.example`.
- Store runtime credentials in GitHub Actions secrets, environment variables, vault/secret manager, or an approved runtime secret store.
- Prefer short-lived credentials and OIDC-based trust where the provider supports it.
- Treat any exposed real credential as compromised until it is rotated or revoked by the service owner.
- Reports may store only redacted metadata: repository, branch/ref, commit SHA, path, detector/rule id, risk, confidence, and redacted fingerprint.
- A bypass is allowed only with explicit approver, exact reason, expiry, and audit note. Bypasses must not reveal the secret value.

## Required Gates

1. Local staged-file scan before commit.
2. Local pre-push scan before first or repeated pushes.
3. GitHub-native secret scanning and push protection where plan/license permits.
4. Pull request or protected-branch secret-scan workflow where native protection is unavailable.
5. Existing-history audit for current repositories.
6. Redacted receipt before Done.

## Failure Handling

If a scanner finds a candidate secret:

- block commit, push, or merge where the gate is enforceable;
- emit a typed blocker with redacted metadata only;
- create or link one bounded incident task for review/rotation;
- do not mark cleanup complete until confirmed active credentials have rotation/revocation evidence.

## Current Typed Blockers

- `BLOCKER_GITHUB_AUTH_MISSING`
- `BLOCKER_ORG_ACCESS_MISSING`
- `BLOCKER_GITHUB_ADMIN_PERMISSION_MISSING`
- `BLOCKER_GITHUB_SECRET_PROTECTION_UNAVAILABLE`
- `BLOCKER_RULESET_PERMISSION_MISSING`
- `BLOCKER_SCANNER_INSTALL_UNAVAILABLE`
- `BLOCKER_REPO_TOO_LARGE_FOR_CURRENT_RUN`
- `BLOCKER_CONFIRMED_SECRET_ROTATION_REQUIRED`
- `BLOCKER_PERSONAL_OWNER_NOT_AUTHORIZED`

## Official Source Anchors

- GitHub secret scanning and push protection: https://docs.github.com/en/code-security/secret-scanning
- GitHub rulesets: https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets
- GitHub branch protection: https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches
- GitHub Actions encrypted secrets: https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions
- GitHub Actions OIDC hardening: https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/about-security-hardening-with-openid-connect
