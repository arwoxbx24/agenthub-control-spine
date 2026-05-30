---
artifact_id: P0-t0-escape-H-prompt-quality-redteam-20260530
artifact_type: audit_report
source_task: 3-640
run_id: RUN-P0-T0-ESCAPE-ORCHESTRATION-BOUNDARY-AUDIT-20260530
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
created_at: 2026-05-30
---

# Microtask H - Prompt Quality And Red-Team Audit

## Result

Final state: `PROMPT_DEFECTS_ACTIVE`.

## Score

Owner prompt score: `96/100`.

## Evidence

- The prompt clearly defines task class, role boundaries, no-mutation audit mode, microtasks, validation, final format, and typed final states.
- The protected transcript demonstrates prior prompt failure modes: direct runtime work before AgentHub routing, token pressure, user-action leakage, and sandbox/route proof being over-reported as outcome proof.

## Active Defects

- `ROLE_BOUNDARY_MISSING`: active execution allowed T0 direct actions before durable pre-tool enforcement.
- `EVIDENCE_GATE_MISSING`: sandbox/command-route evidence was treated too close to runtime outcome evidence in some flows.
- `USER_ACTION_LEAK`: owner was exposed to routine route/model/button pressure in prior transcripts.
- `TOKEN_BLOAT`: long transcript pressure caused action shortcuts.
- `REPORT_AS_INSTRUCTION_RISK`: historical audit/receipt artifacts are abundant and need lifecycle enforcement.

## Required Repair

The implementation prompt must require executable pre-action controls, not another instruction-only policy.

## Gates

- no_secret_leak: `PASS`
- no_runtime_mutation: `PASS`
- no_product_code_mutation: `PASS`
