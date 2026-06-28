---
artifact_id: AH-785-permanent-done-gate-hardlock-receipt-20260613
artifact_type: operational_receipt
source_task: AH-785
run_id: permanent-done-gate-hardlock-20260613
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# AH-785 Permanent Done Gate Hardlock Receipt

## Installed Controls

- `governance/agent-cycle-done-evidence-hardlock-policy.md`
- `schemas/done_evidence_tuple.schema.json`
- `validators/done_evidence_hardlock_validator.rb`
- `evals/done-evidence-hardlock/fixtures.json`
- `youtrack-workflows/agenthub-done-evidence-state-machine.js`
- `prompts/templates/agent-cycle-done-evidence-hardlock-template.txt`
- `reports/validations/AH-785-permanent-done-gate-hardlock-validation-20260613.md`

## Official Documentation Packet

- OpenAI Codex sandboxing: https://developers.openai.com/codex/concepts/sandboxing
- OpenAI Codex agent approvals/security: https://developers.openai.com/codex/agent-approvals-security
- OpenAI Codex skills: https://developers.openai.com/codex/skills
- OpenAI Codex rules/configuration: https://developers.openai.com/codex/rules
- JetBrains YouTrack workflow rules: https://www.jetbrains.com/help/youtrack/server/workflow-rules.html
- JetBrains YouTrack state-machine rules: https://www.jetbrains.com/help/youtrack/devportal/state-machine-per-issue-type.html
- GitHub branch protection: https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule
- GitHub CODEOWNERS: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners

## Evidence

RUN_ID: `permanent-done-gate-hardlock-20260613`
Task: `AH-785`
Rollback branch: `backup/agenthub-permanent-done-gate-hardlock-20260613`
Work branch: `agenthub/permanent-done-gate-hardlock-20260613`
Secret redaction: no secrets, raw env, keys, or credential values were read or stored.

## Redteam

The fixture suite blocks fake Done, weak proof, PR-only Done, report-only Done, owner-closed without exact command, parent-child closure violations, stale artifact replay, T0 direct authorship, and non-terminal progress reports.

## Residuals

Live installation of the YouTrack workflow source is a separate task-bound deployment action. This repository package is installed as source-controlled workflow artifact and validator package.
