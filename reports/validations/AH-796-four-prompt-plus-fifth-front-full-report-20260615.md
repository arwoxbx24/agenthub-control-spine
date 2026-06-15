---
artifact_id: AH-796-four-prompt-plus-fifth-front-full-report-20260615
artifact_type: full-implementation-report
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-796
run_id: four-prompt-architecture-hardlock-20260615
created_at: 2026-06-15
lifecycle_status: validation-report
default_load: false
safe_to_replay: false
---

# AH-796 Full Report: Four Prompts + Fifth Front

## Summary

This report records the repository package that installs the four
owner-provided architect prompts plus the fifth implementation-front prompt as a
single AgentHub/Codex governance architecture package in
`arwoxbx24/agenthub-control-spine`.

This is not a local prompt-folder priority index. The package is installed as
control-spine governance artifacts, schemas, validators, fixtures, runbooks,
templates, register rows, validation report, and receipt.

## Source Prompt Consumption

| Source | Role in package | Installed coverage |
|---|---|---|
| `AGENTHUB-PERMANENT-PROD-INCIDENT-RECOVERY-AND-TEST-FIRST-HARDLOCK-PROMPT.txt` | Primary | test-first/prod lock, environment classification, safe recovery, Done gate |
| `AGENTHUB-PERMANENT-TEST-FIRST-PROD-DEPLOY-LOCK-GOVERNANCE-PROMPT.txt` | Supplement | deploy/test-first lock, workflow impact audit, production phrase |
| `AGENTHUB-PERMANENT-OWNER-DISTRESS-PROD-RECOVERY-CONTROL-PROMPT.txt` | Supplement | owner-distress incident trigger, no-apology/no-stop-only loop |
| `AGENTHUB-PR171-GITLEAKS-MERGE-GATE-TERMINAL-CLOSURE-PROMPT.txt` | Point-fix | PR171/gitleaks closure, merge-loop blocker |
| Latest implementation-front prompt | Fifth front | canonical file names, full package checklist, PR queue/readback gates |

## Installed Package

Primary installed files:

- `governance/agenthub-four-prompt-architecture-hardlock-policy.md`
- `governance/four-prompts-system-hardlock-policy.md`
- `schemas/environment_route_proof.schema.json`
- `schemas/workflow_impact_audit.schema.json`
- `schemas/owner_incident_recovery_lane.schema.json`
- `schemas/four_prompt_architecture_install_receipt.schema.json`
- `validators/four_prompt_architecture_hardlock_validator.rb`
- `fixtures/four-prompt-architecture-hardlock/fixtures.json`
- `runbooks/four-prompt-architecture-hardlock-runbook.md`
- `prompts/templates/four-prompt-architecture-hardlock-worker-template.txt`
- `reports/validations/AH-796-four-prompt-architecture-hardlock-validation-20260615.md`
- `reports/receipts/AH-796-four-prompt-architecture-hardlock-receipt-20260615.md`

Supporting system-hardlock files:

- `validators/four_prompts_system_hardlock_validator.rb`
- `evals/four-prompts-system-hardlock/fixtures.json`
- `runbooks/four-prompts-system-hardlock-runbook.md`
- `prompts/templates/four-prompts-system-hardlock-worker-template.md`
- `reports/validations/AH-FOUR-PROMPTS-system-hardlock-validation-20260615.md`
- `reports/validations/AH-FOUR-PROMPTS-claim-ledger-20260615.md`
- `reports/receipts/AH-FOUR-PROMPTS-system-hardlock-receipt-20260615.md`

Register coverage:

- `AGENTS.md`
- `INDEX.md`
- `ARTIFACT_REGISTER.md`
- `PR_QUEUE_REGISTER.md`

## Validation Evidence

Executed validators:

```bash
ruby validators/four_prompt_architecture_hardlock_validator.rb fixtures/four-prompt-architecture-hardlock/fixtures.json
```

Observed result:

```json
{"status":"PASS","cases":12,"validator":"four_prompt_architecture_hardlock_validator.rb"}
```

```bash
ruby validators/four_prompts_system_hardlock_validator.rb evals/four-prompts-system-hardlock/fixtures.json
```

Observed result:

```json
{"status":"PASS","cases":16,"validator":"four_prompts_system_hardlock_validator.rb"}
```

The validator rejects:

- product `main`/`master` without exact production phrase;
- workflow action without impact audit;
- local prompt index as implementation;
- repeated blocked command retries;
- owner handoff for routine steps;
- fake Done without receipt/readback;
- direct shell bypass around AgentHub;
- PR171/gitleaks repeated merge loop.

## Safety and Scope

No product repository, production site, test site, staging site, workflow
dispatch, database, Docker, proxy, firewall, DNS, SSL, PM2, tmux, server/runtime
mutation, secret read, raw env dump, broad cleanup, branch-protection weakening,
or GitHub check bypass is part of this package.

## Current Terminal State

Repository package state: installed on isolated branch and validator-backed.

External closure state: not fully Done until PR/main readback and YouTrack Done
readback exist.

Typed blockers currently recorded:

- `GITHUB_BRANCH_PROTECTION_PLATFORM_GATE`
- `YOUTRACK_READBACK_UNAVAILABLE`
- `MCP_RECEIPT_REQUIRED_FOR_IMPLEMENTATION_DONE`

