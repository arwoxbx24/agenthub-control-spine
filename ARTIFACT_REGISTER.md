---
artifact_id: artifact-register
artifact_type: lifecycle-register
owner_role: T0 Control Plane
source_task: AH-522
run_id: RUN-teamlead-control-spine-system-inventory-20260524
created_at: 2026-05-24
lifecycle_status: current_baseline
default_load: true
safe_to_replay: false
---

# Artifact Register

This register is the lifecycle and default-load layer for the control-spine
repository. `INDEX.md` lists artifacts. This file tells agents whether an
artifact is current instruction, current register/baseline, evidence only,
historical receipt, consumed prompt, quarantined material, or superseded state.

Reports are evidence, not standing instructions. Receipts are proof, not
prompts. One-time prompts are not safe to replay unless a current governance
artifact explicitly says so.

Canonical lifecycle values in this register:

- `current_policy`
- `active_control`
- `current_context_pack`
- `current_baseline`
- `operational_receipt`
- `audit_only`
- `superseded`
- `quarantine`
- `deleted_policy_violation`

Compatibility states from older records remain readable: `active_policy`,
`active_runbook`, `historical_receipt`, `consumed_prompt`, and `quarantined`.

| Artifact | Lifecycle | Default load | Safe to replay | Source task | Notes |
|---|---|---:|---:|---|---|
| `README.md` | `current_baseline` | true | false | AH-494 | Repository overview. |
| `AGENTS.md` | `active_policy` | true | false | AH-494 | Read-first local policy. |
| `INDEX.md` | `current_baseline` | true | false | AH-494 | Artifact path index. |
| `ARTIFACT_REGISTER.md` | `current_baseline` | true | false | AH-522 | Lifecycle/default-load register. |
| `PR_QUEUE_REGISTER.md` | `current_baseline` | true | false | AH-523 | PR queue/register decisions. |
| `context/agenthub-current-context-pack.md` | `current_context_pack` | true | false | AH-523 | Only default context pack. |
| `GOVERNANCE.md` | `active_policy` | true | false | AH-494 | Governance overview. |
| `SECURITY.md` | `active_policy` | false | false | AH-494 | Security policy. |
| `CHANGELOG.md` | `audit_only` | false | false | AH-494 | Change history. |
| `governance/task-first-policy.md` | `active_policy` | false | false | AH-494 | Task-first control. |
| `governance/done-gate-policy.md` | `active_policy` | false | false | AH-494 | Done gate control. |
| `governance/stale-prompt-quarantine.md` | `active_policy` | false | false | AH-494 | Stale prompt guard. |
| `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` | `active_policy` | false | false | AH-495 | GitHub/YouTrack/AgentHub boundary. |
| `governance/secret-protection-policy.md` | `active_policy` | false | false | AH-500 | Secret protection policy. |
| `governance/agenthub-single-ingress-control.md` | `active_policy` | false | false | AH-507 | Single-ingress control. |
| `governance/teamlead-t0-emergency-stop-control.md` | `active_policy` | false | false | AH-510 | T0 emergency stop control. |
| `governance/t0-t1-role-matrix.md` | `active_policy` | false | false | AH-511 | Role-boundary matrix. |
| `governance/anti-fabrication-policy.md` | `active_policy` | false | false | AH-511 | Anti-fabrication control. |
| `governance/dangerous-action-policy.md` | `active_policy` | false | false | AH-511 | Dangerous action boundary. |
| `governance/token-context-budget.md` | `active_policy` | false | false | AH-511 | Token/context budget control. |
| `governance/control-spine-registrar-policy.md` | `current_policy` | false | false | AH-523 | Registrar authority and lifecycle model. |
| `governance/cyber-safe-prompt-wording-policy.md` | `active_policy` | false | false | AH-528 | Authorized defensive-maintenance wording gate for cyber-adjacent prompts. |
| `governance/agent-output-and-link-intake-control.md` | `active_policy` | false | false | AH-529 | Report placement, short-link intake, final output, and Done guard control. |
| `governance/external-repo-pattern-adaptation-roadmap.md` | `active_policy` | false | false | AH-530 | Pattern-only adaptation roadmap for AH-527 research. |
| `governance/agenthub-skill-pack-command-connector-patterns.md` | `active_policy` | false | false | AH-531 | AgentHub-local skill-pack, command, and connector pattern control. |
| `governance/agenthub-eval-context-health-patterns.md` | `active_policy` | false | false | AH-532 | AgentHub-local eval, context-health, token-loop, and skill-discovery control. |
| `runbooks/chatgpt-github-connect.md` | `active_runbook` | false | false | AH-494 | Task-specific runbook. |
| `runbooks/secret-leak-response.md` | `active_runbook` | false | false | AH-500 | Secret leak runbook. |
| `runbooks/agenthub-locked-run-recovery.md` | `active_runbook` | false | false | AH-507 | Locked-run recovery. |
| `runbooks/teamlead-t0-role-drift-emergency-stop.md` | `active_runbook` | false | false | AH-510 | T0 drift stop runbook. |
| `runbooks/prompt-intake-flow.md` | `active_runbook` | false | false | AH-494 | Prompt intake runbook. |
| `runbooks/codex-cli-usage.md` | `active_runbook` | false | false | AH-494 | Codex CLI usage runbook. |
| `runbooks/control-spine-pr-queue-and-artifact-lifecycle.md` | `active_control` | false | false | AH-523 | Registrar queue/lifecycle runbook. |
| `runbooks/agent-shortlink-intake-and-report-placement.md` | `active_control` | false | false | AH-529 | Short-link stale-index and report placement runbook. |
| `runbooks/agenthub-pattern-adaptation-control-loop.md` | `active_control` | false | false | AH-531/AH-532 | External pattern adaptation control loop; no runtime mutation. |
| `templates/github/secret-scan-workflow.yml` | `active_policy` | false | false | AH-500 | Security workflow template. |
| `.github/workflows/secret-scan.yml` | `active_policy` | false | false | AH-500 | Control-spine secret-scan workflow. |
| `templates/security/gitleaks.toml` | `active_policy` | false | false | AH-500 | Scanner config. |
| `templates/git-hooks/pre-commit-secret-scan.sh` | `active_policy` | false | false | AH-500 | Local hook template. |
| `templates/git-hooks/pre-push-secret-scan.sh` | `active_policy` | false | false | AH-500 | Local hook template. |
| `prompts/security/teamlead-t0-github-secret-defense-rollout.txt` | `consumed_prompt` | false | false | AH-500 | Executed rollout prompt, not default instruction. |
| `prompts/apps/AH-507-chatgpt-control-app-implementation-prompt.md` | `consumed_prompt` | false | false | AH-507 | One-time implementation prompt. |
| `prompts/implementation/anthropic-knowledge-work-pattern-adaptation-worker.txt` | `active_control` | false | false | AH-531 | Future worker brief; no external install or runtime mutation. |
| `prompts/implementation/microsoft-ai-engineering-coach-pattern-adaptation-worker.txt` | `active_control` | false | false | AH-532 | Future worker brief; privacy-preserving eval adaptation only. |
| `apps/agenthub-chatgpt-control-app/` | `audit_only` | false | false | AH-507 | Prototype app artifact, not governance instruction. |
| `reports/apps/AH-507-source-map.md` | `audit_only` | false | false | AH-507 | Historical source map. |
| `reports/apps/AH-507-chatgpt-control-app-adr.md` | `audit_only` | false | false | AH-507 | Historical ADR unless explicitly requested. |
| `reports/apps/AH-507-validation-plan.md` | `audit_only` | false | false | AH-507 | Historical validation plan. |
| `reports/строй ремонт строя россия, отчетный блок.md` | `audit_only` | false | false | AH-509 | Findings promoted to governance; not default context. |
| `reports/incidents/AH-511-agent-cycle-self-critique.md` | `audit_only` | false | false | AH-511 | Findings promoted to governance/skills; not default context. |
| `reports/incidents/AH-526-session-failure-report.md` | `audit_only` | false | false | AH-526 | Incident postmortem; evidence only, not default instruction. |
| `reports/handoffs/2026-05-22-current-chat-handoff.md` | `audit_only` | false | false | Current ChatGPT Project dialogue | Handoff evidence only. |
| `reports/security/AH-500-redacted-org-scan-summary.md` | `audit_only` | false | false | AH-500 | Redacted evidence summary. |
| `reports/security/AH-501-secret-exclusion-current-content-summary.md` | `audit_only` | false | false | AH-501 | Redacted evidence summary. |
| `reports/devops/mtproxy-domain-route-worker-20260523.md` | `audit_only` | false | false | AH-468 | Domain worker report, not global instruction. |
| `reports/devops/npm-docker-domain-route-ah513-ah518-20260523.md` | `audit_only` | false | false | AH-513/AH-518 | Domain worker report, not global instruction. |
| `reports/write-proof/AH-507-chatgpt-control-app-write-proof.md` | `historical_receipt` | false | false | AH-507 | Write proof only. |
| `reports/receipts/AH-494-github-repo-setup-receipt.md` | `historical_receipt` | false | false | AH-494 | Receipt only. |
| `reports/receipts/AH-495-org-control-spine-migration-receipt.md` | `historical_receipt` | false | false | AH-495 | Receipt only. |
| `reports/receipts/AH-500-github-secret-defense-rollout-receipt.md` | `historical_receipt` | false | false | AH-500 | Partial receipt, not instruction. |
| `reports/receipts/AH-501-secret-exclusion-finish-receipt.md` | `historical_receipt` | false | false | AH-501 | Receipt only. |
| `reports/receipts/AH-507-chatgpt-control-app-bootstrap-receipt.md` | `historical_receipt` | false | false | AH-507 | Partial receipt, not instruction. |
| `reports/receipts/AH-507-chatgpt-control-app-closed-loop-receipt.md` | `superseded` | false | false | AH-507 | Superseded by final AH-507 receipt. |
| `reports/receipts/AH-507-control-loop-recovery-receipt.md` | `historical_receipt` | false | false | AH-507 | Receipt only. |
| `reports/receipts/AH-507-public-chatgpt-mcp-final-receipt.md` | `historical_receipt` | false | false | AH-507 | Final receipt only. |
| `reports/receipts/AH-510-t0-emergency-stop-control-receipt.md` | `historical_receipt` | false | false | AH-510 | Receipt only. |
| `reports/receipts/mtproxy-domain-route-worker-receipt-20260523.md` | `historical_receipt` | false | false | AH-468 | Operational receipt only. |
| `reports/receipts/npm-docker-domain-route-ah513-ah518-receipt-20260523.md` | `historical_receipt` | false | false | AH-513/AH-518 | Operational receipt only. |
| `schemas/prompt-artifact.schema.json` | `active_policy` | false | false | AH-494 | Schema. |
| `schemas/report-receipt.schema.json` | `active_policy` | false | false | AH-494 | Schema. |
| `schemas/task-card.schema.json` | `active_policy` | false | false | AH-494 | Schema. |
| `schemas/secret-scan-receipt.schema.json` | `active_policy` | false | false | AH-500 | Schema. |
| `schemas/agenthub-run-preflight.schema.json` | `active_policy` | false | false | AH-507/AH-510 | Schema. |
| `schemas/t0-emergency-stop-receipt.schema.json` | `active_policy` | false | false | AH-510 | Schema. |
| `schemas/control-spine-pr-queue-register.schema.json` | `active_control` | false | false | AH-523 | PR queue register schema. |
| `schemas/agent-output-quality-receipt.schema.json` | `active_control` | false | false | AH-529 | Receipt schema for output/link/report quality gates. |
| `skills-drafts/README.md` | `audit_only` | false | false | AH-511 | Draft skill directory note. |
| `skills-drafts/t0-non-authoring-gate/SKILL.md` | `audit_only` | false | false | AH-511 | Draft skill, not active by default. |
| `skills-drafts/devops-incident-diagnostics/SKILL.md` | `audit_only` | false | false | AH-511 | Draft skill, not active by default. |
| `skills-drafts/agenthub-evidence-loop-closure/SKILL.md` | `audit_only` | false | false | AH-511 | Draft skill, not active by default. |
| `registries/agenthub-control-spine-id-register.md` | `current_baseline` | true | false | AH-522 | Current ID register. |
| `reports/control-spine/teamlead-system-inventory-20260524.md` | `operational_receipt` | false | false | AH-522 | Inventory report for current run. |
| `reports/receipts/teamlead-system-inventory-receipt-20260524.md` | `operational_receipt` | false | false | AH-522 | Inventory receipt for current run. |
| `reports/receipts/control-spine-pr-queue-cleanup-receipt-20260524.md` | `operational_receipt` | false | false | AH-523 | Registrar queue cleanup receipt. |
| `reports/receipts/AH-526-session-failure-report-receipt.md` | `operational_receipt` | false | false | AH-526 | Incident report placement and PR queue receipt. |
| `reports/research/external-agent-framework-pattern-audit-20260524.md` | `audit_only` | false | false | AH-527 | External repository pattern audit; not a default instruction. |
| `reports/receipts/external-agent-framework-pattern-audit-receipt-20260524.md` | `operational_receipt` | false | false | AH-527 | Research receipt; proof only. |
| `reports/receipts/cyber-safe-prompt-wording-receipt-20260524.md` | `operational_receipt` | false | false | AH-528 | Prompt wording policy receipt; proof only. |
| `reports/receipts/AH-529-agent-output-link-intake-repair-receipt.md` | `operational_receipt` | false | false | AH-529 | Agent output and short-link intake repair receipt. |
| `reports/receipts/external-repo-pattern-adaptation-closed-loop-receipt.md` | `operational_receipt` | false | false | AH-530 | External pattern adaptation readiness receipt. |
| `reports/receipts/AH-533-git-route-policy-receipt.md` | `operational_receipt` | false | false | AH-533 | Git/GitHub route policy receipt; proof only. |
| `reports/receipts/AH-531-AH-532-pattern-implementation-receipt.md` | `operational_receipt` | false | false | AH-531/AH-532 | Pattern implementation receipt; proof only. |
