---
artifact_id: owner-distress-prod-recovery-runbook
artifact_type: runbook
owner_role: Incident T1 / T2 Worker / Verifier
source_task: AH-796
run_id: RUN-owner-distress-prod-recovery-control-20260614
created_at: 2026-06-14
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Owner Distress Production Recovery Runbook

1. Detect owner distress signal and switch to `INCIDENT`.
2. Stop unsafe mutation; do not stop read-only triage.
3. Bind or create one P0 incident task and one RUN_ID.
4. Start authorized read-only capture through AgentHub/MCP route.
5. Classify blast radius and target environment.
6. Build a last-known-change ledger: PRs, commits, workflows, deploys, task ids, routes, and environment proof.
7. If environment is `UNKNOWN_ENVIRONMENT` or `PROD_RISK`, block mutation and run route-discovery PackFix in the same RUN.
8. If production was not touched, state the evidence in `Fact/Action/Left` and return to test work only after panic is resolved.
9. If production was touched, select the smallest reversible recovery action.
10. For DB/proxy/runtime/destructive/global infra, stop at `OWNER_ONLY_IRREVERSIBLE_GATE` with one exact phrase.
11. Validate recovery with user-visible/browser proof when in scope.
12. Before Done, close or record PR/branch/task tails and update registers.
