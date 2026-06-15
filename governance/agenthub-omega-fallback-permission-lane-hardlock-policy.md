---
artifact_id: agenthub-omega-fallback-permission-lane-hardlock-policy
artifact_type: governance-policy
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-796
run_id: omega-fallback-permission-lane-hardlock-20260615
created_at: 2026-06-15
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
supersedes: none
superseded_by: none
---

# AgentHub Omega Fallback Permission Lane Hardlock Policy

## Purpose

This policy is the Omega front for the four prompt architecture package and PR
`#175`. It closes the missing durable controls for connector deadlocks, scoped
GitHub CLI fallback, permission lanes, same-RUN PackFix, repeated blocked
commands, owner shell handoff, fake Done, and PR-only Done.

The four prompt architecture package remains installed source architecture. The
Omega front adds the fifth operational layer: connector fallback and dynamic
permission-lane governance.

This policy applies only to the canonical control-spine repository
`arwoxbx24/agenthub-control-spine`. It does not authorize product repositories,
StroyRemont, production/test/staging sites, product workflow dispatch, database,
Docker, proxy, firewall, DNS, SSL, PM2, tmux, server/runtime mutation, secrets,
broad cleanup, branch-protection weakening, or safety-gate bypass.

## Route Order

GitHub operations must use this order:

1. GitHub connector/API tool.
2. AgentHub-approved GitHub MCP route.
3. `gh` CLI fallback inside the task-bound AgentHub contour.

The `gh` fallback is allowed only when all are true:

- repository is `arwoxbx24/agenthub-control-spine`;
- exact task id and RUN id are bound;
- action is limited to control-spine artifact/register/PR read/write;
- allowed paths are declared;
- forbidden repositories and operations are declared;
- no product repository is touched;
- no workflow dispatch is performed;
- no secret or env output is printed;
- output is captured as evidence;
- retry limit is one per evidence state.

If these are not true, use `GH_FALLBACK_SCOPE_UNSAFE` or
`GITHUB_CONNECTOR_AND_GH_FALLBACK_UNAVAILABLE`.

## Permission Lanes

Use the smallest lane that can perform the work:

- `L0_READ_ONLY_AUDIT`
- `L1_CONTROL_SPINE_READ`
- `L2_CONTROL_SPINE_WRITE`
- `L3_PR_QUEUE_REGISTER_UPDATE`
- `L4_CI_STATUS_READ`
- `L5_GITHUB_CONNECTOR_FALLBACK_TO_GH`
- `L6_BRANCH_PROTECTION_READ`
- `L7_ADMIN_MERGE_REQUIRES_EXPLICIT_EVIDENCE`
- `L8_PRODUCT_RUNTIME_FORBIDDEN_BY_DEFAULT`

Broad wildcard grants, hidden bypasses, product/prod/test/runtime lanes, and
"all permissions" requests are denied by default.

Each lane grant must record task id, run id, repository, paths, action, expiry,
proof, rollback note, and evidence sink.

## Same-RUN PackFix

Routine platform gaps must become same-RUN PackFix/remediation instead of owner
handoff:

- connector unavailable;
- validator route blocked;
- register row missing;
- PR queue state stale;
- task evidence attach timeout;
- missing main/readback proof.

Owner shell commands are not an acceptable fallback for routine platform work.

## Blocked Command Loop Guard

The same command plus same blocker repeated twice is token burn and must stop.
Command obfuscation to bypass guard words is a violation. Shell probes without
task binding are blocked. Owner handoff after routine blocker is blocked.

## Done Gate

Done requires all of:

- PR `#175` report consumed;
- four prompt source package consumed;
- fifth front installed or verified;
- connector fallback governed and scoped;
- permission lanes governed and scoped;
- validators pass;
- register coverage exists;
- PR queue state is accurate;
- main/readback exists or exact platform blocker exists;
- YouTrack Done readback exists or exact platform blocker exists.

Rejected evidence:

- local priority index;
- chat report;
- PR-only Done;
- head commit CI PASS without main/readback/task proof;
- fake PASS/self-report;
- repeated blocked command output.

## Typed Blockers

Allowed terminal blockers:

- `GITHUB_CONNECTOR_AND_GH_FALLBACK_UNAVAILABLE`
- `GH_FALLBACK_SCOPE_UNSAFE`
- `BRANCH_PROTECTION_PLATFORM_GATE`
- `YOUTRACK_READBACK_UNAVAILABLE`
- `AGENTHUB_ROUTE_MISSING`
- `CONTROL_SPINE_WRITE_ROUTE_MISSING`
- `OWNER_ONLY_PLATFORM_GATE`
- `SAFETY_QUARANTINE`

