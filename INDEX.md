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
| `AGENTS.md` | Codex/AgentHub local policy | AH-494/AH-534 | draft |
| `ARTIFACT_REGISTER.md` | artifact lifecycle/default-load register | AH-522/AH-534 | active |
| `PR_QUEUE_REGISTER.md` | PR queue decision register | AH-523/AH-534 | active |
| `context/agenthub-current-context-pack.md` | current default context pack | AH-523 | active |
| `GOVERNANCE.md` | governance overview | AH-494 | draft |
| `SECURITY.md` | security policy | AH-494 | draft |
| `CHANGELOG.md` | changelog | AH-494/AH-534 | draft |
| `governance/task-first-policy.md` | governance policy | AH-494 | draft |
| `governance/done-gate-policy.md` | governance policy | AH-494 | draft |
| `governance/stale-prompt-quarantine.md` | governance policy | AH-494 | draft |
| `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` | bridge artifact | AH-495 | active |
| `governance/secret-protection-policy.md` | governance policy | AH-500 | active |
| `governance/agenthub-single-ingress-control.md` | governance control | AH-507 | active |
| `governance/teamlead-t0-emergency-stop-control.md` | governance control | AH-510 | active |
| `governance/t0-t1-role-matrix.md` | governance control | AH-511 | active |
| `governance/anti-fabrication-policy.md` | governance policy | AH-511 | active |
| `governance/dangerous-action-policy.md` | governance policy | AH-511 | active |
| `governance/token-context-budget.md` | governance policy | AH-511 | active |
| `governance/control-spine-registrar-policy.md` | governance policy | AH-523 | active |
| `governance/cyber-safe-prompt-wording-policy.md` | governance policy | AH-528 | active |
| `governance/agent-output-and-link-intake-control.md` | governance policy | AH-529 | active |
| `governance/external-repo-pattern-adaptation-roadmap.md` | architecture decision | AH-530 | active |
| `governance/agenthub-only-execution-discipline.md` | governance control | AH-534 | active |
| `runbooks/chatgpt-github-connect.md` | runbook | AH-494 | draft |
| `runbooks/secret-leak-response.md` | runbook | AH-500 | active |
| `runbooks/agenthub-locked-run-recovery.md` | runbook | AH-507 | active |
| `runbooks/teamlead-t0-role-drift-emergency-stop.md` | runbook | AH-510 | active |
| `runbooks/prompt-intake-flow.md` | runbook | AH-494 | active |
| `runbooks/codex-cli-usage.md` | runbook | AH-494 | active |
| `runbooks/control-spine-pr-queue-and-artifact-lifecycle.md` | runbook | AH-523 | active |
| `runbooks/agent-shortlink-intake-and-report-placement.md` | runbook | AH-529 | active |
| `runbooks/agenthub-only-violation-response.md` | runbook | AH-534 | active |
| `templates/github/secret-scan-workflow.yml` | GitHub Actions template | AH-500 | active |
| `.github/workflows/secret-scan.yml` | control-spine workflow | AH-500 | active |
| `templates/security/gitleaks.toml` | scanner config template | AH-500 | active |
| `templates/git-hooks/pre-commit-secret-scan.sh` | git hook template | AH-500 | active |
| `templates/git-hooks/pre-push-secret-scan.sh` | git hook template | AH-500 | active |
| `prompts/security/teamlead-t0-github-secret-defense-rollout.txt` | reusable prompt | AH-500 | active |
| `prompts/apps/AH-507-chatgpt-control-app-implementation-prompt.md` | implementation prompt | AH-507 | active |
| `prompts/implementation/anthropic-knowledge-work-pattern-adaptation-worker.txt` | implementation brief | AH-531 | active |
| `prompts/implementation/microsoft-ai-engineering-coach-pattern-adaptation-worker.txt` | implementation brief | AH-532 | active |
| `apps/agenthub-chatgpt-control-app/` | Apps SDK / MCP prototype | AH-507 | pass |
| `reports/apps/AH-507-source-map.md` | source map | AH-507 | active |
| `reports/apps/AH-507-chatgpt-control-app-adr.md` | architecture decision record | AH-507 | active |
| `reports/apps/AH-507-validation-plan.md` | validation plan | AH-507 | active |
| `reports/строй ремонт строя россия, отчетный блок.md` | self-audit and control improvement report | AH-509 | active |
| `reports/receipts/AH-494-github-repo-setup-receipt.md` | setup receipt | AH-494 | draft |
| `reports/receipts/AH-495-org-control-spine-migration-receipt.md` | migration receipt | AH-495 | active |
| `reports/receipts/AH-500-github-secret-defense-rollout-receipt.md` | security rollout receipt | AH-500 | partial-with-blockers |
| `reports/receipts/AH-501-secret-exclusion-finish-receipt.md` | security hygiene receipt | AH-501 | pass |
| `reports/receipts/AH-507-chatgpt-control-app-bootstrap-receipt.md` | app bootstrap receipt | AH-507 | partial |
| `reports/receipts/AH-507-chatgpt-control-app-closed-loop-receipt.md` | corrective incident receipt | AH-507 | superseded-by-final |
| `reports/receipts/AH-507-control-loop-recovery-receipt.md` | recovery receipt | AH-507 | recovered-control-loop |
| `reports/receipts/AH-507-public-chatgpt-mcp-final-receipt.md` | final receipt | AH-507 | pass |
| `reports/receipts/AH-510-t0-emergency-stop-control-receipt.md` | control repair receipt | AH-510 | control-repair-recorded |
| `reports/write-proof/AH-507-chatgpt-control-app-write-proof.md` | write-proof status | AH-507 | pass |
| `reports/security/AH-500-redacted-org-scan-summary.md` | redacted security scan summary | AH-500 | active |
| `reports/security/AH-501-secret-exclusion-current-content-summary.md` | redacted repo hygiene summary | AH-501 | pass |
| `reports/handoffs/2026-05-22-current-chat-handoff.md` | chat handoff report | Current ChatGPT Project dialogue | active |
| `reports/incidents/AH-511-agent-cycle-self-critique.md` | incident postmortem | AH-511 | active |
| `reports/incidents/AH-526-session-failure-report.md` | incident postmortem | AH-526 | audit-only |
| `reports/devops/mtproxy-domain-route-worker-20260523.md` | devops worker report | AH-468 | pass |
| `reports/receipts/mtproxy-domain-route-worker-receipt-20260523.md` | operational receipt | AH-468 | pass |
| `reports/devops/npm-docker-domain-route-ah513-ah518-20260523.md` | devops worker report | AH-513/AH-518 | partial-with-blocker |
| `reports/receipts/npm-docker-domain-route-ah513-ah518-receipt-20260523.md` | operational receipt | AH-513/AH-518 | partial-with-blocker |
| `reports/control-spine/teamlead-system-inventory-20260524.md` | control-spine inventory report | AH-522 | operational-receipt |
| `reports/receipts/teamlead-system-inventory-receipt-20260524.md` | control-spine inventory receipt | AH-522 | operational-receipt |
| `reports/receipts/control-spine-pr-queue-cleanup-receipt-20260524.md` | control-spine registrar receipt | AH-523 | operational-receipt |
| `reports/receipts/AH-526-session-failure-report-receipt.md` | incident report placement receipt | AH-526 | pass |
| `reports/research/external-agent-framework-pattern-audit-20260524.md` | external framework pattern research report | AH-527 | research-done |
| `reports/receipts/external-agent-framework-pattern-audit-receipt-20260524.md` | external framework pattern research receipt | AH-527 | pass |
| `reports/receipts/cyber-safe-prompt-wording-receipt-20260524.md` | cyber-safe prompt wording receipt | AH-528 | pass |
| `reports/receipts/AH-529-agent-output-link-intake-repair-receipt.md` | agent output/link intake repair receipt | AH-529 | pass |
| `reports/receipts/external-repo-pattern-adaptation-closed-loop-receipt.md` | external pattern adaptation receipt | AH-530 | pass |
| `reports/receipts/AH-533-git-route-policy-receipt.md` | Git/GitHub route policy receipt | AH-533 | pass |
| `reports/receipts/AH-534-agenthub-only-execution-discipline-receipt.md` | AgentHub-only execution discipline receipt | AH-534 | pass |
| `registries/agenthub-control-spine-id-register.md` | AgentHub/YouTrack/GitHub ID register | AH-522 | active |
| `skills-drafts/t0-non-authoring-gate/SKILL.md` | draft skill | AH-511 | draft |
| `skills-drafts/devops-incident-diagnostics/SKILL.md` | draft skill | AH-511 | draft |
| `skills-drafts/agenthub-evidence-loop-closure/SKILL.md` | draft skill | AH-511 | draft |
| `skills-drafts/agenthub-only-execution-boundary/SKILL.md` | draft skill | AH-534 | draft |
| `schemas/prompt-artifact.schema.json` | schema | AH-494 | draft |
| `schemas/report-receipt.schema.json` | schema | AH-494 | draft |
| `schemas/task-card.schema.json` | schema | AH-494 | draft |
| `schemas/secret-scan-receipt.schema.json` | schema | AH-500 | active |
| `schemas/agenthub-run-preflight.schema.json` | schema | AH-507/AH-510 | active |
| `schemas/t0-emergency-stop-receipt.schema.json` | schema | AH-510 | active |
| `schemas/control-spine-pr-queue-register.schema.json` | schema | AH-523 | active |
| `schemas/agent-output-quality-receipt.schema.json` | schema | AH-529 | active |
| `schemas/agenthub-only-execution-receipt.schema.json` | schema | AH-534 | active |
