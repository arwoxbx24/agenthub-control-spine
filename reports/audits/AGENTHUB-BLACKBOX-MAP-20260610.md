# AgentHub Blackbox Map 2026-06-10

## A. Tool surfaces and route ownership

| Route | Available operations | Blocked operations | Failure type | Classification |
|---|---|---|---|---|
| ChatGPT Web | Architecture prompt/status, GitHub connector calls | Direct delete-ref, runtime mutation, PR merge-as-Done | Boundary by policy | CRITICAL_KEEP |
| GitHub connector | Repo metadata, branch search, create branch, create/update files, PR metadata | Delete branch ref not exposed | Missing tool surface | ROUTINE_REPAIR |
| AgentHub MCP | Contract, create, smoke, sandbox dispatch, execute, delete-ref route | Command adapter live dispatch | Contract-only live dispatch gate | CRITICAL_KEEP plus ROUTINE_REPAIR |
| Local shell/git/gh | In principle can read/write local clone | Blocked by pre-dispatch task gate | Metadata parser/gate mismatch | FALSE_POSITIVE_REMOVE or ROUTINE_REPAIR |
| YouTrack route | Required task binding | Not fully exposed in this audit turn | Route availability gap | ROUTINE_REPAIR |
| Branch delete route | `github_delete_branch_ref` exists | Active tool still stale/bugged | MCP metadata/process refresh failure | ROUTINE_REPAIR |

## B. Current blocker inventory

Active blocker family: `MCP_PROCESS_REFRESH_REQUIRED`, `DELETE_ROUTE_OPEN_PR_QUERY_BUG`, `REMOTE_DELETIONS_ZERO`, `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`, `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`.

Historical/stale blocker family: `GITHUB_DELETE_REF_TOOL_UNAVAILABLE`, `GITHUB_BRANCH_DELETE_PERMISSION_DENIED`, broad `BRANCH_DELETE_ROUTE_NOT_READY` without repair action.

## C. Hook and pre-dispatch gates

Observed hooks/gates:

- Global runtime hook gate: PASS in tool preambles.
- Pre-dispatch task gate: blocks direct shell with `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`.
- Route-only/contract gate: blocks command adapter as `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`.
- No-fake-Done gate: valid and must stay.

Finding: protection intent is valid, but local shell gate currently gives a dead-end error for task-bound repository audit commands.

## D. MCP metadata and process refresh

Finding: source repair for delete route was reported earlier, but active `github_delete_branch_ref` still returned stale open PR query behavior. There is no visible refresh/reload tool in exposed AgentHub MCP surface. Required next action is to expose or run minimal MCP registry reload, then verify active metadata.

## E. GitHub branch cleanup route

Branch count readback: 104 names from GitHub branch search. Open PR readback: PRs #149, #148, #147. Branch deletion was not performed. PR #149 is protected because its head branch backs an open PR.

## F. PR noise and prompt noise

Open PRs #148 and #147 are not the same exact cleanup scope as PR #149, but they add instruction noise. PR #149 remains the only branch-hygiene cleanup contour. One-time prompts must be treated as consumed unless registered safe-to-replay.

## G. Fake Done and false PASS

False Done patterns found by current evidence: sandbox success, PR creation, receipt write, secret-scan pass, and T0 readback have all appeared as tempting Done substitutes. True Done for PR #149 requires deletion evidence or an explicit typed blocker receipt.

## H. Access and authority model

Open/narrow: scoped repo audit branch creation, scoped report writes, scoped delete-ref route after task/open-PR/SHA checks, scoped MCP metadata refresh.

Keep closed: Docker, DB, proxy, firewall, DNS, SSL, secrets, production/product mutation, broad branch deletion, personal repo targets.
