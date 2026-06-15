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
| `governance/policies/t0-direct-action-hard-stop-policy.md` | `active_policy` | false | false | AH-590 | Current hard-stop policy binding T0 direct shell/code/Docker/runtime denial to AgentHub-core enforcement evidence. |
| `governance/policies/backend-only-owner-communication-policy.md` | `active_policy` | false | false | AH-590 | Current backend-only owner communication policy for final-only chat and mixed-output quarantine. |
| `governance/policies/agenthub-self-healing-core-policy.md` | `active_policy` | false | false | AH-590 | Durable self-healing loop policy for ordinary route/model/registrar/task-debt defects before owner-facing blockers. |
| `governance/policies/agenthub-capability-matrix.md` | `active_policy` | false | false | AH-590 | Role x surface x operation x model-route capability matrix for action authorization receipts. |
| `governance/global-agent-control-enforcement-policy.md` | `active_policy` | false | false | AH-590 | Global enforcement policy for T0 direct-action denial, run-id normalization, repo-first reporting, and same-gate loop breaker. |
| `governance/secrets-registry-policy.md` | `active_policy` | false | false | AH-590 | Per-service secret handle registry policy; metadata-only, no secret values in Git/chat/logs. |
| `governance/model-token-routing-policy.md` | `active_policy` | false | false | AH-590 | Registry-driven model and token routing policy; no expensive routine loops. |
| `governance/agenthub-x-capability-matrix.md` | `active_policy` | false | false | AH-590 | Closed-contour AgentHub X capability matrix with T0 control-only boundary, worker profiles, owner-only gates, internal remediation, methodology gate, and loop breaker. |
| `governance/adr/ADR-agenthub-x-controlled-capability-matrix-20260528.md` | `active_policy` | false | false | AH-590 | Architecture decision for controlled capability matrix instead of strict blockers or unrestricted root. |
| `governance/adr/ADR-codex-spark-model-router-enforcement-20260528.md` | `active_policy` | false | false | AH-590 | Architecture decision for Codex Spark / Codex primary model routing, same-RUN fallback, and PR80 surface-bound residual enforcement. |
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
| `runbooks/agenthub-x-capability-remediation.md` | `active_control` | false | false | AH-590 | Same-RUN remediation procedure for missing routine AgentHub X capability, hook, adapter, or worker profile. |
| `runbooks/agenthub-self-healing-route-recovery.md` | `active_control` | false | false | AH-590 | Same-RUN recovery path for route, model, registrar, task-debt, and evidence-route defects. |
| `runbooks/agenthub-secrets-handle-registry.md` | `active_control` | false | false | AH-590 | Redacted secret-handle registry procedure and missing-handle owner guide flow. |
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
| `reports/devops/komodo-orchestration-roadmap-20260526.md` | `audit_only` | false | false | AH-571 | Komodo/NPM/Portainer orchestration architecture report with the 2026-05-26 approved corrected contract; source-grounded planning only, not live rollout evidence. |
| `reports/devops/komodo-orchestration-task-decomposition-20260526.md` | `active_control` | false | false | AH-571 | Bounded implementation backlog and phase 0-8 corrected-contract checklist for future AgentHub live DevOps tasks. |
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
| `reports/receipts/RUN-komodo-orchestration-20260526-receipt.md` | `operational_receipt` | false | false | AH-571 | Receipt for Komodo orchestration report, task creation, repository package, and corrected-contract realignment. |
| `reports/receipts/RUN-komodo-process-hardening-20260526-receipt.md` | `operational_receipt` | false | false | AH-571 | Receipt for Komodo process hardening after repeated live-route gate failure; records AH-578 as the single active route unblock gate. |
| `reports/receipts/AH-574-komodo-live-install-20260526.md` | `operational_receipt` | false | false | AH-574 | Receipt for scoped Komodo v2 local baseline installation and AgentHub verifier evidence; proof only, not a standing instruction or public proxy claim. |
| `reports/receipts/AH-575-komodo-orchestrator-readback-20260527.md` | `operational_receipt` | false | false | AH-575 | Receipt for scoped Komodo Docker-orchestrator readback; proof only, not a public NPM/domain exposure or service migration claim. |
| `reports/receipts/AH-575-komodo-live-read-route-enable-20260527.md` | `operational_receipt` | false | false | AH-575 | Receipt for scoped Komodo live-read route enablement and container inventory; proof only, not a public edge/domain change or service migration claim. |
| `reports/receipts/AH-575-kutt-first-migration-preflight-20260527.md` | `operational_receipt` | false | false | AH-575 | Receipt for first candidate `kutt-server-1` rollback/readiness and compose-stack metadata preflight; proof only, not a public edge/domain change or service mutation claim. |
| `reports/receipts/AH-575-komodo-import-route-discovery-20260527.md` | `operational_receipt` | false | false | AH-575 | Receipt for Komodo authenticated import route discovery; proof only, not an imported stack, secret read, or service mutation claim. |
| `schemas/prompt-artifact.schema.json` | `active_policy` | false | false | AH-494 | Schema. |
| `schemas/report-receipt.schema.json` | `active_policy` | false | false | AH-494 | Schema. |
| `schemas/task-card.schema.json` | `active_policy` | false | false | AH-494 | Schema. |
| `schemas/secret-scan-receipt.schema.json` | `active_policy` | false | false | AH-500 | Schema. |
| `schemas/agenthub-run-preflight.schema.json` | `active_policy` | false | false | AH-507/AH-510 | Schema. |
| `schemas/t0-emergency-stop-receipt.schema.json` | `active_policy` | false | false | AH-510 | Schema. |
| `schemas/agenthub-x-capability-matrix.schema.json` | `active_policy` | false | false | AH-590 | JSON schema for the AgentHub X closed-contour capability matrix. |
| `schemas/agent-action-request.schema.json` | `active_policy` | false | false | AH-590 | JSON schema for pre-action policy gate requests. |
| `schemas/agenthub_action_authorization_receipt.schema.json` | `active_policy` | false | false | AH-590 | JSON schema for mandatory pre-action authorization receipts. |
| `schemas/agenthub_capability_matrix.schema.json` | `active_policy` | false | false | AH-590 | JSON schema for self-healing capability matrix records. |
| `schemas/agenthub_self_healing_event.schema.json` | `active_policy` | false | false | AH-590 | JSON schema for same-RUN self-healing defect events. |
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
| `evals/t0-direct-action-negative-tests/` | `active_control` | false | false | AH-590 | Negative fixtures proving T0 direct shell, provider CLI, product edit, secret dump, and git mutation are denied before execution. |
| `evals/agenthub-x-capability-matrix/` | `active_control` | false | false | AH-590 | Machine-readable AgentHub X capability matrix fixture matching the schema profile set and owner-only/remediation gates. |
| `evals/agenthub-x-capability-positive-tests/` | `active_control` | false | false | AH-590 | Positive fixtures proving T0 route, T1 ADR, T2 Codex, P4 read/repair, secret-handle metadata, verifier, registrar, and remediation paths. |
| `evals/model-token-routing/` | `active_control` | false | false | AH-590 | Fixtures for Codex-capable code/config routing, T0 command denial, and same-gate loop stop. |
| `evals/repo-first-reporting/` | `active_control` | false | false | AH-590 | Fixtures requiring audit, receipt, registers, PR queue, task readback, and secret scan before Done. |
| `validators/agenthub_action_policy_validator.rb` | `active_control` | false | false | AH-590 | Deterministic AgentHub X pre-action policy validator for profile and capability routing fixtures. |
| `validators/t0_direct_action_hard_stop.rb` | `active_control` | false | false | AH-590 | Deterministic negative-test validator for T0 direct-action hard stop fixtures. |
| `validators/model_token_router_validator.rb` | `active_control` | false | false | AH-590 | Deterministic model/token routing validator for Codex worker and loop-stop fixtures. |
| `validators/repo_first_receipt_gate.rb` | `active_control` | false | false | AH-590 | Deterministic repo-first Done gate validator for receipt/register/readback fixtures. |
| `reports/audits/AH-554-access-rights-and-live-worker-audit-20260525.md` | `audit_only` | false | false | AH-554 | Access rights and live-worker audit report; evidence only. |
| `reports/receipts/AH-554-access-rights-and-live-devops-enablement-receipt.md` | `operational_receipt` | false | false | AH-554 | Receipt for installed access-rights controls and residual live-worker blocker. |
| `reports/audits/P0-system-wide-permission-core-versioning-architecture-20260526.md` | `audit_only` | false | false | AH-570 | Architecture report for permission profiles and core version-control lifecycle; evidence only. |
| `governance/permission-profiles/agenthub-permission-profile-matrix.md` | `active_policy` | false | false | AH-570 | Permission profile matrix separating safe control work from dangerous runtime work. |
| `governance/permission-profiles/agenthub-permission-validator.md` | `active_control` | false | false | AH-570 | Validator rules for auto-allow, manifest, denial, and quarantine outcomes. |
| `governance/core-versioning/codex-core-version-control-policy.md` | `active_policy` | false | false | AH-570 | Core release/checkpoint/rollback policy; raw runtime dumps forbidden. |
| `schemas/permission-manifest.schema.json` | `active_control` | false | false | AH-570 | Schema for one-shot permission requests that replace vague blockers. |
| `schemas/core-change-receipt.schema.json` | `active_control` | false | false | AH-570 | Schema for AgentHub-core release/change receipts. |
| `runbooks/rollback/agenthub-core-rollback-runbook.md` | `active_control` | false | false | AH-570 | Rollback and quarantine runbook for AgentHub-core policy/hook failures. |
| `evals/agenthub-system-permission-core-versioning/fixtures.json` | `active_control` | false | false | AH-570 | Static fixtures for safe auto-allow, T0 deny, manifest, quarantine, and rollback gates. |
| `quarantine/README.md` | `quarantine` | false | false | AH-570 | Quarantine directory index; evidence only, not replayable. |
| `reports/receipts/P0-system-wide-permission-core-versioning-installed-20260526.md` | `operational_receipt` | false | false | AH-570 | Installation receipt for agenthub-core.20260526.1 repository architecture package. |
| `governance/policies/agenthub/pr52-policy-install-control.md` | `active_control` | false | false | AH-570 | Approved install-path bridge from PR #52 repository policy to AgentHub runtime policy/hook/validator/template files. |
| `reports/receipts/P0-pr52-policy-install-path-decision-20260526.md` | `operational_receipt` | false | false | AH-570 | Records approved runtime/control-spine install paths and rollback metadata before runtime writes. |
| `reports/receipts/P0-pr52-policy-install-validation-20260526.md` | `operational_receipt` | false | false | AH-570 | Records dry-run validation, scoped secret scans, and ready-to-merge queue decision for PR #52. |
| `governance/policies/agenthub/t0-live-root-hard-enforcement-addendum-20260526.md` | `active_policy` | false | false | AH-554 | P0 addendum for T0 live-root hard enforcement; source policy, not a runtime repair command. |
| `evals/agenthub-t0-live-root-hard-enforcement/fixtures.json` | `active_control` | false | false | AH-554 | Negative-test fixtures for T0 deny, scoped command gate, stale replay, and same-gate loop control. |
| `reports/receipts/P0-t0-live-root-hard-enforcement-addendum-20260526.md` | `operational_receipt` | false | false | AH-554 | Receipt for PR #55 addendum package and runtime enforcement readback. |
| `reports/audits/AH-572-live-runtime-read-route-factcheck-20260526.md` | `audit_only` | false | false | AH-572 | Factcheck report explaining why AH-572 still lacks a live Docker/NPM read executor after control-plane permission expansion. |
| `reports/receipts/AH-572-live-runtime-read-route-factcheck-receipt-20260526.md` | `operational_receipt` | false | false | AH-572 | Receipt for AH-572 live runtime read route factcheck; proof only, not an active instruction. |
| `reports/audits/AH-572-live-runtime-readonly-inventory-20260526.md` | `audit_only` | false | false | AH-572 | Sanitized read-only Docker/NPM inventory collected through the scoped T2/P4 live runtime read route. |
| `reports/receipts/AH-572-live-runtime-readonly-inventory-receipt-20260526.md` | `operational_receipt` | false | false | AH-572 | Receipt for AH-572 scoped live runtime read-only inventory; proof only, not an active instruction. |
| `reports/audits/AH-585-control-spine-repository-hygiene-20260526.md` | `audit_only` | false | false | AH-585 | Registrar-only hygiene report for current PR/register/branch lifecycle state. |
| `reports/receipts/AH-585-control-spine-repository-hygiene-receipt-20260526.md` | `operational_receipt` | false | false | AH-585 | Receipt for control-spine repository hygiene; proof only, not an active instruction. |
| `schemas/agenthub-owner-requirements-ledger.schema.json` | `active_control` | false | false | AH-590 | Schema for owner requirements ledger entries and acceptance mapping. |
| `schemas/agenthub-run-checkpoint.schema.json` | `active_control` | false | false | AH-590 | Schema for durable AgentHub resume checkpoints. |
| `schemas/agent-run-isolation.schema.json` | `active_control` | false | false | AH-590 | Schema for RUN_ID/task_id/role/scope isolation across agent streams. |
| `schemas/secrets-manifest.schema.json` | `active_control` | false | false | AH-590 | Schema for redacted secret handle metadata registry. |
| `governance/agenthub-backend-only-output-policy.md` | `active_policy` | false | false | AH-590 | Backend-only owner communication and evidence placement policy. |
| `governance/agenthub-role-permission-profiles.md` | `active_policy` | false | false | AH-590 | Role-scoped permission profile policy for T0/T1/T2/Registrar/Verifier. |
| `governance/agenthub-model-routing-and-token-economy.md` | `active_policy` | false | false | AH-590 | Model routing and token economy policy for AgentHub work. |
| `governance/agenthub-resume-from-run-policy.md` | `active_policy` | false | false | AH-590 | Resume/checkpoint lifecycle policy. |
| `governance/agenthub-technical-assignment-methodology-router.md` | `active_policy` | false | false | AH-590 | Technical-assignment and methodology router policy. |
| `runbooks/agenthub-backend-only-linear-cycle-runbook.md` | `active_control` | false | false | AH-590 | Backend-only linear execution and closure runbook. |
| `runbooks/t0-direct-action-violation-response.md` | `active_control` | false | false | AH-590 | Response runbook for T0 direct command/code/runtime bypass attempts. |
| `runbooks/secret-handle-missing-owner-guide.md` | `active_control` | false | false | AH-590 | Owner-safe guide for missing secret handle remediation without chat-secret leakage. |
| `evals/agenthub-control-policy-regression-suite.md` | `active_control` | false | false | AH-590 | Regression fixtures for T0 boundary, reporting, model routing, resume, duplicate, and Done gates. |
| `evals/t0-hard-stop-negative-tests.md` | `active_control` | false | false | AH-590 | Negative tests for T0 direct-action denial, unscoped command adapter, backend-only output, session isolation, and report registration. |
| `evals/global-agent-control/fixtures.json` | `active_control` | false | false | AH-590 | Fixtures for T0 direct-action denials, T2 read-route allowance, run-id alias normalization, and same-gate loop control. |
| `evals/secrets-registry/fixtures.json` | `active_control` | false | false | AH-590 | Fixtures for metadata-only secret handle lookup and missing-handle behavior. |
| `evals/agenthub-self-healing/fixtures/fixtures.json` | `active_control` | false | false | AH-590 | E1-E15 self-healing negative and repair-route fixtures. |
| `validators/agenthub_self_healing_validator.rb` | `active_control` | false | false | AH-590 | Deterministic validator for AgentHub self-healing E1-E15 fixtures. |
| `registries/secrets-manifest.redacted.md` | `current_baseline` | false | false | AH-590 | Redacted secret-handle manifest; metadata only, no secret values. |
| `reports/audits/P0-full-owner-requirements-intake-ledger-20260526.md` | `audit_only` | false | false | AH-590 | Full owner requirements intake ledger; evidence only, not active instruction. |
| `reports/audits/P0-global-agent-control-secrets-and-repo-audit-20260527.md` | `audit_only` | false | false | AH-590 | Fact-based audit for PR #68/#69, T0 bypass, run-id schema mismatch, secrets registry, and repo-first residuals. |
| `reports/audits/P0-agenthub-x-capability-self-audit-20260528.md` | `audit_only` | false | false | AH-590 | F1-F8 fact table, root causes, capability gaps, controls, risk, and rollback for AgentHub X hard enforcement. |
| `reports/audits/P0-agenthub-x-self-critique-correction-20260528.md` | `audit_only` | false | false | AH-590 | Reflexion, 5 Whys, FMEA, self-critique, negative tests, and residual typed defects for the same run. |
| `reports/audits/P0-codex-spark-model-router-pr80-residual-audit-20260528.md` | `audit_only` | false | false | AH-590 | Fact audit and validation matrix for Codex Spark model-router enforcement and PR80 surface-bound residual fix. |
| `reports/audits/P0-pr82-fallback-evidence-gate-fact-audit-20260528.md` | `audit_only` | false | false | AH-590 | Fact audit for PR #82/#83 residual fallback_reason-only bypass and minimal same-RUN evidence gate patch. |
| `reports/audits/P0-agenthub-self-healing-core-architecture-audit-20260528.md` | `audit_only` | false | false | AH-590 | Fact audit, 5 Whys, FMEA, evidence map, and residual risk for self-healing core controls. |
| `reports/audits/P0-t0-escape-A-source-lifecycle-readback-20260530.md` | `audit_only` | false | false | 3-640 | Source hierarchy and lifecycle replay audit for T0 escape investigation. |
| `reports/audits/P0-t0-escape-B-t0-boundary-enforcement-20260530.md` | `audit_only` | false | false | 3-640 | T0 direct action boundary audit; records active pre-action enforcement defect. |
| `reports/audits/P0-t0-escape-C-mid-context-role-drift-20260530.md` | `audit_only` | false | false | 3-640 | Mid-context role-state revalidation audit. |
| `reports/audits/P0-t0-escape-D-code-authoring-route-20260530.md` | `audit_only` | false | false | 3-640 | Code/config authoring route and Spark/Codex enforcement audit. |
| `reports/audits/P0-t0-escape-E-live-adapter-boundary-20260530.md` | `audit_only` | false | false | 3-640 | Live adapter authority boundary audit. |
| `reports/audits/P0-t0-escape-F-task-service-done-gate-20260530.md` | `audit_only` | false | false | 3-640 | Task-service and Done gate audit. |
| `reports/audits/P0-t0-escape-G-pr-artifact-lifecycle-20260530.md` | `audit_only` | false | false | 3-640 | PR and artifact lifecycle audit. |
| `reports/audits/P0-t0-escape-H-prompt-quality-redteam-20260530.md` | `audit_only` | false | false | 3-640 | Prompt quality and red-team audit. |
| `reports/audits/P0-t0-escape-I-no-temporary-patch-gate-20260530.md` | `audit_only` | false | false | 3-640 | Durable-control/no-temporary-patch audit. |
| `reports/audits/P0-t0-escape-J-final-boundary-decision-20260530.md` | `audit_only` | false | false | 3-640 | Final audit decision and implementation-prompt readiness. |
| `prompts/implementation/P0-agenthub-t0-escape-boundary-blocker-implementation-prompt-20260530.txt` | `active_control` | false | false | 3-640 | Implementation prompt for durable T0 escape boundary blocker; safe to use only as scoped implementation brief. |
| `reports/receipts/P0-t0-escape-orchestration-boundary-audit-receipt-20260530.md` | `operational_receipt` | false | false | 3-640 | Receipt for audit-only T0 escape/orchestration boundary run. |
| `governance/policies/t0-escape-boundary-gates-policy.md` | `active_policy` | false | false | AH-618 | Durable policy-as-code contract for the seven P0 T0 escape boundary gates installed after PR #115 audit. |
| `schemas/t0_escape_boundary_action.schema.json` | `active_control` | false | false | AH-618 | Action receipt schema for per-action role/model/surface/run revalidation. |
| `validators/t0_escape_boundary_gates_validator.rb` | `active_control` | false | false | AH-618 | Deterministic validator for T0 direct-action denial, role revalidation, Codex Spark authoring route, live adapter authority, task-service loop, Done hardening, and owner-output suppression. |
| `evals/t0-escape-boundary-gates/fixtures.json` | `active_control` | false | false | AH-618 | Positive and negative fixtures for the seven installed P0 T0 escape boundary gates. |
| `reports/receipts/P0-t0-escape-boundary-gates-implementation-receipt-20260530.md` | `operational_receipt` | false | false | AH-618 | Implementation receipt for durable boundary gates; supersedes PR #115 audit-only receipt for closure. |
| `reports/receipts/P0-model-portfolio-spark-canary-20260530.md` | `operational_receipt` | false | false | AH-615 | Spark canary proving requested/resolved/actual `gpt-5.3-codex-spark` and not `agenthub-sandbox-worker`. |
| `reports/receipts/P0-model-portfolio-fallback-canary-20260530.md` | `operational_receipt` | false | false | AH-615 | Fallback canary proving same-RUN simulated Spark-unavailable fallback to `gpt-5.3-codex` and return-to-Spark flag. |
| `reports/receipts/P0-model-portfolio-continuous-loop-implementation-receipt-20260530.md` | `operational_receipt` | false | false | AH-615 | Implementation receipt for model portfolio router and continuous loop controls. |
| `governance/codex-native-capability-router-policy.md` | `active_policy` | false | false | AH-622 | Durable route policy for Codex-native exec, Spark spawned workers, read-only subagents, profiles, permissions, MCP diagnostics, background terminals, and feature flags. |
| `schemas/codex_native_worker_receipt.schema.json` | `active_control` | false | false | AH-622 | Schema for Codex native worker receipts with task/RUN, model, role, surface, output hash, safety, and final-state gates. |
| `validators/codex_native_capability_router_validator.rb` | `active_control` | false | false | AH-622 | Deterministic validator for Codex-native route classes, Spark spawn proof, parallel read-only agents, permission guards, MCP diagnostics, background terminal checks, and Done gate. |
| `evals/codex-native-capability-router/fixtures.json` | `active_control` | false | false | AH-622 | Negative and positive fixtures for T0 denial, sandbox-not-Spark, spawned model receipt, parallel edit conflicts, fallback proof, MCP diagnostics, background terminals, and final Done. |
| `runbooks/codex-native-spawn-subagent-worker-runbook.md` | `active_runbook` | false | false | AH-622 | Runbook for bounded Codex-native spawned/subagent workers with launch, receipt, merge, and stop/remediation contracts. |
| `prompts/implementation/agenthub-codex-native-spawn-worker-template.txt` | `active_template` | false | false | AH-622 | Worker prompt template for Codex-native spawned workers with explicit task/RUN/model/profile/surface/receipt fields. |
| `reports/receipts/P0-codex-native-spark-spawn-canary-20260530.md` | `operational_receipt` | false | false | AH-622 | Spark spawned-worker canary receipt from bounded `gpt-5.3-codex-spark` worker, not `agenthub-sandbox-worker`. |
| `reports/receipts/P0-codex-native-spark-spawn-canary-artifact-20260530.json` | `operational_receipt` | false | false | AH-622 | Harmless Spark spawned-worker canary output artifact with stable SHA-256 recorded by the receipt. |
| `reports/receipts/P0-codex-native-readonly-parallel-canary-20260530.md` | `operational_receipt` | false | false | AH-622 | Read-only parallel subagent canary receipt for two `gpt-5.4-mini` fixture summary workers with no writes. |
| `reports/receipts/P0-codex-native-mcp-diagnostic-canary-20260530.md` | `operational_receipt` | false | false | AH-622 | MCP diagnostic canary receipt proving MCP tool availability before MCP-dependent work. |
| `reports/receipts/P0-codex-native-background-terminal-canary-20260530.md` | `operational_receipt` | false | false | AH-622 | Background terminal canary receipt for `/ps`-equivalent state check and no-runaway/no-stop path. |
| `reports/receipts/P0-codex-native-capability-enrichment-implementation-receipt-20260530.md` | `operational_receipt` | false | false | AH-622 | Implementation receipt for Codex-native capability enrichment router, canaries, validators, and registers. |
| `validators/three_component_cycle_validator.rb` | `active_control` | false | false | AH-615/AH-619/AH-622 | Deterministic three-component validator for model routing, native spawn, CLI profiles, hidden loop, Hiddify UUID flow, and final typed blocker gates. |
| `evals/three-component-cycle/fixtures.json` | `active_control` | false | false | AH-615/AH-619/AH-622 | Positive and negative fixtures for the P0 three-component audit/test/implementation contract. |
| `reports/receipts/P0-three-component-cycle-implementation-receipt-20260531.md` | `operational_receipt` | false | false | AH-615/AH-619/AH-622 | Implementation receipt for three-component validation and Hiddify live-adapter blocker without forbidden mutation. |
| `governance/agenthub-closed-loop-recovery-policy.md` | `active_policy` | false | false | AH-P0-CLOSED-LOOP-RECOVERY | Closed-loop recovery policy for initial-capture-only owner communication, spawned dispatch proof, actual model proof, and allowed final states. |
| `schemas/spawned_worker_dispatch.schema.json` | `active_control` | false | false | AH-P0-CLOSED-LOOP-RECOVERY | Schema for auditable `SPAWNED_WORKER_DISPATCH` events with model proof, scope, skills, prompt hash, evidence, validation, and no-user-interruption proof. |
| `schemas/closed_loop_autonomy.schema.json` | `active_control` | false | false | AH-P0-CLOSED-LOOP-RECOVERY | Schema for closed-loop autonomy receipts covering capture, duplicate check, task binding, validation, tracker, registers, PR queue, and final state. |
| `validators/closed_loop_recovery_validator.rb` | `active_control` | false | false | AH-P0-CLOSED-LOOP-RECOVERY | Deterministic validator for T0 boundary, actual model proof, spawned dispatch, user-action leak, duplicate/retry loops, lifecycle drift, PR queue, task readback, MCP proof, dangerous CLI flags, and Hiddify child gates. |
| `evals/closed-loop-recovery/fixtures.json` | `active_control` | false | false | AH-P0-CLOSED-LOOP-RECOVERY | Regression fixtures for the closed-loop recovery prompt, including required P0/P1 negative cases and approved final states. |
| `prompts/closed-loop/agenthub_closed_loop_worker_dispatch.txt` | `active_template` | false | false | AH-P0-CLOSED-LOOP-RECOVERY | Closed-loop worker dispatch template requiring task/RUN/model/scope/skills/evidence/validation and no routine owner readback. |
| `prompts/closed-loop/agenthub_architect_recovery_contract.txt` | `active_template` | false | false | AH-P0-CLOSED-LOOP-RECOVERY | Architect recovery contract template for AgentHub core recovery without product/runtime mutation. |
| `reports/receipts/P0-closed-loop-recovery-implementation-receipt-20260531.md` | `operational_receipt` | false | false | AH-P0-CLOSED-LOOP-RECOVERY | Implementation receipt for closed-loop recovery controls, Codex CLI classification, priority register, red-team checks, and safety evidence. |
| `governance/api-documentation-first-guardrail-policy.md` | `active_policy` | false | false | AH-P0-DOCS-API-FIRST-GUARDRAIL | Documentation-first and API-first policy for packaged products, vendor apps, owned code, service APIs, infrastructure, unknown products, mutation firewall, and emergency exceptions. |
| `governance/adr/ADR-api-documentation-first-agenthub-guardrail-20260531.md` | `active_control` | false | false | AH-P0-DOCS-API-FIRST-GUARDRAIL | ADR selecting control-spine guardrails, templates, validators, and eval suite over prompt-only tightening. |
| `templates/api-first/api-route-sheet-template.md` | `active_template` | false | false | AH-P0-DOCS-API-FIRST-GUARDRAIL | API Route Sheet template requiring product/version/docs/auth/read/write/rollback/validation/forbidden internals before mutation. |
| `templates/api-first/documentation-lookup-gate-template.md` | `active_template` | false | false | AH-P0-DOCS-API-FIRST-GUARDRAIL | Documentation Lookup Gate template for required/optional docs decisions and typed blockers. |
| `schemas/truth_ledger.schema.json` | `active_control` | false | false | AH-P0-DOCS-API-FIRST-GUARDRAIL | Truth Ledger schema tagging claims as EVIDENCED, HYPOTHESIS, UNVERIFIED, or REJECTED. |
| `validators/api_documentation_first_guardrail_validator.rb` | `active_control` | false | false | AH-P0-DOCS-API-FIRST-GUARDRAIL | Deterministic validator for docs lookup, API route sheet, mutation firewall, truth ledger, lifecycle, user front, retry loop, emergency exception, and Done gate. |
| `evals/docs-api-first/fixtures.json` | `active_control` | false | false | AH-P0-DOCS-API-FIRST-GUARDRAIL | Regression fixtures for required API/documentation-first guardrail cases and fake PASS/product-internal mutation denials. |
| `reports/audits/P0-api-documentation-first-guardrail-audit-20260531.md` | `audit_only` | false | false | AH-P0-DOCS-API-FIRST-GUARDRAIL | Read-only audit proving the dedicated API/documentation-first package was missing before this run and listing same-run fixes. |
| `reports/receipts/P0-api-documentation-first-guardrail-implementation-receipt-20260531.md` | `operational_receipt` | false | false | AH-P0-DOCS-API-FIRST-GUARDRAIL | Implementation receipt for installed API/documentation-first controls, prompt quality score, red-team coverage, and safety evidence. |
| `governance/no-interaction-task-first-closed-loop-policy.md` | `active_policy` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | Terminal-only user front, backend closed-loop, task-first, technical assignment, user queue, parent/child Done, and routine blocker remediation policy. |
| `governance/adr/ADR-no-interaction-task-first-closed-loop-20260531.md` | `active_control` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | ADR selecting balanced two-level closed loop controls over prompt-only tightening and deferring runtime policy engine work. |
| `schemas/run_user_input_queue.schema.json` | `active_control` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | Schema for user messages captured during active runs as queue events with classification and no user reply by default. |
| `schemas/technical_assignment.schema.json` | `active_control` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | Schema for pre-mutation technical assignments with boundaries, roles, skills, rollback, validation, and final format. |
| `templates/task-first/technical-assignment-template.md` | `active_template` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | Compact task-first technical assignment template for implementation contours. |
| `templates/task-first/run-user-input-queue-event-template.md` | `active_template` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | Queue event template for active-run user input buffering without raw sensitive text. |
| `validators/no_interaction_task_first_validator.rb` | `active_control` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | Validator for task-first, technical assignment, no-mid-cycle-user-chat, user queue, parent/child Done, worker aggregation, evidence, and Done gates. |
| `evals/no-interaction-task-first/fixtures.json` | `active_control` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | Regression fixtures for required tests A-T and positive no-interaction task-first closure. |
| `reports/audits/P0-no-interaction-task-first-closed-loop-audit-20260531.md` | `audit_only` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | Read-only audit proving the dedicated no-interaction task-first queue package was missing before this run and listing same-run fixes. |
| `reports/receipts/P0-no-interaction-task-first-closed-loop-implementation-receipt-20260531.md` | `operational_receipt` | false | false | AH-P0-NO-INTERACTION-TASK-FIRST | Implementation receipt for installed no-interaction task-first controls, prompt quality score, safety proof, and validation commands. |
| `governance/boundary-backup-docs-first-guardrail-policy.md` | `active_policy` | false | false | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | Scope manifest, forbidden roots, dynamic scope expansion, backup/rollback sizing, docs/API-first, no-blind-mutation, and evidence Done policy. |
| `governance/adr/ADR-boundary-backup-docs-first-guardrail-20260531.md` | `active_control` | false | false | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | ADR selecting validator-backed boundary/backup/docs controls over larger prompts and deferring runtime firewall mutation. |
| `schemas/scope_manifest.schema.json` | `active_control` | false | false | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | Schema for per-worker scope manifests with read/write allowlists, forbidden roots, docs decision, backup, rollback, validation, and no-user-chat policy. |
| `templates/boundary-backup/scope-manifest-template.md` | `active_template` | false | false | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | Scope manifest template for AgentHub workers before mutation. |
| `templates/boundary-backup/scope-expansion-request-template.md` | `active_template` | false | false | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | Scope expansion request template requiring T1 approval before writing newly discovered paths. |
| `validators/boundary_backup_docs_first_validator.rb` | `active_control` | false | false | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | Validator blocking F01-F15: forbidden non-live paths, out-of-scope writes, no backup, huge backup, docs/API bypass, Docker/DB destruction, chat loops, fake Done, and token-bloat retry. |
| `evals/boundary-backup-docs-first/fixtures.json` | `active_control` | false | false | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | Regression fixtures for TEST_SCOPE/BACKUP/DOCS/API/DOCKER/CHAT/LOOP/DONE/CONTEXT cases and positive gates. |
| `reports/audits/P0-boundary-backup-docs-first-guardrail-audit-20260531.md` | `audit_only` | false | false | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | Audit proving the dedicated boundary/backup/docs-first F01-F15 package was missing before this run and recording task-service route evidence. |
| `reports/receipts/P0-boundary-backup-docs-first-guardrail-implementation-receipt-20260531.md` | `operational_receipt` | false | false | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | Implementation receipt for installed boundary/backup/docs-first controls, source anchors, safety proof, and prompt quality score. |
| `governance/no-chat-deadlock-contour-policy.md` | `active_policy` | false | false | AH-P0-NO-CHAT-DEADLOCK-CONTOUR | No-chat deadlock contour policy binding user delta queue, TZ-before-mutation, forbidden paths, deadlock breaker, model/spawn receipts, task-service Done blockers, and final output compressor. |
| `governance/adr/ADR-no-chat-deadlock-contour-20260531.md` | `active_control` | false | false | AH-P0-NO-CHAT-DEADLOCK-CONTOUR | ADR selecting a validator-backed no-chat deadlock contour over prompt-only changes or runtime mutation. |
| `schemas/user_delta_queue.schema.json` | `active_control` | false | false | AH-P0-NO-CHAT-DEADLOCK-CONTOUR | Schema for active-run user deltas buffered into task/TZ checkpoints instead of stopping workers. |
| `templates/no-chat-deadlock/worker-final-evidence-template.md` | `active_template` | false | false | AH-P0-NO-CHAT-DEADLOCK-CONTOUR | Machine-readable worker final evidence template for RUN/TASK/role/scope/model/spawn/validation/residual fields. |
| `validators/no_chat_deadlock_contour_validator.rb` | `active_control` | false | false | AH-P0-NO-CHAT-DEADLOCK-CONTOUR | Validator for no-mid-cycle-chat, user delta queue, TZ gate, forbidden directories, live path proof, deadlock retries, model/spawn receipts, fake PASS, task-service physical write, final output, API-first, and T0 boundary. |
| `evals/no-chat-deadlock-contour/fixtures.json` | `active_control` | false | false | AH-P0-NO-CHAT-DEADLOCK-CONTOUR | Regression fixtures for the 13 observed no-chat/deadlock/scope/model/task-service/final-output failure cases plus positive closure. |
| `reports/audits/P0-no-chat-deadlock-contour-audit-20260531.md` | `audit_only` | false | false | AH-P0-NO-CHAT-DEADLOCK-CONTOUR | Read-only audit proving the final no-chat deadlock contour validator package was missing before this run. |
| `reports/receipts/P0-no-chat-deadlock-contour-implementation-receipt-20260531.md` | `operational_receipt` | false | false | AH-P0-NO-CHAT-DEADLOCK-CONTOUR | Implementation receipt for installed no-chat deadlock contour controls, safety scope, and prompt quality score. |
| `governance/contour-task-graph-gate-policy.md` | `active_policy` | false | false | AH-CONTOUR-TASK-GRAPH-20260601 | Contour ledger and YouTrack task graph closure policy; blocks final success while contour tasks are open, duplicated, orphaned, or missing physical readback. |
| `governance/adr/ADR-contour-task-graph-gate-20260601.md` | `active_control` | false | false | AH-CONTOUR-TASK-GRAPH-20260601 | ADR selecting Contour Ledger + Task Graph Gate over prompt-only reminders and full runtime engine. |
| `schemas/contour_task_graph.schema.json` | `active_control` | false | false | AH-CONTOUR-TASK-GRAPH-20260601 | Schema for contour id, task inventory, stage inventory, evidence inventory, validation inventory, blockers, and final receipt. |
| `templates/task-first/contour-task-card-template.md` | `active_template` | false | false | AH-CONTOUR-TASK-GRAPH-20260601 | Task card template for physical YouTrack contour parent/child tasks. |
| `validators/contour_task_graph_validator.rb` | `active_control` | false | false | AH-CONTOUR-TASK-GRAPH-20260601 | Deterministic validator for parent/child Done, YouTrack-open fake Done, physical task write, scope allowlist, message buffer, task explosion, retry loop, T0 mutation, QA-only proof, and final contour Done gates. |
| `evals/contour-task-graph/fixtures.json` | `active_control` | false | false | AH-CONTOUR-TASK-GRAPH-20260601 | Regression fixtures for Contour Ledger + Task Graph Gate. |
| `reports/receipts/P0-contour-task-graph-gate-implementation-receipt-20260601.md` | `operational_receipt` | false | false | AH-CONTOUR-TASK-GRAPH-20260601 | Receipt for installed contour task graph controls; records `TASK_SERVICE_PHYSICAL_WRITE_MISSING` residual for YouTrack MCP timeout during this run. |
| `governance/contour-hardlock-no-chat-task-graph-policy.md` | `active_policy` | false | false | AH-CONTOUR-HARDLOCK-NO-CHAT-TASK-GRAPH-20260601 | Composite contour hardlock policy combining no-chat, task-first, task graph, path scope, API/docs-first, rollback, spawn/model, loop breaker, truth Done, artifact lifecycle, PR queue, and final-output gates. |
| `schemas/contour_hardlock_state_machine.schema.json` | `active_schema` | false | false | AH-CONTOUR-HARDLOCK-NO-CHAT-TASK-GRAPH-20260601 | Schema for contour state machine, task graph, message policy, scope policy, model/spawn policy, and Done gate receipt. |
| `validators/contour_hardlock_no_chat_task_graph_validator.rb` | `active_control` | false | false | AH-CONTOUR-HARDLOCK-NO-CHAT-TASK-GRAPH-20260601 | Deterministic composite validator for final no-chat task graph hardlock release gates. |
| `evals/contour-hardlock-no-chat-task-graph/fixtures.json` | `active_control` | false | false | AH-CONTOUR-HARDLOCK-NO-CHAT-TASK-GRAPH-20260601 | Regression fixtures for 32 contour hardlock cases covering all required P0 failure signatures and positive closure. |
| `reports/receipts/P0-contour-hardlock-no-chat-task-graph-receipt-20260601.md` | `operational_receipt` | false | false | AH-CONTOUR-HARDLOCK-NO-CHAT-TASK-GRAPH-20260601 | Receipt for installed composite hardlock controls and validation; records `TASK_SERVICE_PHYSICAL_WRITE_MISSING` residual for physical YouTrack closure. |
| `governance/silent-to-done-contour-v2-policy.md` | `active_policy` | false | false | AH-SILENT-TO-DONE-V2-20260601 | Silent-to-Done v2 policy blocking mid-contour user output, enforcing contour message buffering, and mapping task-service write failures to the repair-required circuit breaker. |
| `schemas/contour_message_buffer.schema.json` | `active_schema` | false | false | AH-SILENT-TO-DONE-V2-20260601 | Schema for buffered user messages during active contours. |
| `validators/silent_to_done_contour_v2_validator.rb` | `active_control` | false | false | AH-SILENT-TO-DONE-V2-20260601 | Validator for intake-only questions, no mid-cycle phrases, contour message buffer, task-service circuit breaker, path authority, model/spawn receipts, retry budget, and Done gates. |
| `evals/silent-to-done-contour-v2/fixtures.json` | `active_control` | false | false | AH-SILENT-TO-DONE-V2-20260601 | Regression fixtures for Silent-to-Done v2 observed bad behaviors and positive closure. |
| `reports/receipts/P0-silent-to-done-contour-v2-receipt-20260601.md` | `operational_receipt` | false | false | AH-SILENT-TO-DONE-V2-20260601 | Receipt for installed Silent-to-Done v2 controls; records `TASK_SERVICE_PHYSICAL_WRITE_REPAIR_REQUIRED` residual for physical YouTrack writeback. |
| `governance/final-runtime-contour-enforcement-policy.md` | `active_policy` | false | false | AH-632 | Final runtime contour policy composing silent-to-terminal, user-delta queue, forbidden path pretool, live path proof, physical YouTrack write/readback, Done parser repair, model/spawn receipt, loop breaker, anti-spam-not-freeze, stale prompt quarantine, evidence/no-secret, and user-outcome gates. |
| `validators/final_runtime_contour_enforcement_validator.rb` | `active_control` | false | false | AH-632 | Deterministic final contour validator for the known bad examples and positive Done closure. |
| `evals/final-runtime-contour-enforcement/fixtures.json` | `active_control` | false | false | AH-632 | Regression fixtures for final runtime contour enforcement, including forbidden Hiddify `/root/gemini-space`, mid-contour chat, model/spawn mismatch, duplicate anti-spam, parent/child closure, context overflow, and valid closure. |
| `reports/receipts/P0-final-runtime-contour-enforcement-receipt-20260601.md` | `operational_receipt` | false | false | AH-632 | Receipt for final runtime contour enforcement; supersedes prior task-service blocker residuals after physical YouTrack write/readback was proven in the current contour. |
| `reports/incidents/P0-t0-boundary-violation-multi-agent-runaway-20260527.md` | `audit_only` | false | false | AH-590 | Incident report for owner-reported T0 boundary, mixed agent output, task-debt, and repo-first recurrence; evidence only. |
| `reports/receipts/P0-agenthub-backend-only-repo-first-architecture-receipt-20260526.md` | `operational_receipt` | false | false | AH-590 | Receipt for backend-only repo-first architecture package. |
| `reports/receipts/P0-t0-hard-stop-multi-agent-isolation-receipt-20260527.md` | `operational_receipt` | false | false | AH-590 | Receipt for the 2026-05-27 T0 hard-stop, multi-agent isolation, backend-only, and repo-first corrective package. |
| `reports/receipts/P0-task-debt-consolidation-receipt-20260527.md` | `operational_receipt` | false | false | AH-590 | Receipt for scope-family task-debt consolidation and duplicate-prevention rules. |
| `reports/receipts/P0-global-agent-control-secrets-and-repo-receipt-20260527.md` | `operational_receipt` | false | false | AH-590 | Receipt for global agent control, secrets registry, run-id schema normalization, and repo register coverage. |
| `reports/receipts/P0-agenthub-x-capability-self-audit-hard-enforcement-receipt-20260528.md` | `operational_receipt` | false | false | AH-590 | Receipt for AgentHub X capability matrix, validators, evals, two-level audit, and repo-first hard enforcement package. |
| `reports/receipts/P0-codex-spark-model-router-pr80-residual-receipt-20260528.md` | `operational_receipt` | false | false | AH-590 | Receipt for Codex Spark model-router enforcement, same-RUN fallback, surface-bound validation, and model-evidence Done gate. |
| `reports/receipts/P0-pr82-fallback-evidence-gate-fix-receipt-20260528.md` | `operational_receipt` | false | false | AH-590 | Receipt for PR #82/#83 fallback evidence gate correction, validator evals, registers, and readback. |
| `reports/receipts/P0-agenthub-self-healing-core-install-receipt-20260528.md` | `operational_receipt` | false | false | AH-590 | Installation receipt for self-healing core policy, schemas, runbooks, validator, E1-E15 evals, and register coverage. |
| `reports/receipts/P0-agenthub-self-healing-negative-tests-20260528.md` | `operational_receipt` | false | false | AH-590 | Negative-test receipt proving E1-E15 expected outcomes. |
| `governance/agenthub-methodology-router.md` | `active_policy` | false | false | AH-594 | Adaptive 25-methodology router policy with profile selection, token-bloat denial, role coverage, and model-route constraints. |
| `governance/agenthub-blackbox-route-registry.md` | `active_control` | false | false | AH-594 | Black-box execution route registry covering shell, language runtimes, Docker, system services, git/gh, cloud CLI, curl/API, SSH, MCP, AgentHub adapters, browser, DB, proxy/NPM/DNS/SSL routes. |
| `schemas/agenthub_methodology_router.schema.json` | `active_control` | false | false | AH-594 | JSON schema for methodology router decisions. |
| `schemas/agenthub_blackbox_route_registry.schema.json` | `active_control` | false | false | AH-594 | JSON schema for black-box route registry records. |
| `validators/agenthub_methodology_router_validator.rb` | `active_control` | false | false | AH-594 | Deterministic validator for methodology profile selection, method-pack coverage, token-bloat denial, repo-first gate, and weak-Done denials. |
| `validators/agenthub_blackbox_route_validator.rb` | `active_control` | false | false | AH-594 | Deterministic validator for registered-route enforcement, T0/T1 denies, RUN/task/surface/model/evidence gates, and self-repair loop stop. |
| `evals/agenthub-methodology-router/fixtures.json` | `active_control` | false | false | AH-594 | Negative/positive methodology router fixtures covering N10-N21 and P1-P5/P8. |
| `evals/agenthub-blackbox-routes/fixtures.json` | `active_control` | false | false | AH-594 | Negative/positive route fixtures covering N1-N9, N18, N22, unregistered route, repo receipt target, and P6/P7/P9/P10. |
| `reports/audits/P0-methodology-enforcement-certification-20260528.md` | `audit_only` | false | false | AH-594 | Fact audit, certification matrix, role/model/route findings, test results, repaired gaps, and residuals. |
| `reports/receipts/P0-methodology-enforcement-certification-receipt-20260528.md` | `operational_receipt` | false | false | AH-594 | Installation receipt for methodology enforcement and black-box route closure package. |
| `reports/audits/P0-methodology-enforcement-final-readback-20260528.md` | `audit_only` | false | false | AH-594 | Final readback audit placeholder updated after PR merge and task readback. |
| `governance/project-sources/chatgpt-project-five-source-mirror.md` | `active_source` | false | false | AH-595 | Stable five ChatGPT Project Sources mirror; methodology HTML is catalog data, not a sixth always-loaded Project Source. |
| `governance/methodologies/ai-agent-methodology-catalog.md` | `active_source` | false | false | AH-595 | Governed 25-methodology catalog mirrored from protected source `https://b244.ru/fx`; raw HTML not stored. |
| `governance/methodologies/methodology-router-policy.md` | `active_policy` | false | false | AH-595 | Adaptive methodology-router policy binding catalog, profiles, skills, negative matches, evidence targets, and no-all-method bloat rule. |
| `governance/methodologies/methodology-router-adr.md` | `active_policy` | false | false | AH-595 | ADR choosing balanced catalog/schema/validator/eval mirror instead of sixth source or prompt-only documentation. |
| `schemas/methodology-router.schema.json` | `active_schema` | false | false | AH-595 | Schema for methodology router selection receipts with active/forbidden methods and skills, scope, negative matches, RUN_ID, and evidence targets. |
| `schemas/project-source-mirror.schema.json` | `active_schema` | false | false | AH-595 | Schema for five-source mirror metadata and protected methodology catalog linkage. |
| `validators/methodology-router/validate-methodology-router.rb` | `active_control` | false | false | AH-595 | Validator for project-source mirror, method selection, T0 denial, bloat denial, incident/architecture/model/report/retry gates, and owner-only credential gate. |
| `evals/methodology-router/fixtures.json` | `active_control` | false | false | AH-595 | Negative and positive fixtures for final project methodology mirror enforcement. |
| `prompts/templates/methodology-router-worker-template.md` | `active_template` | false | false | AH-595 | Compact worker prompt template referencing catalog path/hash instead of pasting all methodologies. |
| `reports/audits/P0-project-methodology-mirror-gap-audit-20260528.md` | `audit_only` | false | false | AH-595 | Pre-implementation gap audit for methodology project-source mirror and closed-loop enforcement. |
| `reports/receipts/P0-project-methodology-mirror-implementation-receipt-20260528.md` | `operational_receipt` | false | false | AH-595 | Implementation receipt for project methodology mirror, catalog, schemas, validators, evals, registers, and readback. |
| `reports/validations/P0-project-methodology-mirror-enforcement-validation-20260528.md` | `audit_only` | false | false | AH-595 | Validation report for project methodology mirror enforcement and negative tests. |
| `reports/incidents/P0-komodo-kutt-agenthub-final-closure-report-20260528.md` | `audit_only` | false | false | AH-574 | Final incident closure report for Komodo/Kutt/Portainer/AgentHub repository reporting; evidence only, no secrets. |
| `reports/receipts/P0-komodo-kutt-agenthub-final-closure-receipt-20260528.md` | `operational_receipt` | false | false | AH-574 | Final repository closure receipt with task readback, ledger readback, register coverage, and no secret values. |
| `reports/audits/P0-agenthub-prompt-implementation-ledger-readback-20260528.md` | `audit_only` | false | false | AH-574 | Prompt implementation ledger readback for the final closure chain; evidence only, not active policy. |
| `reports/audits/P0-codex-spark-mandatory-execution-factcheck-20260529.md` | `audit_only` | false | false | AH-601 | Factcheck audit for Codex Spark mandatory execution guardrail; records installed controls and missing execution proof. |
| `reports/receipts/P0-codex-spark-mandatory-execution-guardrail-receipt-20260529.md` | `operational_receipt` | false | false | AH-601 | Receipt for the 2026-05-29 Spark mandatory execution audit; final state is not Done because execution proof is missing. |
| `reports/audits/P0-codex-spark-real-execution-proof-audit-20260529.md` | `audit_only` | false | false | AH-601 | Audit proving one harmless Codex Spark code/config/YAML worker invocation through AgentHub command worker, with invocation stream and no runtime mutation. |
| `reports/receipts/P0-codex-spark-real-execution-proof-receipt-20260529.md` | `operational_receipt` | false | false | AH-601 | Receipt closing CODEX_SPARK_EXECUTION_NOT_PROVEN for the synthetic proof scope; cost telemetry remains unavailable but non-blocking. |
| `reports/audits/P0-codex-spark-usage-metric-contradiction-audit-20260529.md` | `audit_only` | false | false | AH-601 | Truth-redteam correction: owner-visible Spark usage meter contradicts PR #98 closure, so command/request proof is downgraded to partial. |
| `reports/receipts/P0-codex-spark-usage-metric-contradiction-receipt-20260529.md` | `operational_receipt` | false | false | AH-601 | Receipt reopening AH-601 blocker as CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE until independent platform/model proof exists. |
| `reports/audits/P0-codex-spark-hard-route-execution-audit-20260529.md` | `audit_only` | false | false | AH-601 | Hard-route closure audit: no rerun of command-request proof; terminal blocker remains missing independent Spark usage/model proof. |
| `reports/receipts/P0-codex-spark-hard-route-execution-receipt-20260529.md` | `operational_receipt` | false | false | AH-601 | Operational receipt for BLOCKED_WITH_PROOF state: CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE. |
| `reports/audits/P0-codex-spark-route-technology-repair-audit-20260529.md` | `audit_only` | false | false | AH-601 | Technology repair audit for executable Spark proof gate rejecting command/self-report evidence without platform proof. |
| `reports/receipts/P0-codex-spark-route-technology-repair-receipt-20260529.md` | `operational_receipt` | false | false | AH-601 | Receipt for model-token router repair: 14-case Spark proof gate installed; usage blocker remains active. |
| `reports/audits/P0-codex-spark-json-usage-execution-audit-20260529.md` | `audit_only` | false | false | AH-601 | Audit for AgentHub-routed Codex CLI JSON usage receipt from explicit Spark invocation; no secrets or runtime mutation. |
| `reports/receipts/P0-codex-spark-json-usage-execution-receipt-20260529.md` | `operational_receipt` | false | false | AH-601 | Receipt for Codex Spark JSON usage proof: explicit Spark model request, non-zero usage tokens, proof artifact hash, and no fallback. |
| `reports/audits/P0-codex-spark-circuit-breaker-full-closure-audit-20260529.md` | `audit_only` | false | false | AH-601 | Audit for primary-model burn circuit breaker installation and Spark platform-metric residual boundary. |
| `reports/receipts/P0-codex-spark-circuit-breaker-full-closure-receipt-20260529.md` | `operational_receipt` | false | false | AH-601 | Receipt for primary-model burn circuit breaker: active route gate, containment worker evidence, validation, and platform metric residual. |
| `governance/model-portfolio-utilization-policy.md` | `active_policy` | false | false | AH-590 | Global model portfolio route policy: route classes, proof/idle/unavailable states, Spark platform-meter residual separation, and stale artifact controls. |
| `schemas/model_route_invocation_receipt.schema.json` | `active_schema` | false | false | AH-590 | JSON schema for model route invocation receipts and per-route evidence fields. |
| `validators/model_portfolio_router_validator.rb` | `active_control` | false | false | AH-590 | Deterministic validator for global model route classes, wrong-route denials, fallback proof, lifecycle, PR queue, and self-healing escalation gates. |
| `evals/model-portfolio-routing/fixtures.json` | `active_control` | false | false | AH-590 | Positive and negative fixtures for global model portfolio routing and proof/idle/unavailable classification. |
| `reports/audits/P0-global-model-portfolio-route-evaluation-20260529.md` | `audit_only` | false | false | AH-590 | Evaluation of global model portfolio route state, PR #92/#93 supersession, active evidence, and platform-meter residual. |
| `reports/validations/P0-global-model-portfolio-route-validation-20260529.md` | `audit_only` | false | false | AH-590 | Validation report for global model portfolio route controls and negative gates. |
| `reports/receipts/P0-global-model-portfolio-inventory-receipt-20260529.md` | `operational_receipt` | false | false | AH-590 | Inventory receipt for approved helper models, route classes, schema, validator, fixtures, and platform meter residual. |
| `reports/receipts/P0-global-model-portfolio-route-closure-receipt-20260529.md` | `operational_receipt` | false | false | AH-590 | Closure receipt for global model portfolio route: local Spark proof, platform meter residual, route validator, and stale PR reconciliation state. |
| `reports/receipts/P0-agenthub-closed-contour-task-sprawl-closure-receipt-20260529.md` | `operational_receipt` | false | false | AH-590 | Receipt for bounded closed-contour task sprawl cleanup: closes AH-590/AH-601 scope and excludes unrelated domain/client backlog tasks. |
| `reports/receipts/P0-model-route-terminal-finalizer-receipt-20260529.md` | `operational_receipt` | false | false | AH-590 | Terminal finalizer receipt: converts mixed model-route residual state to DONE_WITH_GLOBAL_MODEL_ROUTE_EVIDENCE_TERMINAL with no active blocker. |
| `reports/receipts/P0-codex-spark-code-authoring-model-enforcement-receipt-20260529.md` | `operational_receipt` | false | false | AH-590/AH-601 | Codex Spark code-authoring model enforcement: AgentHub code/config/YAML/test/IaC work must use requested and resolved `gpt-5.3-codex-spark`; non-Spark Codex, GPT-5.5, lease/requeue, PR-only, and policy-only proof are rejected. |
| `reports/receipts/P0-runtime-spark-route-restore-implementation-receipt-20260529.md` | `operational_receipt` | false | false | AH-590/AH-601 | Implementation receipt for AgentHub runtime Spark route restoration: runtime defaults/templates/checks updated, canary requested/resolved `gpt-5.3-codex-spark`, PR #113 superseded as audit-only, stale folder delete safely denied as non-blocking. |
| `reports/validations/P0-runtime-spark-route-restore-validation-20260529.md` | `audit_only` | false | false | AH-590/AH-601 | Verifier report for runtime Spark route restoration validations and canary evidence. |
| `reports/receipts/P0-agenthub-global-model-router-nochat-t0-hardlock-receipt-20260606.md` | `operational_receipt` | false | false | AGENTHUB_CORE_REPAIR_20260606 | Receipt for global AgentHub model-router, T0 no-code/no-runtime, backend-only no-chat, no-freeze self-healing, YouTrack task-ledger, FinalReportGuard, and token-budget hardlock installation; runtime validation PASS. |
| `reports/receipts/P0-agenthub-runtime-hardlock-system-architecture-receipt-20260606.md` | `operational_receipt` | false | false | AH-675 | Runtime proof receipt for installed AgentHub core hardlock: Codex hooks config, runtime hook command, runtime gate, policy, fixtures, validators, YouTrack task readback, and full runtime validation PASS. |
| `reports/audits/AGENTHUB-ORCHESTRATOR-FULL-SYSTEM-AUDIT-20260607.md` | `audit_only` | false | false | AGENTHUB_ORCHESTRATOR_FULL_AUDIT_FIRST_CONTRACT_20260607 | Full-system audit-only verification of repository-state, model-route, role-boundary, prompt lifecycle, and deadlock controls. |
| `reports/validations/AGENTHUB-ORCHESTRATOR-FULL-SYSTEM-AUDIT-VALIDATION-20260607.md` | `audit_only` | false | false | AGENTHUB_ORCHESTRATOR_FULL_AUDIT_FIRST_CONTRACT_20260607 | Validation report for the 2026-06-07 full-system audit evidence set. |
| `reports/receipts/AGENTHUB-ORCHESTRATOR-FULL-SYSTEM-AUDIT-RECEIPT-20260607.md` | `operational_receipt` | false | false | AGENTHUB_ORCHESTRATOR_FULL_AUDIT_FIRST_CONTRACT_20260607 | Audit receipt for full-system verification completion and residual `DOCUMENT_DEDUPE_GATE_MISSING` blocker. |
| `governance/document-dedupe-gate-policy.md` | `active_policy` | false | false | AGENTHUB_DOCUMENT_DEDUPE_GATE_REPAIR_PROMPT_20260607 | Repository-only document/content dedupe policy; no automatic deletion or runtime mutation authority. |
| `validators/document_dedupe_gate_validator.rb` | `active_control` | false | false | AGENTHUB_DOCUMENT_DEDUPE_GATE_REPAIR_PROMPT_20260607 | Deterministic register/index document dedupe validator for artifact ids, paths, active families, prompt replay, audit replay, and source-task scope duplicates. |
| `evals/document-dedupe-gate/fixtures.json` | `active_control` | false | false | AGENTHUB_DOCUMENT_DEDUPE_GATE_REPAIR_PROMPT_20260607 | Positive and negative fixtures for the document dedupe gate. |
| `reports/validations/P1-document-dedupe-gate-validation-20260607.md` | `audit_only` | false | false | AGENTHUB_DOCUMENT_DEDUPE_GATE_REPAIR_PROMPT_20260607 | Validation report for document dedupe gate syntax, fixtures, live register/index scan, and no-secret/no-runtime checks. |
| `reports/receipts/P1-document-dedupe-gate-implementation-receipt-20260607.md` | `operational_receipt` | false | false | AGENTHUB_DOCUMENT_DEDUPE_GATE_REPAIR_PROMPT_20260607 | Implementation receipt closing `DOCUMENT_DEDUPE_GATE_MISSING` for repository governance/control-spine evidence. |

| `prompts/architecture/AGENTHUB-POST-PR149-SCOPE-LANE-SELF-HEALING-REPO-HYGIENE-20260610.txt` | `active_control` | false | false | AH-738 / AH-731 follow-up | Post-PR149 scope-lane contract: obsolete blocker suppression, routine self-healing, repo lifecycle inventory lanes, and fresh-branch deferral. |
| `reports/validations/AGENTHUB-POST-PR149-SCOPE-LANE-SELF-HEALING-VALIDATION-20260610.md` | `operational_receipt` | false | false | AH-738 / AH-731 follow-up | Validation and red-team result for the post-PR149 scope-lane contract. |
| `reports/receipts/AGENTHUB-POST-PR149-SCOPE-LANE-SELF-HEALING-RECEIPT-20260610.md` | `operational_receipt` | false | false | AH-738 / AH-731 follow-up | Receipt for installing the post-PR149 scope-lane self-healing control candidate. |
| `reports/patches/AGENTHUB-POST-PR149-SCOPE-LANE-SELF-HEALING-REGISTER-PATCH-20260610.diff` | `operational_receipt` | false | false | AH-738 / AH-731 follow-up | Patch proposal for index/register/PR queue coverage. |
| `prompts/architecture/AGENTHUB-REPOSITORY-BRIDGE-DEEP-EXECUTION-CONTRACT-20260607.txt` | `active_control` | false | false | GitHub issue repository bridge / PR #147 carried by PR #152 | Canonical repository-bridge contract preserved after PR consolidation. |
| `reports/receipts/AGENTHUB-REPOSITORY-BRIDGE-DEEP-EXECUTION-CONTRACT-RECEIPT-20260607.md` | `operational_receipt` | false | false | GitHub issue repository bridge / PR #147 carried by PR #152 | Historical receipt retained while PR `#147` is administratively superseded by PR `#152`. |

## AH-796 Four Prompt Architecture Hardlock

| Artifact | Lifecycle | Default load | Safe to replay | Source task | Notes |
|---|---|---:|---:|---|---|
| `governance/agenthub-four-prompt-architecture-hardlock-policy.md` | `active_policy` | false | false | AH-796 | Durable four prompt plus fifth-front architecture hardlock policy. |
| `governance/four-prompts-system-hardlock-policy.md` | `active_policy` | false | false | AH-796 | Supporting system hardlock policy for the four prompt source set. |
| `schemas/environment_route_proof.schema.json` | `active_schema` | false | false | AH-796 | Environment and AgentHub route proof schema. |
| `schemas/workflow_impact_audit.schema.json` | `active_schema` | false | false | AH-796 | Workflow impact audit schema. |
| `schemas/owner_incident_recovery_lane.schema.json` | `active_schema` | false | false | AH-796 | Owner incident recovery lane schema. |
| `schemas/four_prompt_architecture_install_receipt.schema.json` | `active_schema` | false | false | AH-796 | Four prompt architecture install receipt schema. |
| `validators/four_prompt_architecture_hardlock_validator.rb` | `active_control` | false | false | AH-796 | Validator rejecting local-only closure, direct bypass, owner handoff, fake Done, and repeated blocked retries. |
| `fixtures/four-prompt-architecture-hardlock/fixtures.json` | `active_control` | false | false | AH-796 | Positive and negative fixtures for the four prompt architecture hardlock. |
| `runbooks/four-prompt-architecture-hardlock-runbook.md` | `active_runbook` | false | false | AH-796 | Closed-contour execution runbook. |
| `prompts/templates/four-prompt-architecture-hardlock-worker-template.txt` | `active_template` | false | false | AH-796 | Worker template for four prompt architecture hardlock. |
| `reports/validations/AH-796-four-prompt-plus-fifth-front-full-report-20260615.md` | `validation_report` | false | false | AH-796 | Full report after four prompts and fifth-front implementation prompt. |
| `reports/validations/AH-796-four-prompt-architecture-hardlock-validation-20260615.md` | `validation_report` | false | false | AH-796 | Validation report for four prompt architecture hardlock. |
| `reports/receipts/AH-796-four-prompt-architecture-hardlock-receipt-20260615.md` | `operational_receipt` | false | false | AH-796 | Repository package receipt; PR/task Done readback remains blocked. |
| `governance/agenthub-omega-fallback-permission-lane-hardlock-policy.md` | `active_policy` | false | false | AH-796 | Omega connector fallback and permission-lane hardlock policy. |
| `schemas/agenthub_permission_lane_runtime_grant.schema.json` | `active_schema` | false | false | AH-796 | Runtime permission lane grant schema. |
| `schemas/github_connector_fallback_route.schema.json` | `active_schema` | false | false | AH-796 | GitHub connector to scoped gh fallback route schema. |
| `schemas/blocked_command_loop_guard.schema.json` | `active_schema` | false | false | AH-796 | Blocked-command loop guard schema. |
| `validators/omega_fallback_permission_lane_validator.rb` | `active_control` | false | false | AH-796 | Validator for connector fallback, permission lanes, blocked loops, owner handoff, fake Done, and product touch. |
| `fixtures/omega-fallback-permission-lane/fixtures.json` | `active_control` | false | false | AH-796 | Omega fallback permission lane fixtures. |
| `runbooks/omega-fallback-permission-lane-runbook.md` | `active_runbook` | false | false | AH-796 | Omega connector fallback and permission lane runbook. |
| `prompts/templates/omega-fallback-permission-lane-worker-template.txt` | `active_template` | false | false | AH-796 | Omega worker template requiring lane declaration. |
| `reports/validations/AH-796-omega-fallback-permission-lane-validation-20260615.md` | `validation_report` | false | false | AH-796 | Omega validation report. |
| `reports/receipts/AH-796-omega-fallback-permission-lane-receipt-20260615.md` | `operational_receipt` | false | false | AH-796 | Omega package receipt; PR #175 merged and main readback passed. |

## PR #153 Smart Self-Healing Authority Elevation Coverage

| Artifact | Lifecycle | Default load | Safe to replay | Source task | Notes |
|---|---|---:|---:|---|---|
| `governance/agenthub-lane-router-and-blocker-scope-policy.md` | `active_policy` | false | false | AH-738 / PR153 | Lane 0-6 routine blocker self-healing policy. |
| `governance/agenthub-scoped-autonomy-lane6-destructive-proof-profile.md` | `active_policy` | false | false | AH-738 / PR153 | Lane 6 destructive proof profile. |
| `schemas/agenthub-blocker-taxonomy.schema.json` | `active_control` | false | false | AH-738 / PR153 | Blocker taxonomy schema. |
| `schemas/agenthub_action_authorization_receipt.schema.json` | `active_control` | false | false | AH-738 / PR153 | Lane-aware action authorization receipt schema. |
| `schemas/agenthub_lane6_destruction_proof.schema.json` | `active_control` | false | false | AH-738 / PR153 | Lane 6 destructive proof schema. |
| `validators/agenthub_action_policy_validator.rb` | `active_control` | false | false | AH-738 / PR153 | Lane-aware authorization validator. |
| `validators/agenthub_self_healing_validator.rb` | `active_control` | false | false | AH-738 / PR153 | Routine blocker self-healing validator. |
| `validators/t0_escape_boundary_gates_validator.rb` | `active_control` | false | false | AH-738 / PR153 | T0 boundary validator. |
| `evals/agenthub-self-healing/fixtures/scoped_autonomy_contract_20260611.json` | `active_control` | false | false | AH-738 / PR153 | PR #153 regression fixture. |
| `prompts/architecture/AGENTHUB-SMART-SELF-HEALING-AUTHORITY-ELEVATION-20260611.txt` | `active_control` | false | false | AH-738 / PR153 | Architecture control prompt; not default-loaded. |
| `reports/validations/AGENTHUB-SMART-SELF-HEALING-AUTHORITY-ELEVATION-VALIDATION-20260611.md` | `operational_receipt` | false | false | AH-738 / PR153 | Final validation report. |
| `reports/receipts/AGENTHUB-SMART-SELF-HEALING-AUTHORITY-ELEVATION-RECEIPT-20260611.md` | `operational_receipt` | false | false | AH-738 / PR153 | Final PR #153 closure receipt. |
