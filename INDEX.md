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

## Default Agent Read Set

Read by default:

- `AGENTS.md`
- `INDEX.md`
- `context/agenthub-current-context-pack.md`
- task-specific active controls only

Do not bulk-read `reports/`, `reports/receipts/`, `reports/incidents`,
`reports/handoffs`, `reports/security`, `reports/apps`, `prompts`, or `apps` by
default. Reports are evidence, receipts are proof, and consumed prompts are not
replayable instructions.

Lifecycle states used below:

- `active_control`: current durable control.
- `current_context`: compact read-first context.
- `task_specific`: load only when the current task names it.
- `implemented_audit_only`: findings promoted; historical evidence only.
- `receipt_only`: proof only, never instruction.
- `consumed_prompt`: one-time executed prompt, `safe_to_replay=false`.
- `archived`, `quarantined`, `superseded`: retained but not default context.

| Artifact | Type | Source task | Status |
|---|---|---|---|
| `README.md` | repository overview | AH-494 | draft |
| `AGENTS.md` | Codex/AgentHub local policy | AH-494 | draft |
| `GOVERNANCE.md` | governance overview | AH-494 | draft |
| `SECURITY.md` | security policy | AH-494 | draft |
| `CHANGELOG.md` | changelog | AH-494 | draft |
| `context/agenthub-current-context-pack.md` | current context | AH-PR16-LIFECYCLE-CORRECTION-20260523 | current_context; read_by_default=true |
| `governance/task-first-policy.md` | governance policy | AH-494 | draft |
| `governance/done-gate-policy.md` | governance policy | AH-494 | draft |
| `governance/stale-prompt-quarantine.md` | governance policy | AH-494 | superseded by artifact lifecycle policy |
| `governance/artifact-lifecycle-and-retention-policy.md` | governance policy | AH-PR16-LIFECYCLE-CORRECTION-20260523 | active_control; read_by_default=true |
| `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` | bridge artifact | AH-495 | active |
| `governance/secret-protection-policy.md` | governance policy | AH-500 | active |
| `governance/agenthub-single-ingress-control.md` | governance control | AH-507 | active |
| `governance/teamlead-t0-emergency-stop-control.md` | governance control | AH-510 | active |
| `governance/agenthub-global-role-and-closure-control.md` | governance control | AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523 | active |
| `runbooks/chatgpt-github-connect.md` | runbook | AH-494 | draft |
| `runbooks/secret-leak-response.md` | runbook | AH-500 | active |
| `runbooks/agenthub-locked-run-recovery.md` | runbook | AH-507 | active |
| `runbooks/teamlead-t0-role-drift-emergency-stop.md` | runbook | AH-510 | active |
| `runbooks/agenthub-global-control-loop-closure.md` | runbook | AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523 | active |
| `templates/github/secret-scan-workflow.yml` | GitHub Actions template | AH-500 | active |
| `.github/workflows/secret-scan.yml` | control-spine workflow | AH-500 | active |
| `templates/security/gitleaks.toml` | scanner config template | AH-500 | active |
| `templates/git-hooks/pre-commit-secret-scan.sh` | git hook template | AH-500 | active |
| `templates/git-hooks/pre-push-secret-scan.sh` | git hook template | AH-500 | active |
| `prompts/security/teamlead-t0-github-secret-defense-rollout.txt` | reusable prompt | AH-500 | task_specific; safe_to_replay=false until conflict check |
| `prompts/apps/AH-507-chatgpt-control-app-implementation-prompt.md` | implementation prompt | AH-507 | consumed_prompt; safe_to_replay=false |
| `prompts/architecture/agenthub-global-control-spine-audit-and-repair.txt` | reusable prompt | AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523 | consumed_prompt; safe_to_replay=false |
| `apps/agenthub-chatgpt-control-app/` | Apps SDK / MCP prototype | AH-507 | pass |
| `reports/apps/AH-507-source-map.md` | source map | AH-507 | implemented_audit_only; read_by_default=false |
| `reports/apps/AH-507-chatgpt-control-app-adr.md` | architecture decision record | AH-507 | implemented_audit_only; read_by_default=false |
| `reports/apps/AH-507-validation-plan.md` | validation plan | AH-507 | implemented_audit_only; read_by_default=false |
| `reports/строй ремонт строя россия, отчетный блок.md` | self-audit and control improvement report | AH-509 | implemented_audit_only; read_by_default=false; promoted to global role/closure control |
| `reports/receipts/AH-494-github-repo-setup-receipt.md` | setup receipt | AH-494 | receipt_only; read_by_default=false |
| `reports/receipts/AH-495-org-control-spine-migration-receipt.md` | migration receipt | AH-495 | receipt_only; read_by_default=false |
| `reports/receipts/AH-500-github-secret-defense-rollout-receipt.md` | security rollout receipt | AH-500 | receipt_only; read_by_default=false |
| `reports/receipts/AH-501-secret-exclusion-finish-receipt.md` | security hygiene receipt | AH-501 | receipt_only; read_by_default=false |
| `reports/receipts/AH-507-chatgpt-control-app-bootstrap-receipt.md` | app bootstrap receipt | AH-507 | receipt_only; read_by_default=false |
| `reports/receipts/AH-507-chatgpt-control-app-closed-loop-receipt.md` | corrective incident receipt | AH-507 | receipt_only; read_by_default=false; superseded by final |
| `reports/receipts/AH-507-control-loop-recovery-receipt.md` | recovery receipt | AH-507 | receipt_only; read_by_default=false |
| `reports/receipts/AH-507-public-chatgpt-mcp-final-receipt.md` | final receipt | AH-507 | receipt_only; read_by_default=false |
| `reports/receipts/AH-510-t0-emergency-stop-control-receipt.md` | control repair receipt | AH-510 | receipt_only; read_by_default=false |
| `reports/write-proof/AH-507-chatgpt-control-app-write-proof.md` | write-proof status | AH-507 | receipt_only; read_by_default=false |
| `reports/security/AH-500-redacted-org-scan-summary.md` | redacted security scan summary | AH-500 | implemented_audit_only; read_by_default=false |
| `reports/security/AH-501-secret-exclusion-current-content-summary.md` | redacted repo hygiene summary | AH-501 | implemented_audit_only; read_by_default=false |
| `reports/architecture/agenthub-global-control-spine-audit.md` | architecture audit | AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523 | implemented_audit_only; read_by_default=false; promoted to global role/closure control |
| `reports/handoffs/2026-05-22-current-chat-handoff.md` | chat handoff report | Current ChatGPT Project dialogue | archived; read_by_default=false |
| `reports/incidents/AH-511-agent-cycle-self-critique.md` | incident postmortem | AH-511 | implemented_audit_only; read_by_default=false; promoted to global role/closure control and skills |
| `reports/receipts/agenthub-global-control-spine-audit-repair-receipt.md` | control repair receipt | AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523 | blocked-worker-route-closure |
| `skills-drafts/t0-non-authoring-gate/SKILL.md` | draft skill | AH-511 | draft |
| `skills-drafts/devops-incident-diagnostics/SKILL.md` | draft skill | AH-511 | draft |
| `skills-drafts/agenthub-evidence-loop-closure/SKILL.md` | draft skill | AH-511 | draft |
| `schemas/prompt-artifact.schema.json` | schema | AH-494 | draft |
| `schemas/report-receipt.schema.json` | schema | AH-494 | draft |
| `schemas/task-card.schema.json` | schema | AH-494 | draft |
| `schemas/secret-scan-receipt.schema.json` | schema | AH-500 | active |
| `schemas/agenthub-run-preflight.schema.json` | schema | AH-507/AH-510 | active |
| `schemas/t0-emergency-stop-receipt.schema.json` | schema | AH-510 | active |
| `schemas/agenthub-global-control-receipt.schema.json` | schema | AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523 | active |
| `schemas/task-service-payload-builder-contract.schema.json` | schema | AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523 | active |
| `schemas/service-dependency-graph.schema.json` | schema | AH-GLOBAL-CONTROL-SPINE-AUDIT-20260523 | active |
