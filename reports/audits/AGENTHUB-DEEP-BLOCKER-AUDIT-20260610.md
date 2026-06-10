# AgentHub Deep Blocker Audit 2026-06-10

## Executive truth summary

Audit branch: `agenthub/deep-blocker-audit-20260610`.
Canonical repo: `arwoxbx24/agenthub-control-spine`.
Forbidden default owner: `arwoxb24`.

This audit did not delete branches, merge PRs, patch runtime, inspect secrets, or touch Docker/DB/proxy/firewall/DNS/SSL/product surfaces.

Current repo noise is real: branch inventory readback found 104 remote branches. Open PR readback found three open PRs: `#149`, `#148`, `#147`. PR `#149` is still the only branch-hygiene cleanup contour. It is open, mergeable, not merged, base `main`, head `agenthub/control-spine-branch-hygiene-20260610`, head SHA `3391f654b37bf15fa4d90ee2d7a47f4a9d638632`.

## Current blockers

| Blocker | Status | Class | Evidence | Next repair |
|---|---|---|---|---|
| `MCP_PROCESS_REFRESH_REQUIRED` | active | ROUTINE_REPAIR | Active `github_delete_branch_ref` still exposed stale behavior after source patch; PR #149 receipt records deletions=0. | Add/recover explicit MCP metadata/process refresh route, reload tool registry, then run one dry-run. |
| `DELETE_ROUTE_OPEN_PR_QUERY_BUG` | active until refresh proof | ROUTINE_REPAIR | Previous delete route failed with `OPEN_PR_READBACK_FAILED` / missing `base`; source was patched but process did not reload. | Validate refreshed route against slash branch names and PR #149 head branch. |
| `REMOTE_DELETIONS_ZERO` | active | NO_FAKE_DONE_GATE | PR #149 receipt records `deletions=0`. | Do not merge/close PR #149 as cleanup complete until safe-stale branches are actually deleted. |
| `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` | active for command adapter | CRITICAL_KEEP plus ROUTINE_REPAIR | AgentHub MCP command dispatch rejected non-sandbox adapter. | Keep for live/runtime; narrow or document repo-audit command-worker path separately. |
| `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` | active for local shell | FALSE_POSITIVE_REMOVE or ROUTINE_REPAIR | Direct shell blocked even when task/run variables were provided. | Repair metadata parsing or return actionable missing-field diagnostics. |

## Stale blockers

`GITHUB_DELETE_REF_TOOL_UNAVAILABLE` and `GITHUB_BRANCH_DELETE_PERMISSION_DENIED` are stale as global blockers. A task-bound MCP delete tool exists, but its active process/metadata is stale or bugged. Treat them as AH-731-local historical evidence only.

## False blocker classes

- Sandbox `SUCCESS` is not final Done.
- PR creation is not implementation Done.
- Receipt write is not branch deletion Done.
- Secret-scan success is not cleanup Done.
- T0 readback is not worker implementation proof.

## Critical gates to keep

Keep gates for secrets, DB, Docker, proxy, firewall, DNS, SSL, destructive production actions, open-PR branch protection, protected branch protection, SHA pinning, canonical repo enforcement, and no fake Done.

## Artificial gates to remove or narrow

Narrow gates that block task-bound repository audit/cleanup without providing a repair path: stale MCP metadata with no refresh endpoint, shell pre-dispatch issue-id parser mismatch, global status-loop blockers, and consumed prompts still treated as active instructions.

## Route ownership map

- ChatGPT Web: architecture and owner-facing compact status only; no ref deletion, runtime mutation, or PR merge.
- GitHub connector: repository reads, file writes, branch creation, PR metadata, comments; no branch delete tool exposed in this audit.
- AgentHub MCP: canonical route for lifecycle, sandbox, and delete-ref tool; current delete-ref route blocked by active-process refresh failure.
- Local shell/git/gh: blocked by pre-dispatch gate for ordinary direct use.
- YouTrack: task binding required for AH-731/AH-733; task readback remains required before repair/cleanup Done.

## PR #149 status

PR #149 remains open, not merged, and cannot be called complete because remote branch deletions are zero. The next repair belongs to the same contour: refresh/reload MCP process, validate open PR query, dry-run safe-delete candidates, execute only approved deletion list, then update receipt/registers.

## Branch cleanup status

Branch deletion not performed in this audit. Branch count readback: 104 names returned by GitHub branch search. The branch-hygiene receipt already recorded 10 safe-stale candidates and 15 review-before-delete branches. This audit did not change that list.

## Prompt/report noise status

Reports and receipts are evidence only. One-time prompts are consumed unless explicitly registered safe-to-replay. Duplicate PR/prompt chains are a noise source and must not be used to bypass PR #149.

## Exact self-healing plan

1. Add or expose MCP metadata refresh for `agent-hub-mcp` tool registry.
2. Confirm active `github_delete_branch_ref` metadata matches patched source.
3. Validate open PR detection by locally matching `base.ref`, `head.ref`, and `head.repo.full_name` for slash branches.
4. Run one dry-run for PR #149 safe-stale candidates.
5. Delete only candidates passing protected/fresh/open-PR/SHA/task checks.
6. Update PR #149 receipt, `PR_QUEUE_REGISTER.md`, and `ARTIFACT_REGISTER.md` only after real lifecycle changes.
7. Merge/close PR #149 only after deleted count is greater than zero or after explicit owner decision to close with blocker preserved.
