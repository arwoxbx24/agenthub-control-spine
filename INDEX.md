---
artifact_id: root-index
artifact_type: artifact-index
owner_role: T0 Control Plane
source_task: AH-494
created_at: 2026-05-22
supersedes: none
status: draft
---

# Artifact Index

| Artifact | Type | Source task | Status |
|---|---|---|---|
| `README.md` | repository overview | AH-494 | draft |
| `AGENTS.md` | Codex/AgentHub local policy | AH-494 | draft |
| `GOVERNANCE.md` | governance overview | AH-494 | draft |
| `SECURITY.md` | security policy | AH-494 | draft |
| `CHANGELOG.md` | changelog | AH-494 | draft |
| `governance/task-first-policy.md` | governance policy | AH-494 | draft |
| `governance/done-gate-policy.md` | governance policy | AH-494 | draft |
| `governance/stale-prompt-quarantine.md` | governance policy | AH-494 | draft |
| `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` | bridge artifact | AH-495 | active |
| `governance/secret-protection-policy.md` | governance policy | AH-500 | active |
| `governance/agenthub-single-ingress-control.md` | governance control | AH-507 | active |
| `runbooks/chatgpt-github-connect.md` | runbook | AH-494 | draft |
| `runbooks/secret-leak-response.md` | runbook | AH-500 | active |
| `runbooks/agenthub-locked-run-recovery.md` | runbook | AH-507 | active |
| `templates/github/secret-scan-workflow.yml` | GitHub Actions template | AH-500 | active |
| `.github/workflows/secret-scan.yml` | control-spine workflow | AH-500 | active |
| `templates/security/gitleaks.toml` | scanner config template | AH-500 | active |
| `templates/git-hooks/pre-commit-secret-scan.sh` | git hook template | AH-500 | active |
| `templates/git-hooks/pre-push-secret-scan.sh` | git hook template | AH-500 | active |
| `prompts/security/teamlead-t0-github-secret-defense-rollout.txt` | reusable prompt | AH-500 | active |
| `prompts/apps/AH-507-chatgpt-control-app-implementation-prompt.md` | implementation prompt | AH-507 | active |
| `apps/agenthub-chatgpt-control-app/` | Apps SDK / MCP prototype | AH-507 | partial |
| `reports/apps/AH-507-source-map.md` | source map | AH-507 | active |
| `reports/apps/AH-507-chatgpt-control-app-adr.md` | architecture decision record | AH-507 | active |
| `reports/apps/AH-507-validation-plan.md` | validation plan | AH-507 | active |
| `reports/receipts/AH-494-github-repo-setup-receipt.md` | setup receipt | AH-494 | draft |
| `reports/receipts/AH-495-org-control-spine-migration-receipt.md` | migration receipt | AH-495 | active |
| `reports/receipts/AH-500-github-secret-defense-rollout-receipt.md` | security rollout receipt | AH-500 | partial-with-blockers |
| `reports/receipts/AH-501-secret-exclusion-finish-receipt.md` | security hygiene receipt | AH-501 | pass |
| `reports/receipts/AH-507-chatgpt-control-app-bootstrap-receipt.md` | app bootstrap receipt | AH-507 | partial |
| `reports/receipts/AH-507-chatgpt-control-app-closed-loop-receipt.md` | corrective incident receipt | AH-507 | blocked |
| `reports/receipts/AH-507-control-loop-recovery-receipt.md` | recovery receipt | AH-507 | recovered-control-loop |
| `reports/write-proof/AH-507-chatgpt-control-app-write-proof.md` | write-proof status | AH-507 | blocked |
| `reports/security/AH-500-redacted-org-scan-summary.md` | redacted security scan summary | AH-500 | active |
| `reports/security/AH-501-secret-exclusion-current-content-summary.md` | redacted repo hygiene summary | AH-501 | pass |
| `reports/handoffs/2026-05-22-current-chat-handoff.md` | chat handoff report | Current ChatGPT Project dialogue | active |
| `schemas/prompt-artifact.schema.json` | schema | AH-494 | draft |
| `schemas/report-receipt.schema.json` | schema | AH-494 | draft |
| `schemas/task-card.schema.json` | schema | AH-494 | draft |
| `schemas/secret-scan-receipt.schema.json` | schema | AH-500 | active |
| `schemas/agenthub-run-preflight.schema.json` | schema | AH-507 | active |
