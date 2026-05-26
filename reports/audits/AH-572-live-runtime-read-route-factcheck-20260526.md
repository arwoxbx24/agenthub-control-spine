---
artifact_id: AH-572-live-runtime-read-route-factcheck-20260526
artifact_type: audit_report
owner_role: T0 Control Plane / Registrar
source_task: AH-572
run_id: RUN-komodo-phase1-readonly-audit-20260526
created_at: 2026-05-26
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# AH-572 Live Runtime Read Route Factcheck

## Scope

This report records the factcheck requested after AH-554 and PR #55 installed
T0 live-root hard enforcement. The owner observed that another agent still
could not run the AH-572 read-only Docker/NPM audit and asked why access did
not work after rights expansion.

This is a control-spine reporting artifact only. It does not perform Docker,
NPM, database, proxy, firewall, DNS, SSL, PM2, Appsmith, product, client, or
domain-service mutation.

## Current Tasks

| Task | Role in this incident | Current readback |
|---|---|---|
| AH-554 | T0 live-root hard-enforcement closure | Done for the enforcement scope only. PR #55 and PR #56 are merged; T0 direct live-root route is constrained. |
| AH-570 | AgentHub core permission architecture | Control-plane permission profile work; not proof of live Docker/NPM executor availability. |
| AH-571 | Komodo orchestration parent | Parent for Komodo roadmap. |
| AH-572 | Phase 1 read-only Docker/NPM audit | Still waiting for a registered live runtime read executor. |

## What Was Verified

| Check | Result |
|---|---|
| AgentHub MCP status | PASS. Runtime reports OK. |
| AgentHub health | PASS. No failed health count. |
| AgentHub process inventory | PASS. No active processes listed. |
| Runtime contract readback | PASS. Contract reports AgentHub mode as `evidence_first_sandbox`. |
| AH-554 state | Done for T0 live-root hard-enforcement scope. |
| AH-572 state | Develop; read-only Docker/NPM audit evidence not collected. |
| Direct T0 shell fallback | Forbidden by policy and not used. |
| Forbidden runtime surfaces | Not touched. |

## Root Cause

The rights expansion completed for control-plane policy, registrar actions,
T0 denial, reporting, and task evidence routing. That does not automatically
create a live server executor for AH-572.

AH-572 needs a separate authorized T2/P4 live runtime read route that can reach
the server-side Docker/NPM surface in read-only mode. The current AgentHub MCP
contract exposed to this run is `evidence_first_sandbox`, so command dispatch is
rejected before reaching Docker. This is why the other agent sees a failure
before command execution.

## Why This Is Not Contradictory

The completed enforcement work intentionally separates safe control-plane
permissions from live runtime permissions:

- Control-plane: repository reports, registers, PR queue, YouTrack evidence,
  policy artifacts, receipts, verifier readback.
- Live runtime: Docker/NPM/server inspection or mutation. Even read-only live
  Docker inventory still requires an explicit scoped live runtime route because
  it crosses into server runtime authority.

Therefore "rights expanded" means safe control-plane actions and policy
installation are available, not that every future Docker/NPM route is open.

## Required Route To Finish AH-572

AH-572 can finish only when a live runtime read executor is registered with:

- `task_id=AH-572`;
- `worker_role=T2_LIVE_READONLY_WORKER` or equivalent P4/T2 read profile;
- `RUN_ID=RUN-komodo-phase1-readonly-audit-20260526` or a recorded continuation;
- allowed surface: read-only Docker inventory, Docker networks, Compose list,
  and safe NPM proxy-host inventory through the approved method;
- forbidden surface: Docker mutation, NPM mutation, DB access, proxy edit,
  firewall/DNS/SSL changes, secret/env reads, destructive cleanup;
- bounded timeout and output size;
- redacted evidence path in control-spine;
- verifier readback;
- YouTrack AH-572 final evidence update.

## Acceptance Criteria For AH-572

AH-572 is not Done until all of these are true:

1. The live runtime read route is registered and visible to AgentHub.
2. The read-only audit runs through that route, not through T0 shell fallback.
3. Docker/NPM inventory evidence is redacted and stored as a repository artifact.
4. Validation confirms no forbidden mutation occurred.
5. AH-572 is updated with implementation evidence, validation evidence, receipt,
   and final Done gate.

## Current Conclusion

The current failure is not caused by the AH-554 enforcement package being
missing. The current failure is caused by the absence of a registered live
runtime read executor for AH-572.

Final state for this factcheck report: `LIVE_RUNTIME_READ_ROUTE_REQUIRED`.

