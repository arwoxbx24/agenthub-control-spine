# AgentHub Self-Healing Repair Map 2026-06-10

## Ordered repair queue

| Order | Repair | Surface | Gate decision | Validator to add | Rollback | Acceptance gate | Residual blocker if fail |
|---:|---|---|---|---|---|---|---|
| 1 | Expose or run MCP tool metadata refresh | `agent-hub-mcp` process/registry | ROUTINE_REPAIR | Active metadata readback for `github_delete_branch_ref` | Restart previous MCP process/config | `MCP_REFRESH_READBACK_GATE` | `MCP_PROCESS_REFRESH_REQUIRED` |
| 2 | Fix active open PR branch check | `github_delete_branch_ref` route | ROUTINE_REPAIR | Slash branch open PR fixture and PR #149 protected fixture | Revert route patch | `DELETE_ROUTE_BUG_FIXED_GATE` | `DELETE_ROUTE_OPEN_PR_QUERY_BUG` |
| 3 | Narrow local shell pre-dispatch parser | pre-dispatch/task gate | FALSE_POSITIVE_REMOVE or ROUTINE_REPAIR | Harmless task-bound repo read fixture | Revert parser/gate change | Task metadata accepted or exact field reported | `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` |
| 4 | Add non-live repo audit worker path | AgentHub command/sandbox route | ROUTINE_REPAIR | Repo-audit command allowed; live mutation denied | Revert route profile | Repo audit can run without live runtime adapter | `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` |
| 5 | Continue PR #149 deletion plan | PR #149 branch | CRITICAL_KEEP on safety gates | Dry-run and delete readback fixtures | Restore skipped candidates to review list | Deleted count > 0, protected/fresh/open PR kept | `REMOTE_DELETIONS_ZERO` |
| 6 | Sync registers after real lifecycle change | `PR_QUEUE_REGISTER.md`, `ARTIFACT_REGISTER.md`, `INDEX.md` | ROUTINE_REPAIR | Register/index consistency check | Revert register-only commit | Register state matches GitHub state | `REGISTER_SYNC_BLOCKED` |

## Exact file/surface to change

Runtime/source surfaces must be touched only by the second self-healing execution route, not by this audit. Expected source surfaces from prior evidence include MCP registry/tool metadata and route-only gate files under the runtime control plane. Product/runtime/Docker/DB/proxy/firewall/DNS/SSL/secrets remain forbidden.

## Gates to keep

- Open PR branch protection.
- Protected branch list.
- Fresh branch date window.
- Expected SHA match.
- Canonical repo `arwoxbx24/agenthub-control-spine` only.
- Task/YouTrack/RUN binding.
- No fake Done when deletion count is zero.
- Secret and forbidden-zone gates.

## Gates to narrow

- Pre-dispatch issue-id parsing that blocks valid task-bound repo actions.
- Contract-only live dispatch gate when used against non-live repo-audit command workers.
- Stale blocker/status loop that repeats route failure without repair action.

## Gates to remove as active blockers

Do not emit stale global blockers `GITHUB_DELETE_REF_TOOL_UNAVAILABLE` or `GITHUB_BRANCH_DELETE_PERMISSION_DENIED` unless fresh evidence proves them again after MCP refresh.

## Second prompt execution rule

The second self-healing prompt must not create a duplicate cleanup branch or PR. It should either patch/refresh the MCP route and return to PR #149, or record one typed blocker with exact failing surface.
