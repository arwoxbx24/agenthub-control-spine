# AgentHub Artificial Gates Removed Or Narrowed 2026-06-10

## Narrowed by evidence

| Gate/blocker | New classification | Evidence | Next action |
|---|---|---|---|
| `GITHUB_DELETE_REF_TOOL_UNAVAILABLE` | stale, not current | `github_delete_branch_ref` tool is callable. | Stop using as active global blocker. |
| `GITHUB_BRANCH_DELETE_PERMISSION_DENIED` | stale, not current | Current failure is open PR query bug, not permission denial. | Stop replaying unless fresh evidence proves permission denial. |
| Broad `BRANCH_DELETE_ROUTE_NOT_READY` | too vague | Current exact failure is `OPEN_PR_READBACK_FAILED` / API 422 missing `base`. | Use `DELETE_ROUTE_OPEN_PR_QUERY_BUG` or `MCP_PROCESS_REFRESH_REQUIRED`. |
| Sandbox/receipt PASS as Done | false Done | Safe-stale deletion dry-run still fails. | Keep no-fake-Done gate. |

## Not narrowed in runtime

`PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` and `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` were not patched in runtime during this repository repair because no safe runtime source write/readback route was available in this execution contour.

## Current owner-facing blocker language

Use one current blocker only: `DELETE_ROUTE_OPEN_PR_QUERY_BUG` when discussing PR #149 deletion execution, or `MCP_PROCESS_REFRESH_REQUIRED` when discussing why patched route metadata is not live.
