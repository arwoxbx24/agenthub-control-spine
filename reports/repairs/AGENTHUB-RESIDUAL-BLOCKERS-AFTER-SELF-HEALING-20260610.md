# AgentHub Residual Blockers After Self-Healing 2026-06-10

| blocker | evidence | why not fixed | class | exact next action | owner action required |
|---|---|---|---|---|---|
| `DELETE_ROUTE_OPEN_PR_QUERY_BUG` | Safe-stale dry-run returned `OPEN_PR_READBACK_FAILED`; GitHub API 422 says `base` was not supplied. | Active MCP tool still runs stale open PR query behavior. Repository branch artifacts cannot reload active MCP process. | ROUTINE_REPAIR / implementation failure | Patch or refresh active `github_delete_branch_ref` implementation to list open PRs with `base=main` and local `head.ref` matching, then rerun dry-run once. | no |
| `MCP_PROCESS_REFRESH_REQUIRED` | Prior source patch evidence exists, but active tool behavior still old. | No exposed safe MCP process refresh route was available in this contour. | ROUTINE_REPAIR | Expose scoped `agent-hub-mcp` registry reload/readback route; verify active metadata hash/behavior. | no |
| `PR149_BRANCH_CLEANUP_NOT_EXECUTED` | PR #149 deletion count remains zero; no branch delete occurred in this repair. | Deletion route dry-run failed before execution. | NO_FAKE_DONE_GATE | After route repair, execute PR #149 safe-stale deletion plan and update receipt/registers. | no |
| `PRE_DISPATCH_METADATA_ADAPTER_FAILED` | Direct shell remains blocked by `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` from previous audit evidence. | Runtime hook source was not safely patchable in this repo-only contour. | ROUTINE_REPAIR | Repair gate metadata adapter to accept task/run/repo metadata from scoped AgentHub worker context. | no |

## Final residual decision

No owner-only blocker found. This is an internal AgentHub route repair issue, not a credentials/payment/legal/destructive-production gate.
