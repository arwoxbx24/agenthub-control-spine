# AgentHub Self-Healing Blocker Removal Plan 2026-06-10

## Scope

Canonical repo: `arwoxbx24/agenthub-control-spine`.
Repair branch: `agenthub/self-healing-blocker-removal-20260610`.
Task binding: `AH-731`.

This plan follows audit PR #150 and does not replace PR #149. PR #149 remains the only branch-hygiene cleanup contour.

## Inputs read

Audit artifacts from branch `agenthub/deep-blocker-audit-20260610` were produced and read back before this repair branch was created.

## Repair queue

1. Verify active `github_delete_branch_ref` route.
2. Verify PR #149 open branch protection.
3. Verify safe-stale dry-run path.
4. If route works, execute PR #149 safe-delete plan.
5. If route still fails, write exact residual and stop branch deletion.
6. Keep critical gates: secrets, main, protected branches, fresh branches, open PR branches, SHA drift, canonical repo, task readback.

## Result of live route checks

- PR #149 branch dry-run returned `PROTECTED_BRANCH`, proving the tool is callable.
- Safe-stale candidate dry-run returned `OPEN_PR_READBACK_FAILED` with GitHub API 422: `base wasn't supplied`.

## Decision

Do not delete branches. The active delete route still uses stale open-PR query behavior for non-protected branch candidates.

## Next executable repair

Repair active MCP route metadata/process so `github_delete_branch_ref` lists open PRs with `base=main` or local matching, then rerun exactly one dry-run for PR #149 safe-stale candidates.
