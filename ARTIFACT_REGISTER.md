---
artifact_id: root-artifact-register
artifact_type: artifact-register
owner_role: T1 Architecture Broker
source_task: AH-CONTROL-SPINE-LIFECYCLE-20260523
created_at: 2026-05-23
last_reviewed_at: 2026-05-23
lifecycle_status: active
execution_status: pass
load_policy: default
safe_to_replay: false
supersedes: none
superseded_by: none
canonical_decision_ref: governance/artifact-lifecycle-policy.md
status: active
---

# Artifact Register

This register is the lifecycle metadata source for artifacts listed in
`INDEX.md`. `INDEX.md` remains a compact index; this file controls load policy,
replay safety, supersession, and canonical decision references.

| Artifact | Lifecycle | Execution | Load policy | Safe to replay | Superseded by | Canonical decision ref | Source task | Last reviewed | Owner role |
|---|---|---|---|---:|---|---|---|---|---|
| `README.md` | active | not_applicable | default | false | none | governance/control-spine-current-baseline.md | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `AGENTS.md` | active | not_applicable | default | false | none | governance/control-spine-current-baseline.md | AH-494 | 2026-05-23 | T0 Control Plane |
| `GOVERNANCE.md` | active | not_applicable | default | false | none | governance/control-spine-current-baseline.md | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `SECURITY.md` | active | not_applicable | task_specific | false | none | governance/secret-protection-policy.md | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `CHANGELOG.md` | active | not_applicable | task_specific | false | none | none | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `INDEX.md` | active | not_applicable | default | false | none | ARTIFACT_REGISTER.md | AH-494 | 2026-05-23 | T0 Control Plane |
| `ARTIFACT_REGISTER.md` | active | pass | default | false | none | governance/artifact-lifecycle-policy.md | AH-CONTROL-SPINE-LIFECYCLE-20260523 | 2026-05-23 | T1 Architecture Broker |
| `context-packs/default-agenthub-control-spine.md` | active | pass | default | false | none | governance/control-spine-current-baseline.md | AH-CONTROL-SPINE-LIFECYCLE-20260523 | 2026-05-23 | T1 Architecture Broker |
| `governance/task-first-policy.md` | active | not_applicable | task_specific | false | none | governance/control-spine-current-baseline.md | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `governance/done-gate-policy.md` | active | not_applicable | task_specific | false | none | governance/control-spine-current-baseline.md | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `governance/stale-prompt-quarantine.md` | superseded | not_applicable | audit_only | false | governance/artifact-lifecycle-policy.md | governance/artifact-lifecycle-policy.md | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `governance/artifact-lifecycle-policy.md` | active | pass | default | false | none | governance/control-spine-current-baseline.md | AH-CONTROL-SPINE-LIFECYCLE-20260523 | 2026-05-23 | T1 Architecture Broker |
| `governance/control-spine-current-baseline.md` | active | pass | default | false | none | self | AH-CONTROL-SPINE-LIFECYCLE-20260523 | 2026-05-23 | T1 Architecture Broker |
| `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` | active | not_applicable | default | false | none | governance/control-spine-current-baseline.md | AH-495 | 2026-05-23 | T1 Architecture Broker |
| `governance/secret-protection-policy.md` | active | pass | task_specific | false | none | SECURITY.md | AH-500 | 2026-05-23 | T1 Architecture Broker |
| `governance/agenthub-single-ingress-control.md` | active | pass | task_specific | false | none | governance/control-spine-current-baseline.md | AH-507 | 2026-05-23 | T1 Architecture Broker |
| `governance/teamlead-t0-emergency-stop-control.md` | active | pass | task_specific | false | none | governance/control-spine-current-baseline.md | AH-510 | 2026-05-23 | T1 Architecture Broker |
| `runbooks/chatgpt-github-connect.md` | candidate | draft | task_specific | true | none | governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `runbooks/secret-leak-response.md` | active | pass | task_specific | true | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | T1 Architecture Broker |
| `runbooks/agenthub-locked-run-recovery.md` | active | pass | task_specific | true | none | governance/agenthub-single-ingress-control.md | AH-507 | 2026-05-23 | T1 Architecture Broker |
| `runbooks/teamlead-t0-role-drift-emergency-stop.md` | active | pass | task_specific | true | none | governance/teamlead-t0-emergency-stop-control.md | AH-510 | 2026-05-23 | T1 Architecture Broker |
| `runbooks/control-spine-inventory-and-quarantine.md` | active | pass | task_specific | true | none | governance/artifact-lifecycle-policy.md | AH-CONTROL-SPINE-LIFECYCLE-20260523 | 2026-05-23 | T1 Architecture Broker |
| `templates/github/secret-scan-workflow.yml` | active | pass | task_specific | false | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | Worker |
| `.github/workflows/secret-scan.yml` | active | pass | task_specific | false | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | Worker |
| `templates/security/gitleaks.toml` | active | pass | task_specific | false | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | Worker |
| `templates/git-hooks/pre-commit-secret-scan.sh` | active | pass | task_specific | false | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | Worker |
| `templates/git-hooks/pre-push-secret-scan.sh` | active | pass | task_specific | false | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | Worker |
| `prompts/security/teamlead-t0-github-secret-defense-rollout.txt` | implemented | pass | task_specific | false | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | T1 Architecture Broker |
| `prompts/apps/AH-507-chatgpt-control-app-implementation-prompt.md` | implemented | pass | task_specific | false | none | reports/apps/AH-507-chatgpt-control-app-adr.md | AH-507 | 2026-05-23 | T1 Architecture Broker |
| `apps/agenthub-chatgpt-control-app/` | implemented | partial | task_specific | false | none | reports/apps/AH-507-chatgpt-control-app-adr.md | AH-507 | 2026-05-23 | Worker |
| `reports/apps/AH-507-source-map.md` | implemented | pass | audit_only | false | none | reports/apps/AH-507-chatgpt-control-app-adr.md | AH-507 | 2026-05-23 | Verifier |
| `reports/apps/AH-507-chatgpt-control-app-adr.md` | implemented | pass | audit_only | false | none | governance/agenthub-single-ingress-control.md | AH-507 | 2026-05-23 | T1 Architecture Broker |
| `reports/apps/AH-507-validation-plan.md` | implemented | pass | audit_only | false | none | reports/receipts/AH-507-public-chatgpt-mcp-final-receipt.md | AH-507 | 2026-05-23 | Verifier |
| `reports/строй ремонт строя россия, отчетный блок.md` | implemented | pass | audit_only | false | governance/control-spine-current-baseline.md | governance/control-spine-current-baseline.md | AH-509 | 2026-05-23 | Verifier |
| `reports/receipts/AH-494-github-repo-setup-receipt.md` | superseded | pass | audit_only | false | reports/receipts/AH-495-org-control-spine-migration-receipt.md | governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt | AH-494 | 2026-05-23 | Verifier |
| `reports/receipts/AH-495-org-control-spine-migration-receipt.md` | implemented | pass | audit_only | false | none | governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt | AH-495 | 2026-05-23 | Verifier |
| `reports/receipts/AH-500-github-secret-defense-rollout-receipt.md` | implemented | partial | audit_only | false | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | Verifier |
| `reports/receipts/AH-501-secret-exclusion-finish-receipt.md` | implemented | pass | audit_only | false | none | governance/secret-protection-policy.md | AH-501 | 2026-05-23 | Verifier |
| `reports/receipts/AH-507-chatgpt-control-app-bootstrap-receipt.md` | implemented | partial | audit_only | false | reports/receipts/AH-507-public-chatgpt-mcp-final-receipt.md | reports/apps/AH-507-chatgpt-control-app-adr.md | AH-507 | 2026-05-23 | Verifier |
| `reports/receipts/AH-507-chatgpt-control-app-closed-loop-receipt.md` | superseded | blocked | audit_only | false | reports/receipts/AH-507-public-chatgpt-mcp-final-receipt.md | governance/agenthub-single-ingress-control.md | AH-507 | 2026-05-23 | Verifier |
| `reports/receipts/AH-507-control-loop-recovery-receipt.md` | implemented | pass | audit_only | false | reports/receipts/AH-507-public-chatgpt-mcp-final-receipt.md | governance/agenthub-single-ingress-control.md | AH-507 | 2026-05-23 | Verifier |
| `reports/receipts/AH-507-public-chatgpt-mcp-final-receipt.md` | implemented | pass | audit_only | false | none | reports/apps/AH-507-chatgpt-control-app-adr.md | AH-507 | 2026-05-23 | Verifier |
| `reports/receipts/AH-510-t0-emergency-stop-control-receipt.md` | implemented | pass | audit_only | false | none | governance/teamlead-t0-emergency-stop-control.md | AH-510 | 2026-05-23 | Verifier |
| `reports/receipts/control-spine-lifecycle-repair-receipt.md` | implemented | pass | audit_only | false | none | governance/artifact-lifecycle-policy.md | AH-CONTROL-SPINE-LIFECYCLE-20260523 | 2026-05-23 | Verifier |
| `reports/write-proof/AH-507-chatgpt-control-app-write-proof.md` | implemented | pass | audit_only | false | none | reports/receipts/AH-507-public-chatgpt-mcp-final-receipt.md | AH-507 | 2026-05-23 | Verifier |
| `reports/security/AH-500-redacted-org-scan-summary.md` | implemented | pass | audit_only | false | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | Verifier |
| `reports/security/AH-501-secret-exclusion-current-content-summary.md` | implemented | pass | audit_only | false | none | governance/secret-protection-policy.md | AH-501 | 2026-05-23 | Verifier |
| `reports/handoffs/2026-05-22-current-chat-handoff.md` | archived | not_applicable | audit_only | false | none | governance/control-spine-current-baseline.md | Current ChatGPT Project dialogue | 2026-05-23 | Verifier |
| `reports/incidents/AH-511-agent-cycle-self-critique.md` | implemented | pass | audit_only | false | governance/control-spine-current-baseline.md | governance/control-spine-current-baseline.md | AH-511 | 2026-05-23 | Verifier |
| `skills-drafts/t0-non-authoring-gate/SKILL.md` | candidate | draft | task_specific | false | none | governance/teamlead-t0-emergency-stop-control.md | AH-511 | 2026-05-23 | T1 Architecture Broker |
| `skills-drafts/devops-incident-diagnostics/SKILL.md` | candidate | draft | task_specific | false | none | reports/incidents/AH-511-agent-cycle-self-critique.md | AH-511 | 2026-05-23 | T1 Architecture Broker |
| `skills-drafts/agenthub-evidence-loop-closure/SKILL.md` | candidate | draft | task_specific | false | none | reports/incidents/AH-511-agent-cycle-self-critique.md | AH-511 | 2026-05-23 | T1 Architecture Broker |
| `schemas/prompt-artifact.schema.json` | candidate | draft | task_specific | false | none | governance/artifact-lifecycle-policy.md | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `schemas/report-receipt.schema.json` | candidate | draft | task_specific | false | none | governance/artifact-lifecycle-policy.md | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `schemas/task-card.schema.json` | candidate | draft | task_specific | false | none | governance/task-first-policy.md | AH-494 | 2026-05-23 | T1 Architecture Broker |
| `schemas/secret-scan-receipt.schema.json` | active | pass | task_specific | false | none | governance/secret-protection-policy.md | AH-500 | 2026-05-23 | T1 Architecture Broker |
| `schemas/agenthub-run-preflight.schema.json` | active | pass | task_specific | false | none | governance/agenthub-single-ingress-control.md | AH-507/AH-510 | 2026-05-23 | T1 Architecture Broker |
| `schemas/t0-emergency-stop-receipt.schema.json` | active | pass | task_specific | false | none | governance/teamlead-t0-emergency-stop-control.md | AH-510 | 2026-05-23 | T1 Architecture Broker |
| `schemas/artifact-lifecycle.schema.json` | active | pass | task_specific | false | none | governance/artifact-lifecycle-policy.md | AH-CONTROL-SPINE-LIFECYCLE-20260523 | 2026-05-23 | T1 Architecture Broker |
