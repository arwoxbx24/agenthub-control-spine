---
artifact_id: owner-distress-prod-recovery-runbook
artifact_type: runbook
source_task: AH-796
run_id: RUN-owner-distress-prod-recovery-control-20260614
created_at: 2026-06-14
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Owner Distress Production Recovery Runbook

1. Detect owner distress and switch to INCIDENT.
2. Freeze unsafe mutation only; start read-only triage.
3. Bind one P0 task and RUN_ID.
4. Capture state through authorized AgentHub/MCP route.
5. Classify blast radius and environment.
6. Build last-known-change ledger.
7. Block UNKNOWN/PROD_RISK mutation into same-RUN route discovery.
8. If prod untouched, state evidence and resume test only after panic resolves.
9. If prod touched, choose smallest reversible action.
10. Stop DB/proxy/runtime/destructive recovery at OWNER_ONLY_IRREVERSIBLE_GATE.
11. Validate with browser/user-visible proof where in scope.
12. Close or record PR/branch/task tails and update registers before Done.
