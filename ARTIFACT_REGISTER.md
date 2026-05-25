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
| `governance/openai-cyber-safe-request-router.md` | `active_policy` | false | false | AH-541 | Four-class OpenAI cyber-safe request router; clarity/compliance policy, not safeguard bypass. |
| `runbooks/chatgpt-github-connect.md` | `active_runbook` | false | false | AH-494 | Task-specific runbook. |
| `runbooks/secret-leak-response.md` | `active_runbook` | false | false | AH-500 | Secret leak runbook. |
| `runbooks/agenthub-locked-run-recovery.md` | `active_runbook` | false | false | AH-507 | Locked-run recovery. |
| `runbooks/teamlead-t0-role-drift-emergency-stop.md` | `active_runbook` | false | false | AH-510 | T0 drift stop runbook. |
| `runbooks/prompt-intake-flow.md` | `active_runbook` | false | false | AH-494 | Prompt intake runbook. |
| `runbooks/codex-cli-usage.md` | `active_runbook` | false | false | AH-494 | Codex CLI usage runbook. |
| `runbooks/control-spine-pr-queue-and-artifact-lifecycle.md` | `active_control` | false | false | AH-523 | Registrar queue/lifecycle runbook. |
| `runbooks/agent-shortlink-intake-and-report-placement.md` | `active_control` | false | false | AH-529 | Short-link stale-index and report placement runbook. |
| `runbooks/agenthub-pattern-adaptation-control-loop.md` | `active_control` | false | false | AH-531/AH-532 | External pattern adaptation control loop; no runtime mutation. |
| `runbooks/chatgpt-cyber-flag-recovery-runbook.md` | `active_control` | false | false | AH-541 | Clean authorized-scope recovery steps for reported ChatGPT/Codex cyber warnings. |
| `templates/github/secret-scan-workflow.yml` | `active_policy` | false | false | AH-500 | Security workflow template. |
| `.github/workflows/secret-scan.yml` | `active_policy` | false | false | AH-500 | Control-spine secret-scan workflow. |
| `templates/security/gitleaks.toml` | `active_policy` | false | false | AH-500 | Scanner config. |
| `templates/git-hooks/pre-commit-secret-scan.sh` | `active_policy` | false | false | AH-500 | Local hook template. |
| `templates/git-hooks/pre-push-secret-scan.sh` | `active_policy` | false | false | AH-500 | Local hook template. |
| `prompts/security/teamlead-t0-github-secret-defense-rollout.txt` | `consumed_prompt` | false | false | AH-500 | Executed rollout prompt, not default instruction. |
| `prompts/apps/AH-507-chatgpt-control-app-implementation-prompt.md` | `consumed_prompt` | false | false | AH-507 | One-time implementation prompt. |
| `prompts/implementation/anthropic-knowledge-work-pattern-adaptation-worker.txt` | `active_control` | false | false | AH-531 | Future worker brief; no external install or runtime mutation. |
| `prompts/implementation/microsoft-ai-engineering-coach-pattern-adaptation-worker.txt` | `active_control` | false | false | AH-532 | Future worker brief; privacy-preserving eval adaptation only. |
| `prompts/templates/agenthub-safe-devops-incident-dispatch.txt` | `active_control` | false | false | AH-541 | Safe dispatch template for authorized owned infrastructure incidents. |
| `prompts/templates/agenthub-safe-control-plane-repair-dispatch.txt` | `active_control` | false | false | AH-541 | Safe dispatch template for AgentHub control-plane repair without runtime mutation. |
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
| `schemas/agenthub_authorized_scope.schema.json` | `active_control` | false | false | AH-541 | Authorized-scope schema for cyber-safe router dispatches. |
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
| `governance/agenthub-only-execution-discipline.md` | `active_policy` | false | false | AH-534 | AgentHub-only runtime/server/storage execution discipline; defines invalidation classes. |
| `governance/agenthub-safe-recovery-control.md` | `active_policy` | false | false | AH-534 | Safe recovery control for blocker loops, task closure, runtime safety, and Caveman final output. |
| `runbooks/agenthub-only-violation-response.md` | `active_control` | false | false | AH-534 | Direct-shell/runtime violation response and continuation runbook. |
| `runbooks/agenthub-live-execution-adapter-remediation.md` | `active_control` | false | false | AH-537 | Live adapter remediation runbook for blocked command-worker dispatch. |
| `runbooks/agenthub-safe-recovery-control-loop.md` | `active_control` | false | false | AH-534 | Closed-loop runbook for safe recovery, evidence, task lifecycle, and platform gates. |
| `prompts/architecture/agenthub-safe-recovery-control-prompt.txt` | `consumed_prompt` | false | false | AH-534 | Neutral policy-safe prompt artifact; not replayed by default. |
| `reports/receipts/AH-534-agenthub-only-execution-discipline-receipt.md` | `operational_receipt` | false | false | AH-534 | AgentHub-only execution discipline receipt; proof only. |
| `reports/receipts/AH-536-AH-537-live-execution-route-repair-receipt.md` | `operational_receipt` | false | false | AH-536/AH-537 | Live execution adapter blocker receipt; proof only. |
| `reports/receipts/AH-534-agenthub-safe-recovery-control-receipt.md` | `operational_receipt` | false | false | AH-534 | Receipt for safe recovery control package; proof only. |
| `schemas/agenthub-only-execution-receipt.schema.json` | `active_control` | false | false | AH-534 | Receipt schema for AgentHub-only execution discipline. |
| `skills-drafts/agenthub-only-execution-boundary/SKILL.md` | `audit_only` | false | false | AH-534 | Draft skill, not active by default. |
| `.agents/skills/agenthub-openai-cyber-safe-request-router/SKILL.md` | `active_control` | false | false | AH-541 | Active router skill for cyber-adjacent AgentHub request classification. |
| `evals/agenthub-cyber-safe-router/` | `active_control` | false | false | AH-541 | Router class and blocker fixture tests. |
| `reports/receipts/RUN-agenthub-openai-cyber-flag-safe-router-20260525-openai-cyber-safe-router-receipt.md` | `operational_receipt` | false | false | AH-541 | Receipt for cyber-safe router installation and validation proof. |
| `governance/agenthub-lane-router-and-blocker-scope-policy.md` | `active_policy` | false | false | AH-542 | Lane A-F blocker scope policy; prevents live-adapter absence from globally stopping repo/task/control lanes. |
| `runbooks/agenthub-paralysis-breaker-runbook.md` | `active_control` | false | false | AH-542 | Read-before-write, task freeze, dedupe, PR queue, prompt quarantine, and lane blocker runbook. |
| `schemas/agenthub-blocker-taxonomy.schema.json` | `active_control` | false | false | AH-542 | Blocker taxonomy schema requiring lane, missing capability, evidence class, and legal route. |
| `governance/task-graph-closure-policy.md` | `active_policy` | false | false | AH-542 | Duplicate-task, parent/child Done, task readback, and evidence-class closure policy. |
| `governance/repo-first-artifact-lifecycle-policy.md` | `active_policy` | false | false | AH-542 | Default-load, safe-to-replay, consumed prompt, and quarantine policy. |
| `.agents/skills/agenthub-task-first-router/SKILL.md` | `active_control` | false | false | AH-542 | Active task-first router skill for duplicate prevention and task readback. |
| `.agents/skills/agenthub-registrar-artifact-lifecycle/SKILL.md` | `active_control` | false | false | AH-542 | Active registrar lifecycle skill for index/register/default-load coverage. |
| `.agents/skills/agenthub-git-pr-queue-control/SKILL.md` | `active_control` | false | false | AH-542 | Active PR queue skill for duplicate PR and stale PR loop prevention. |
| `.agents/skills/agenthub-truth-redteam/SKILL.md` | `active_control` | false | false | AH-542 | Active evidence-class redteam skill for fake PASS/Done prevention. |
| `.agents/skills/caveman-user-communication/SKILL.md` | `active_control` | false | false | AH-542 | Active final-output skill; Russian compact Fact/Action/Left only. |
| `evals/agenthub-paralysis-breaker/` | `active_control` | false | false | AH-542 | Regression fixtures for same-gate loop, sandbox-only Done, live-adapter lane scoping, duplicate tasks, parent closure, artifact lifecycle, and final output. |
| `reports/receipts/RUN-agenthub-p0-paralysis-breaker-repo-first-control-repair-20260525-receipt.md` | `operational_receipt` | false | false | AH-542 | Receipt for AH-542 paralysis breaker control package; proof only, not instruction. |
| `governance/agenthub-access-rights-and-live-worker-enablement-policy.md` | `active_policy` | false | false | AH-554 | P0-P9 scoped capability model; live worker enablement without permissive bypass. |
| `governance/agenthub-docker-db-proxy-safety-policy.md` | `active_policy` | false | false | AH-554 | Docker, DB, proxy, firewall, DNS, SSL, and destructive-action safety gates. |
| `governance/agenthub-task-cycle-full-closure-policy.md` | `active_policy` | false | false | AH-554 | Full task-cycle closure and AH-536/AH-554 parent-child Done gate. |
| `schemas/agenthub-access-capability-matrix.schema.json` | `active_control` | false | false | AH-554 | JSON schema for P0-P9 capability matrix. |
| `schemas/agenthub-live-worker-authorization.schema.json` | `active_control` | false | false | AH-554 | JSON schema for scoped live-worker authorization contracts. |
| `runbooks/agenthub-access-audit-and-live-devops-enablement.md` | `active_control` | false | false | AH-554 | Access audit and live DevOps enablement runbook. |
| `runbooks/agenthub-502-live-runtime-recovery-safe-runbook.md` | `active_control` | false | false | AH-554 | Safe 502 live runtime recovery runbook for T2 DevOps workers. |
| `.agents/skills/agenthub-permission-gate-router/SKILL.md` | `active_control` | false | false | AH-554 | Active skill for permission class routing and local blocker split. |
| `.agents/skills/agenthub-live-devops-safety/SKILL.md` | `active_control` | false | false | AH-554 | Active skill for safe live DevOps execution gates. |
| `evals/agenthub-access-rights-and-live-worker-gates/` | `active_control` | false | false | AH-554 | Regression fixtures for access rights, live-worker safety, and closure gates. |
| `reports/audits/AH-554-access-rights-and-live-worker-audit-20260525.md` | `audit_only` | false | false | AH-554 | Access rights and live-worker audit report; evidence only. |
| `reports/receipts/AH-554-access-rights-and-live-devops-enablement-receipt.md` | `operational_receipt` | false | false | AH-554 | Receipt for installed access-rights controls and residual live-worker blocker. |
| `reports/receipts/AH-536-AH-554-AH-550-route-enablement-and-runtime-repair-receipt-20260525.md` | `operational_receipt` | false | false | AH-536/AH-554/AH-550/AH-557 | Route enablement and scoped runtime repair receipt; BMC direct runtime restored, AH-554 public upstream residual remains. |
| `reports/receipts/AH-536-AH-554-live-runtime-edge-closure-20260525.md` | `superseded` | false | false | AH-536/AH-554 | Superseded by repo-first corrective audit after fresh public readback showed active 502s and role-boundary evidence gap. |
| `reports/audits/AH-536-AH-554-repo-first-runtime-closure-audit-20260525.md` | `audit_only` | false | false | AH-536/AH-554 | Corrective repo-first audit; records active 502s and live-worker route blocker. |
| `reports/receipts/AH-536-AH-554-repo-first-runtime-closure-receipt-20260525.md` | `operational_receipt` | false | false | AH-536/AH-554 | Corrective receipt; blocks Done on `AGENTHUB_LIVE_WORKER_ROUTE_BLOCKED`. |
| `reports/incidents/AGENTHUB-P0-repo-first-agent-execution-freeze-20260525.md` | `audit_only` | false | false | AH-567/AH-536/AH-554 | P0 repo-first execution freeze incident audit; evidence only, not replayable instruction. |
| `reports/receipts/AGENTHUB-P0-repo-first-agent-execution-freeze-receipt-20260525.md` | `superseded` | false | false | AH-567/AH-536/AH-554 | Superseded by break-glass safe route profile for owner-authorized safe work; remains evidence only. |
| `governance/agenthub-controlled-live-devops-permission-profile-ah536-ah554-ah567.md` | `superseded` | false | false | AH-567/AH-536/AH-554 | Superseded by break-glass safe route profile, which forbids terminal `AGENTHUB_PERMISSION_AUTH_REQUIRED` for owner-authorized safe actions. |
| `reports/incidents/AGENTHUB-P0-controlled-unfreeze-safe-permission-expansion-20260525.md` | `audit_only` | false | false | AH-567/AH-536/AH-554 | Corrective incident report with self-critique, Five Whys, role split, and forbidden contour proof; evidence only, not replayable instruction. |
| `reports/receipts/AGENTHUB-P0-controlled-unfreeze-safe-permission-expansion-receipt-20260525.md` | `superseded` | false | false | AH-567/AH-536/AH-554 | Superseded by break-glass safe route profile; old permission-auth blocker is no longer terminal for owner-authorized safe actions. |
| `governance/agenthub-break-glass-safe-route-recovery-profile-ah536-ah554-ah567.md` | `active_control` | false | false | AH-567/AH-536/AH-554 | Owner-authorized break-glass route profile for one scoped AgentHub T2 live worker; no broad safety disable. |
| `reports/receipts/AGENTHUB-P0-break-glass-safe-route-recovery-start-receipt-20260525.md` | `operational_receipt` | false | false | AH-567/AH-536/AH-554 | Start receipt for break-glass safe route profile before T2 dispatch; proof only. |
