---
artifact_id: p0-project-methodology-mirror-enforcement-validation-20260528
artifact_type: validation_report
owner_role: Verifier
source_task: AH-595
run_id: RUN-P0-PROJECT-METHODOLOGY-MIRROR-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 Project Methodology Mirror Enforcement Validation

Validation before PR:

| Check | Result |
|---|---|
| `ruby validators/methodology-router/validate-methodology-router.rb evals/methodology-router/fixtures.json` | PASS, 12 cases |
| `ruby validators/agenthub_methodology_router_validator.rb evals/agenthub-methodology-router/fixtures.json` | PASS, 18 cases |
| `ruby validators/agenthub_blackbox_route_validator.rb evals/agenthub-blackbox-routes/fixtures.json` | PASS, 17 cases |
| `schemas/methodology-router.schema.json` JSON parse | PASS |
| `schemas/project-source-mirror.schema.json` JSON parse | PASS |
| `evals/methodology-router/fixtures.json` JSON parse | PASS |

Negative coverage:

- T0 code/shell denial
- all-25 methodology overload denial
- incident methods missing
- architecture ADR/options missing
- code-like work without Codex route
- GitHub-only fake Done
- report-only fake Done
- old audit replay as instruction
- third retry loop blocked
- true owner-only credential gate

Positive coverage:

- five-source project mirror is valid;
- full profile selection is allowed when methods, skills, scope, negative
  matches, RUN_ID, and evidence targets are present.

Secret scan and final main validation are recorded in the implementation
receipt after PR/readback.

