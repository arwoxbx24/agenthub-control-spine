# AgentHub Hook Runtime MCP Audit 2026-06-10

## Scope

Read-only audit of hooks, runtime gates, MCP route behavior, and deadlock signals. No runtime file was patched by this audit.

## Findings

| surface | observed behavior | classification | keep/narrow/remove | next action |
|---|---|---|---|---|
| Global runtime gate | PASS emitted before MCP/GitHub operations | CRITICAL_KEEP | keep | Continue as preflight proof, not Done proof |
| AgentHub command adapter gate | Non-sandbox command dispatch blocked as `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` | CRITICAL_KEEP plus ROUTINE_REPAIR | keep for live runtime; narrow for repo audit | Add explicit non-live repository audit worker route |
| Local shell pre-dispatch hook | Blocks even harmless shell/read attempts with `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` | FALSE_POSITIVE_REMOVE or ROUTINE_REPAIR | narrow | Accept `AH-731`/RUN metadata or output exact missing key |
| MCP delete-ref active metadata | Delete tool exists, but prior active process kept stale open PR query behavior | ROUTINE_REPAIR | repair | Expose process reload/metadata refresh and read back active tool behavior |
| No fake Done gate | Blocks completion when deletion count is zero | CRITICAL_KEEP | keep | Continue to require receipt counts and branch readback |
| No secret/runtime forbidden zones | Docker/DB/proxy/firewall/DNS/SSL/secrets remain closed | CRITICAL_KEEP | keep | Do not route branch cleanup through forbidden zones |

## Exact MCP refresh answer

Patched source alone is insufficient. The active `agent-hub-mcp` tool process must be refreshed or restarted, then the exposed `github_delete_branch_ref` behavior must be tested. Without that readback, rerunning dry-run repeats the same blocker loop.

## Validator coverage required

1. `github_delete_branch_ref` detects `agenthub/control-spine-branch-hygiene-20260610` as open-PR protected.
2. Branch names containing `/` are matched by local PR list filtering, not by fragile `head` query alone.
3. Malformed GitHub PR API response returns typed `DELETE_ROUTE_OPEN_PR_QUERY_BUG` and does not delete.
4. Protected/fresh/SHA-mismatch branches deny deletion.
5. Safe-stale candidate passes dry-run only after task and YouTrack readback are present.
