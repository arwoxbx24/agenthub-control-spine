# Hook And Rule Overlap Audit

## Current Hook Layer

`/root/.codex/hooks.json` registers one Ruby hook for `PreToolUse`, `PermissionRequest`, `PostToolUse`, and `Stop`. This is the right shape: one implementation, four lifecycle points. Do not install a second Ponytail hook or a duplicate safety hook.

## Hook Friction

The hook blocks unsafe or under-specified actions, but denial reasons are too short for recovery:

- `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`
- `YOUTRACK_READBACK_PERMISSION_MISSING`
- `T0_DIRECT_RUNTIME_MUTATION_DEFECT`

Needed improvement: every deny receipt must include one short machine field: `next_valid_route`. Example: `create_or_bind_issue -> tracker readback -> agent_hub_dispatch -> retry`.

## Duplicate Rule Families

These families repeat in several layers:

- MCP-first / AgentHub-first.
- T0 must not directly mutate product code.
- Forbidden zones: DB, Docker, Nginx, proxy, firewall, secrets.
- Protected-link intake.
- Helper model allowlist and no `fork_context:true`.
- Done requires evidence.
- English technical prompts / Russian user-facing output.
- Path safety and no backup/shadow writes.

## Self-Blocking Patterns

1. Strict T0 no-mutation plus report-writing request can block local artifact creation unless a task id exists.
2. Done gate and blocker fields can diverge when old Done issue receives new continuation comments.
3. Multiple “must use AgentHub” rules do not specify one recovery route after denial.
4. Plan Mode vs execution prompts can conflict if user says “implement” while developer mode says Plan only.
5. Protected-link safety can be misread as “no browser work” instead of “use protected intake, then approved browser route”.

## Merge Recommendation

Keep one hard hook. Merge rule text, not hook processes.

Canonical order:

1. System/developer mode.
2. Latest explicit owner scope command.
3. Forbidden-zone safety.
4. AgentHub route and task identity.
5. Project/local AGENTS narrowing.
6. Efficiency style: Ponytail/Caveman.

This preserves safety and reduces instruction collisions.
