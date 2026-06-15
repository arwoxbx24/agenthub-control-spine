---
artifact_id: AH-FOUR-PROMPTS-claim-ledger-20260615
artifact_type: truth-redteam-claim-ledger
owner_role: Verifier
source_task: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
run_id: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
created_at: 2026-06-15
lifecycle_status: claim-ledger
default_load: false
safe_to_replay: false
---

# Four Prompts Claim Ledger

| Claim | Required evidence | Actual evidence | Verdict |
|---|---|---|---|
| Four source prompts exist | folder listing | four `.txt` files in prompt architect folder | PROVEN |
| Quick index artifacts are not implementation | absence after cleanup | only four source prompts remain in prompt folder | PROVEN |
| Primary hardlock policy installed | policy file | `governance/four-prompts-system-hardlock-policy.md` | PROVEN |
| Required schemas installed | seven schema files | `schemas/*classification*`, workflow, test-only, prod release, owner signal, rollback, receipt | PROVEN |
| Deterministic validator installed | validator file | `validators/four_prompts_system_hardlock_validator.rb` | PROVEN |
| Positive/negative fixtures installed | fixture file | `evals/four-prompts-system-hardlock/fixtures.json` | PROVEN |
| Owner distress supplement covered | policy and validator cases | owner incident section and fixtures | PROVEN |
| PR171/gitleaks point-fix covered | policy and validator cases | PR171 section and gitleaks fixtures | PROVEN |
| Validator pass achieved | validator output | four-prompts validator PASS 16 cases; owner-distress validator PASS 14 cases | PROVEN |
| Full Done achieved | task readback, PR/merge, register coverage | task service/evidence attach and PR lifecycle are still blocked | BLOCKED |

Final truth status: repository package can be installed and validated locally,
but global Done is blocked until task-service readback and PR lifecycle evidence
exist.
