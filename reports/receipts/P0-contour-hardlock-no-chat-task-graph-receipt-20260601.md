---
artifact_id: P0-contour-hardlock-no-chat-task-graph-receipt-20260601
artifact_type: operational_receipt
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-CONTOUR-HARDLOCK-NO-CHAT-TASK-GRAPH-20260601
run_id: RUN-CONTOUR-HARDLOCK-NO-CHAT-TASK-GRAPH-20260601
created_at: 2026-06-01
status: partial-with-platform-blocker
default_load: false
safe_to_replay: false
---

# P0 Contour Hardlock No-Chat Task Graph Receipt

## Scope

Installed a composite AgentHub contour hardlock gate in the control-spine
repository. This run did not mutate Hiddify, Docker, databases, proxy,
firewall, DNS, SSL, secrets, or live runtime configuration.

## Installed Artifacts

- `governance/contour-hardlock-no-chat-task-graph-policy.md`
- `schemas/contour_hardlock_state_machine.schema.json`
- `validators/contour_hardlock_no_chat_task_graph_validator.rb`
- `evals/contour-hardlock-no-chat-task-graph/fixtures.json`
- `reports/receipts/P0-contour-hardlock-no-chat-task-graph-receipt-20260601.md`

## Validation

- Hardlock validator: PASS.
- Existing no-chat deadlock validator: PASS.
- Existing contour task graph validator: PASS.
- Existing no-interaction task-first validator: PASS.
- Existing boundary/backup/docs-first validator: PASS.
- Existing API/documentation-first validator: PASS.
- Ruby syntax checks: PASS.
- Secret string scan for new artifacts: PASS.

## Prompt Quality

Self-score: 96/100.
Red-team checks: wrong task, role drift, evidence fraud, scope creep,
user-action leak, token bloat, stale-source replay, PR-tail, secret leak, and
duplicate-run all PASS for repository-control scope.

## Residual

`TASK_SERVICE_PHYSICAL_WRITE_MISSING` remains active for physical YouTrack
write/readback in this environment. Repository controls are installed and
validated; final task-service closure still requires the YouTrack write path to
recover or an approved task-service platform remediation route.
