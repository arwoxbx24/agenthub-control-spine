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
| `ARTIFACT_REGISTER.md` | artifact lifecycle/default-load register | AH-522 | active |
| `PR_QUEUE_REGISTER.md` | PR queue decision register | AH-523 | active |
| `context/agenthub-current-context-pack.md` | current default context pack | AH-523 | active |
| `GOVERNANCE.md` | governance overview | AH-494 | draft |
| `SECURITY.md` | security policy | AH-494 | draft |
| `CHANGELOG.md` | changelog | AH-494 | draft |
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
| `governance/agenthub-skill-pack-command-connector-patterns.md` | governance control | AH-531 | active |
| `governance/agenthub-eval-context-health-patterns.md` | governance control | AH-532 | active |
| `governance/openai-cyber-safe-request-router.md` | governance policy | AH-541 | active |
| `governance/policies/t0-direct-action-hard-stop-policy.md` | governance policy | AH-590 | active |
| `governance/policies/backend-only-owner-communication-policy.md` | governance policy | AH-590 | active |
| `governance/policies/agenthub-self-healing-core-policy.md` | governance policy | AH-590 | active |
| `governance/policies/agenthub-capability-matrix.md` | governance policy | AH-590 | active |
| `governance/global-agent-control-enforcement-policy.md` | governance policy | AH-590 | active |
| `governance/secrets-registry-policy.md` | governance policy | AH-590 | active |
| `governance/model-token-routing-policy.md` | governance policy | AH-590 | active |
| `reports/receipts/P0-codex-spark-code-authoring-model-enforcement-receipt-20260529.md` | operational receipt | AH-590/AH-601 | active |
| `reports/receipts/P0-runtime-spark-route-restore-implementation-receipt-20260529.md` | implementation receipt | AH-590/AH-601 | active |
| `reports/validations/P0-runtime-spark-route-restore-validation-20260529.md` | validation report | AH-590/AH-601 | active |
| `governance/codex-native-capability-router-policy.md` | governance policy | AH-622 | active |
| `schemas/codex_native_worker_receipt.schema.json` | schema | AH-622 | active |
| `validators/codex_native_capability_router_validator.rb` | active control | AH-622 | active |
| `evals/codex-native-capability-router/fixtures.json` | eval fixtures | AH-622 | active |
| `runbooks/codex-native-spawn-subagent-worker-runbook.md` | runbook | AH-622 | active |
| `prompts/implementation/agenthub-codex-native-spawn-worker-template.txt` | worker template | AH-622 | active |
| `reports/receipts/P0-codex-native-spark-spawn-canary-20260530.md` | canary receipt | AH-622 | active |
| `reports/receipts/P0-codex-native-spark-spawn-canary-artifact-20260530.json` | canary output artifact | AH-622 | active |
| `reports/receipts/P0-codex-native-readonly-parallel-canary-20260530.md` | canary receipt | AH-622 | active |
| `reports/receipts/P0-codex-native-mcp-diagnostic-canary-20260530.md` | canary receipt | AH-622 | active |
| `reports/receipts/P0-codex-native-background-terminal-canary-20260530.md` | canary receipt | AH-622 | active |
| `reports/receipts/P0-codex-native-capability-enrichment-implementation-receipt-20260530.md` | operational receipt | AH-622 | active |
| `validators/three_component_cycle_validator.rb` | validator | AH-615/AH-619/AH-622 | active |
| `evals/three-component-cycle/fixtures.json` | eval fixtures | AH-615/AH-619/AH-622 | active |
| `reports/receipts/P0-three-component-cycle-implementation-receipt-20260531.md` | operational receipt | AH-615/AH-619/AH-622 | active |
| `governance/agenthub-closed-loop-recovery-policy.md` | governance policy | AH-P0-CLOSED-LOOP-RECOVERY | active |
| `schemas/spawned_worker_dispatch.schema.json` | schema | AH-P0-CLOSED-LOOP-RECOVERY | active |
| `schemas/closed_loop_autonomy.schema.json` | schema | AH-P0-CLOSED-LOOP-RECOVERY | active |
| `validators/closed_loop_recovery_validator.rb` | validator | AH-P0-CLOSED-LOOP-RECOVERY | active |
| `evals/closed-loop-recovery/fixtures.json` | eval fixtures | AH-P0-CLOSED-LOOP-RECOVERY | active |
| `prompts/closed-loop/agenthub_closed_loop_worker_dispatch.txt` | worker template | AH-P0-CLOSED-LOOP-RECOVERY | active |
| `prompts/closed-loop/agenthub_architect_recovery_contract.txt` | architect contract | AH-P0-CLOSED-LOOP-RECOVERY | active |
| `reports/receipts/P0-closed-loop-recovery-implementation-receipt-20260531.md` | operational receipt | AH-P0-CLOSED-LOOP-RECOVERY | active |
| `governance/api-documentation-first-guardrail-policy.md` | governance policy | AH-P0-DOCS-API-FIRST-GUARDRAIL | active |
| `governance/adr/ADR-api-documentation-first-agenthub-guardrail-20260531.md` | architecture decision record | AH-P0-DOCS-API-FIRST-GUARDRAIL | active |
| `templates/api-first/api-route-sheet-template.md` | template | AH-P0-DOCS-API-FIRST-GUARDRAIL | active |
| `templates/api-first/documentation-lookup-gate-template.md` | template | AH-P0-DOCS-API-FIRST-GUARDRAIL | active |
| `schemas/truth_ledger.schema.json` | schema | AH-P0-DOCS-API-FIRST-GUARDRAIL | active |
| `validators/api_documentation_first_guardrail_validator.rb` | validator | AH-P0-DOCS-API-FIRST-GUARDRAIL | active |
| `evals/docs-api-first/fixtures.json` | eval fixtures | AH-P0-DOCS-API-FIRST-GUARDRAIL | active |
| `reports/audits/P0-api-documentation-first-guardrail-audit-20260531.md` | audit report | AH-P0-DOCS-API-FIRST-GUARDRAIL | audit-only |
| `reports/receipts/P0-api-documentation-first-guardrail-implementation-receipt-20260531.md` | operational receipt | AH-P0-DOCS-API-FIRST-GUARDRAIL | active |
| `governance/no-interaction-task-first-closed-loop-policy.md` | governance policy | AH-P0-NO-INTERACTION-TASK-FIRST | active |
| `governance/adr/ADR-no-interaction-task-first-closed-loop-20260531.md` | architecture decision record | AH-P0-NO-INTERACTION-TASK-FIRST | active |
| `schemas/run_user_input_queue.schema.json` | schema | AH-P0-NO-INTERACTION-TASK-FIRST | active |
| `schemas/technical_assignment.schema.json` | schema | AH-P0-NO-INTERACTION-TASK-FIRST | active |
| `templates/task-first/technical-assignment-template.md` | template | AH-P0-NO-INTERACTION-TASK-FIRST | active |
| `templates/task-first/run-user-input-queue-event-template.md` | template | AH-P0-NO-INTERACTION-TASK-FIRST | active |
| `validators/no_interaction_task_first_validator.rb` | validator | AH-P0-NO-INTERACTION-TASK-FIRST | active |
| `evals/no-interaction-task-first/fixtures.json` | eval fixtures | AH-P0-NO-INTERACTION-TASK-FIRST | active |
| `reports/audits/P0-no-interaction-task-first-closed-loop-audit-20260531.md` | audit report | AH-P0-NO-INTERACTION-TASK-FIRST | audit-only |
| `reports/receipts/P0-no-interaction-task-first-closed-loop-implementation-receipt-20260531.md` | operational receipt | AH-P0-NO-INTERACTION-TASK-FIRST | active |
| `governance/boundary-backup-docs-first-guardrail-policy.md` | governance policy | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | active |
| `governance/adr/ADR-boundary-backup-docs-first-guardrail-20260531.md` | architecture decision record | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | active |
| `schemas/scope_manifest.schema.json` | schema | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | active |
| `templates/boundary-backup/scope-manifest-template.md` | template | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | active |
| `templates/boundary-backup/scope-expansion-request-template.md` | template | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | active |
| `validators/boundary_backup_docs_first_validator.rb` | validator | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | active |
| `evals/boundary-backup-docs-first/fixtures.json` | eval fixtures | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | active |
| `reports/audits/P0-boundary-backup-docs-first-guardrail-audit-20260531.md` | audit report | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | audit-only |
| `reports/receipts/P0-boundary-backup-docs-first-guardrail-implementation-receipt-20260531.md` | operational receipt | AH-P0-BOUNDARY-BACKUP-DOCS-FIRST | active |
| `governance/agenthub-x-capability-matrix.md` | governance policy | AH-590 | active |
| `governance/adr/ADR-agenthub-x-controlled-capability-matrix-20260528.md` | architecture decision record | AH-590 | active |
| `governance/adr/ADR-codex-spark-model-router-enforcement-20260528.md` | architecture decision record | AH-590 | active |
| `runbooks/chatgpt-github-connect.md` | runbook | AH-494 | draft |
| `runbooks/secret-leak-response.md` | runbook | AH-500 | active |
| `runbooks/agenthub-locked-run-recovery.md` | runbook | AH-507 | active |
| `runbooks/teamlead-t0-role-drift-emergency-stop.md` | runbook | AH-510 | active |
| `runbooks/prompt-intake-flow.md` | runbook | AH-494 | active |
| `runbooks/codex-cli-usage.md` | runbook | AH-494 | active |
| `runbooks/control-spine-pr-queue-and-artifact-lifecycle.md` | runbook | AH-523 | active |
| `runbooks/agent-shortlink-intake-and-report-placement.md` | runbook | AH-529 | active |
| `runbooks/agenthub-pattern-adaptation-control-loop.md` | runbook | AH-531/AH-532 | active |
| `runbooks/chatgpt-cyber-flag-recovery-runbook.md` | runbook | AH-541 | active |
| `runbooks/agenthub-x-capability-remediation.md` | runbook | AH-590 | active |
| `runbooks/agenthub-self-healing-route-recovery.md` | runbook | AH-590 | active |
| `runbooks/agenthub-secrets-handle-registry.md` | runbook | AH-590 | active |
| `templates/github/secret-scan-workflow.yml` | GitHub Actions template | AH-500 | active |
| `.github/workflows/secret-scan.yml` | control-spine workflow | AH-500 | active |
| `templates/security/gitleaks.toml` | scanner config template | AH-500 | active |
| `templates/git-hooks/pre-commit-secret-scan.sh` | git hook template | AH-500 | active |
| `templates/git-hooks/pre-push-secret-scan.sh` | git hook template | AH-500 | active |
| `prompts/security/teamlead-t0-github-secret-defense-rollout.txt` | reusable prompt | AH-500 | active |
| `prompts/apps/AH-507-chatgpt-control-app-implementation-prompt.md` | implementation prompt | AH-507 | active |
| `prompts/implementation/anthropic-knowledge-work-pattern-adaptation-worker.txt` | implementation brief | AH-531 | active |
| `prompts/implementation/microsoft-ai-engineering-coach-pattern-adaptation-worker.txt` | implementation brief | AH-532 | active |
| `prompts/templates/agenthub-safe-devops-incident-dispatch.txt` | dispatch template | AH-541 | active |
| `prompts/templates/agenthub-safe-control-plane-repair-dispatch.txt` | dispatch template | AH-541 | active |
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
| `reports/devops/komodo-orchestration-roadmap-20260526.md` | devops architecture report | AH-571 | audit-only |
| `reports/devops/komodo-orchestration-task-decomposition-20260526.md` | implementation task decomposition | AH-571 | active-control |
| `reports/receipts/npm-docker-domain-route-ah513-ah518-receipt-20260523.md` | operational receipt | AH-513/AH-518 | partial-with-blocker |
| `reports/receipts/RUN-komodo-orchestration-20260526-receipt.md` | control-spine receipt | AH-571 | operational-receipt |
| `reports/receipts/RUN-komodo-process-hardening-20260526-receipt.md` | control-spine receipt | AH-571 | operational-receipt |
| `reports/receipts/AH-574-komodo-live-install-20260526.md` | operational receipt | AH-574 | operational-receipt |
| `reports/receipts/AH-575-komodo-orchestrator-readback-20260527.md` | operational receipt | AH-575 | operational-receipt |
| `reports/receipts/AH-575-komodo-live-read-route-enable-20260527.md` | operational receipt | AH-575 | operational-receipt |
| `reports/receipts/AH-575-kutt-first-migration-preflight-20260527.md` | operational receipt | AH-575 | operational-receipt |
| `reports/receipts/AH-575-komodo-import-route-discovery-20260527.md` | operational receipt | AH-575 | operational-receipt |
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
| `reports/receipts/AH-531-AH-532-pattern-implementation-receipt.md` | external pattern implementation receipt | AH-531/AH-532 | pass |
| `reports/receipts/RUN-agenthub-openai-cyber-flag-safe-router-20260525-openai-cyber-safe-router-receipt.md` | control-spine receipt | AH-541 | pending-validation |
| `registries/agenthub-control-spine-id-register.md` | AgentHub/YouTrack/GitHub ID register | AH-522 | active |
| `skills-drafts/t0-non-authoring-gate/SKILL.md` | draft skill | AH-511 | draft |
| `skills-drafts/devops-incident-diagnostics/SKILL.md` | draft skill | AH-511 | draft |
| `skills-drafts/agenthub-evidence-loop-closure/SKILL.md` | draft skill | AH-511 | draft |
| `schemas/prompt-artifact.schema.json` | schema | AH-494 | draft |
| `schemas/report-receipt.schema.json` | schema | AH-494 | draft |
| `schemas/task-card.schema.json` | schema | AH-494 | draft |
| `schemas/secret-scan-receipt.schema.json` | schema | AH-500 | active |
| `schemas/agenthub-run-preflight.schema.json` | schema | AH-507/AH-510 | active |
| `schemas/t0-emergency-stop-receipt.schema.json` | schema | AH-510 | active |
| `schemas/agenthub-x-capability-matrix.schema.json` | schema | AH-590 | active |
| `schemas/agent-action-request.schema.json` | schema | AH-590 | active |
| `schemas/agenthub_action_authorization_receipt.schema.json` | schema | AH-590 | active |
| `schemas/agenthub_capability_matrix.schema.json` | schema | AH-590 | active |
| `schemas/agenthub_self_healing_event.schema.json` | schema | AH-590 | active |
| `schemas/control-spine-pr-queue-register.schema.json` | schema | AH-523 | active |
| `schemas/agent-output-quality-receipt.schema.json` | schema | AH-529 | active |
| `governance/agenthub-only-execution-discipline.md` | governance control | AH-534 | active |
| `governance/agenthub-safe-recovery-control.md` | governance control | AH-534 | active |
| `runbooks/agenthub-only-violation-response.md` | runbook | AH-534 | active |
| `runbooks/agenthub-live-execution-adapter-remediation.md` | runbook | AH-537 | active |
| `runbooks/agenthub-safe-recovery-control-loop.md` | runbook | AH-534 | active |
| `prompts/architecture/agenthub-safe-recovery-control-prompt.txt` | architecture prompt | AH-534 | consumed-prompt |
| `reports/receipts/AH-534-agenthub-only-execution-discipline-receipt.md` | AgentHub-only execution discipline receipt | AH-534 | pass |
| `reports/receipts/AH-536-AH-537-live-execution-route-repair-receipt.md` | live execution route repair receipt | AH-536/AH-537 | blocked-platform-gate |
| `reports/receipts/AH-534-agenthub-safe-recovery-control-receipt.md` | control-spine receipt | AH-534 | operational-receipt |
| `schemas/agenthub-only-execution-receipt.schema.json` | schema | AH-534 | active |
| `schemas/agenthub_authorized_scope.schema.json` | schema | AH-541 | active |
| `skills-drafts/agenthub-only-execution-boundary/SKILL.md` | draft skill | AH-534 | draft |
| `.agents/skills/agenthub-openai-cyber-safe-request-router/SKILL.md` | active skill | AH-541 | active |
| `evals/agenthub-cyber-safe-router/` | eval fixtures | AH-541 | active |
| `governance/agenthub-lane-router-and-blocker-scope-policy.md` | governance policy | AH-542 | active |
| `runbooks/agenthub-paralysis-breaker-runbook.md` | runbook | AH-542 | active |
| `schemas/agenthub-blocker-taxonomy.schema.json` | schema | AH-542 | active |
| `governance/task-graph-closure-policy.md` | governance policy | AH-542 | active |
| `governance/repo-first-artifact-lifecycle-policy.md` | governance policy | AH-542 | active |
| `governance/agenthub-access-rights-and-live-worker-enablement-policy.md` | governance policy | AH-554 | active |
| `governance/agenthub-docker-db-proxy-safety-policy.md` | governance policy | AH-554 | active |
| `governance/agenthub-task-cycle-full-closure-policy.md` | governance policy | AH-554 | active |
| `schemas/agenthub-access-capability-matrix.schema.json` | schema | AH-554 | active |
| `schemas/agenthub-live-worker-authorization.schema.json` | schema | AH-554 | active |
| `runbooks/agenthub-access-audit-and-live-devops-enablement.md` | runbook | AH-554 | active |
| `runbooks/agenthub-502-live-runtime-recovery-safe-runbook.md` | runbook | AH-554 | active |
| `.agents/skills/agenthub-task-first-router/SKILL.md` | active skill | AH-542 | active |
| `.agents/skills/agenthub-registrar-artifact-lifecycle/SKILL.md` | active skill | AH-542 | active |
| `.agents/skills/agenthub-git-pr-queue-control/SKILL.md` | active skill | AH-542 | active |
| `.agents/skills/agenthub-truth-redteam/SKILL.md` | active skill | AH-542 | active |
| `.agents/skills/caveman-user-communication/SKILL.md` | active skill | AH-542 | active |
| `.agents/skills/agenthub-permission-gate-router/SKILL.md` | active skill | AH-554 | active |
| `.agents/skills/agenthub-live-devops-safety/SKILL.md` | active skill | AH-554 | active |
| `evals/agenthub-paralysis-breaker/` | eval fixtures | AH-542 | active |
| `evals/agenthub-access-rights-and-live-worker-gates/` | eval fixtures | AH-554 | active |
| `evals/t0-direct-action-negative-tests/` | eval fixtures | AH-590 | active |
| `evals/agenthub-x-capability-matrix/` | eval fixtures | AH-590 | active |
| `evals/agenthub-x-capability-positive-tests/` | eval fixtures | AH-590 | active |
| `evals/model-token-routing/` | eval fixtures | AH-590 | active |
| `evals/repo-first-reporting/` | eval fixtures | AH-590 | active |
| `evals/agenthub-self-healing/fixtures/fixtures.json` | eval fixtures | AH-590 | active |
| `validators/agenthub_action_policy_validator.rb` | validator | AH-590 | active |
| `validators/t0_direct_action_hard_stop.rb` | validator | AH-590 | active |
| `validators/model_token_router_validator.rb` | validator | AH-590 | active |
| `validators/repo_first_receipt_gate.rb` | validator | AH-590 | active |
| `validators/agenthub_self_healing_validator.rb` | validator | AH-590 | active |
| `reports/receipts/RUN-agenthub-p0-paralysis-breaker-repo-first-control-repair-20260525-receipt.md` | control-spine receipt | AH-542 | operational-receipt |
| `reports/audits/AH-554-access-rights-and-live-worker-audit-20260525.md` | audit report | AH-554 | audit-only |
| `reports/receipts/AH-554-access-rights-and-live-devops-enablement-receipt.md` | control-spine receipt | AH-554 | operational-receipt |
| `reports/audits/P0-system-wide-permission-core-versioning-architecture-20260526.md` | architecture audit | AH-570 | audit-only |
| `governance/permission-profiles/agenthub-permission-profile-matrix.md` | governance policy | AH-570 | active |
| `governance/permission-profiles/agenthub-permission-validator.md` | governance validator | AH-570 | active |
| `governance/core-versioning/codex-core-version-control-policy.md` | governance policy | AH-570 | active |
| `schemas/permission-manifest.schema.json` | schema | AH-570 | active |
| `schemas/core-change-receipt.schema.json` | schema | AH-570 | active |
| `runbooks/rollback/agenthub-core-rollback-runbook.md` | rollback runbook | AH-570 | active |
| `evals/agenthub-system-permission-core-versioning/fixtures.json` | eval fixtures | AH-570 | active |
| `quarantine/README.md` | quarantine index | AH-570 | quarantine |
| `reports/receipts/P0-system-wide-permission-core-versioning-installed-20260526.md` | installation receipt | AH-570 | operational-receipt |
| `governance/policies/agenthub/pr52-policy-install-control.md` | policy install control | AH-570 | active |
| `reports/receipts/P0-pr52-policy-install-path-decision-20260526.md` | install path decision receipt | AH-570 | operational-receipt |
| `reports/receipts/P0-pr52-policy-install-validation-20260526.md` | validation receipt | AH-570 | operational-receipt |
| `governance/policies/agenthub/t0-live-root-hard-enforcement-addendum-20260526.md` | governance policy | AH-554 | active |
| `evals/agenthub-t0-live-root-hard-enforcement/fixtures.json` | eval fixtures | AH-554 | active |
| `reports/receipts/P0-t0-live-root-hard-enforcement-addendum-20260526.md` | operational receipt | AH-554 | operational-receipt |
| `reports/audits/AH-572-live-runtime-read-route-factcheck-20260526.md` | audit report | AH-572 | audit-only |
| `reports/receipts/AH-572-live-runtime-read-route-factcheck-receipt-20260526.md` | operational receipt | AH-572 | operational-receipt |
| `reports/audits/AH-572-live-runtime-readonly-inventory-20260526.md` | audit report | AH-572 | audit-only |
| `reports/receipts/AH-572-live-runtime-readonly-inventory-receipt-20260526.md` | operational receipt | AH-572 | operational-receipt |
| `reports/audits/AH-585-control-spine-repository-hygiene-20260526.md` | audit report | AH-585 | audit-only |
| `reports/receipts/AH-585-control-spine-repository-hygiene-receipt-20260526.md` | operational receipt | AH-585 | operational-receipt |
| `schemas/agenthub-owner-requirements-ledger.schema.json` | schema | AH-590 | active |
| `schemas/agenthub-run-checkpoint.schema.json` | schema | AH-590 | active |
| `schemas/agent-run-isolation.schema.json` | schema | AH-590 | active |
| `schemas/secrets-manifest.schema.json` | schema | AH-590 | active |
| `governance/agenthub-backend-only-output-policy.md` | governance policy | AH-590 | active |
| `governance/agenthub-role-permission-profiles.md` | governance policy | AH-590 | active |
| `governance/agenthub-model-routing-and-token-economy.md` | governance policy | AH-590 | active |
| `governance/agenthub-resume-from-run-policy.md` | governance policy | AH-590 | active |
| `governance/agenthub-technical-assignment-methodology-router.md` | governance policy | AH-590 | active |
| `runbooks/agenthub-backend-only-linear-cycle-runbook.md` | runbook | AH-590 | active |
| `runbooks/t0-direct-action-violation-response.md` | runbook | AH-590 | active |
| `runbooks/secret-handle-missing-owner-guide.md` | runbook | AH-590 | active |
| `evals/agenthub-control-policy-regression-suite.md` | eval fixtures | AH-590 | active |
| `evals/t0-hard-stop-negative-tests.md` | eval fixtures | AH-590 | active |
| `evals/global-agent-control/fixtures.json` | eval fixtures | AH-590 | active |
| `evals/secrets-registry/fixtures.json` | eval fixtures | AH-590 | active |
| `registries/secrets-manifest.redacted.md` | redacted registry | AH-590 | active |
| `reports/audits/P0-full-owner-requirements-intake-ledger-20260526.md` | requirements ledger | AH-590 | audit-only |
| `reports/audits/P0-global-agent-control-secrets-and-repo-audit-20260527.md` | audit report | AH-590 | audit-only |
| `reports/audits/P0-agenthub-x-capability-self-audit-20260528.md` | audit report | AH-590 | audit-only |
| `reports/audits/P0-agenthub-x-self-critique-correction-20260528.md` | self-critique report | AH-590 | audit-only |
| `reports/audits/P0-codex-spark-model-router-pr80-residual-audit-20260528.md` | audit report | AH-590 | audit-only |
| `reports/audits/P0-pr82-fallback-evidence-gate-fact-audit-20260528.md` | audit report | AH-590 | audit-only |
| `reports/audits/P0-agenthub-self-healing-core-architecture-audit-20260528.md` | audit report | AH-590 | audit-only |
| `reports/audits/P0-t0-escape-A-source-lifecycle-readback-20260530.md` | audit report | 3-640 | audit-only |
| `reports/audits/P0-t0-escape-B-t0-boundary-enforcement-20260530.md` | audit report | 3-640 | audit-only |
| `reports/audits/P0-t0-escape-C-mid-context-role-drift-20260530.md` | audit report | 3-640 | audit-only |
| `reports/audits/P0-t0-escape-D-code-authoring-route-20260530.md` | audit report | 3-640 | audit-only |
| `reports/audits/P0-t0-escape-E-live-adapter-boundary-20260530.md` | audit report | 3-640 | audit-only |
| `reports/audits/P0-t0-escape-F-task-service-done-gate-20260530.md` | audit report | 3-640 | audit-only |
| `reports/audits/P0-t0-escape-G-pr-artifact-lifecycle-20260530.md` | audit report | 3-640 | audit-only |
| `reports/audits/P0-t0-escape-H-prompt-quality-redteam-20260530.md` | audit report | 3-640 | audit-only |
| `reports/audits/P0-t0-escape-I-no-temporary-patch-gate-20260530.md` | audit report | 3-640 | audit-only |
| `reports/audits/P0-t0-escape-J-final-boundary-decision-20260530.md` | audit report | 3-640 | audit-only |
| `prompts/implementation/P0-agenthub-t0-escape-boundary-blocker-implementation-prompt-20260530.txt` | implementation prompt | 3-640 | active-control |
| `reports/receipts/P0-t0-escape-orchestration-boundary-audit-receipt-20260530.md` | operational receipt | 3-640 | operational-receipt |
| `governance/policies/t0-escape-boundary-gates-policy.md` | governance policy | AH-618 | active |
| `schemas/t0_escape_boundary_action.schema.json` | schema | AH-618 | active |
| `validators/t0_escape_boundary_gates_validator.rb` | validator | AH-618 | active |
| `evals/t0-escape-boundary-gates/fixtures.json` | eval fixtures | AH-618 | active |
| `reports/receipts/P0-t0-escape-boundary-gates-implementation-receipt-20260530.md` | implementation receipt | AH-618 | operational-receipt |
| `governance/model-portfolio-utilization-policy.md` | governance policy | AH-615 | active |
| `validators/model_portfolio_router_validator.rb` | validator | AH-615 | active |
| `evals/model-portfolio-routing/fixtures.json` | eval fixtures | AH-615 | active |
| `reports/receipts/P0-model-portfolio-spark-canary-20260530.md` | model route canary receipt | AH-615 | operational-receipt |
| `reports/receipts/P0-model-portfolio-fallback-canary-20260530.md` | model route canary receipt | AH-615 | operational-receipt |
| `reports/receipts/P0-model-portfolio-continuous-loop-implementation-receipt-20260530.md` | implementation receipt | AH-615 | operational-receipt |
| `reports/incidents/P0-t0-boundary-violation-multi-agent-runaway-20260527.md` | incident report | AH-590 | audit-only |
| `reports/receipts/P0-agenthub-backend-only-repo-first-architecture-receipt-20260526.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-t0-hard-stop-multi-agent-isolation-receipt-20260527.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-task-debt-consolidation-receipt-20260527.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-global-agent-control-secrets-and-repo-receipt-20260527.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-agenthub-x-capability-self-audit-hard-enforcement-receipt-20260528.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-codex-spark-model-router-pr80-residual-receipt-20260528.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-pr82-fallback-evidence-gate-fix-receipt-20260528.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-agenthub-self-healing-core-install-receipt-20260528.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-agenthub-self-healing-negative-tests-20260528.md` | operational receipt | AH-590 | operational-receipt |
| `governance/agenthub-methodology-router.md` | governance policy | AH-594 | active |
| `governance/agenthub-blackbox-route-registry.md` | governance control | AH-594 | active |
| `schemas/agenthub_methodology_router.schema.json` | schema | AH-594 | active |
| `schemas/agenthub_blackbox_route_registry.schema.json` | schema | AH-594 | active |
| `validators/agenthub_methodology_router_validator.rb` | validator | AH-594 | active |
| `validators/agenthub_blackbox_route_validator.rb` | validator | AH-594 | active |
| `evals/agenthub-methodology-router/fixtures.json` | eval fixtures | AH-594 | active |
| `evals/agenthub-blackbox-routes/fixtures.json` | eval fixtures | AH-594 | active |
| `reports/audits/P0-methodology-enforcement-certification-20260528.md` | audit report | AH-594 | audit-only |
| `reports/receipts/P0-methodology-enforcement-certification-receipt-20260528.md` | operational receipt | AH-594 | operational-receipt |
| `reports/audits/P0-methodology-enforcement-final-readback-20260528.md` | readback audit | AH-594 | audit-only |
| `governance/project-sources/chatgpt-project-five-source-mirror.md` | active source mirror | AH-595 | active |
| `governance/methodologies/ai-agent-methodology-catalog.md` | methodology catalog | AH-595 | active |
| `governance/methodologies/methodology-router-policy.md` | governance policy | AH-595 | active |
| `governance/methodologies/methodology-router-adr.md` | architecture decision record | AH-595 | active |
| `schemas/methodology-router.schema.json` | schema | AH-595 | active |
| `schemas/project-source-mirror.schema.json` | schema | AH-595 | active |
| `validators/methodology-router/validate-methodology-router.rb` | validator | AH-595 | active |
| `evals/methodology-router/fixtures.json` | eval fixtures | AH-595 | active |
| `prompts/templates/methodology-router-worker-template.md` | worker prompt template | AH-595 | active |
| `reports/audits/P0-project-methodology-mirror-gap-audit-20260528.md` | audit report | AH-595 | audit-only |
| `reports/receipts/P0-project-methodology-mirror-implementation-receipt-20260528.md` | operational receipt | AH-595 | operational-receipt |
| `reports/validations/P0-project-methodology-mirror-enforcement-validation-20260528.md` | validation report | AH-595 | audit-only |
| `reports/incidents/P0-komodo-kutt-agenthub-final-closure-report-20260528.md` | incident report | AH-574 | audit-only |
| `reports/receipts/P0-komodo-kutt-agenthub-final-closure-receipt-20260528.md` | operational receipt | AH-574 | operational-receipt |
| `reports/audits/P0-agenthub-prompt-implementation-ledger-readback-20260528.md` | prompt implementation readback | AH-574 | audit-only |
| `reports/audits/P0-codex-spark-mandatory-execution-factcheck-20260529.md` | audit report | AH-601 | audit-only |
| `reports/receipts/P0-codex-spark-mandatory-execution-guardrail-receipt-20260529.md` | operational receipt | AH-601 | operational-receipt |
| `reports/audits/P0-codex-spark-real-execution-proof-audit-20260529.md` | audit report | AH-601 | audit-only |
| `reports/receipts/P0-codex-spark-real-execution-proof-receipt-20260529.md` | operational receipt | AH-601 | operational-receipt |
| `reports/audits/P0-codex-spark-usage-metric-contradiction-audit-20260529.md` | audit report | AH-601 | audit-only |
| `reports/receipts/P0-codex-spark-usage-metric-contradiction-receipt-20260529.md` | operational receipt | AH-601 | operational-receipt |
| `reports/audits/P0-codex-spark-hard-route-execution-audit-20260529.md` | audit report | AH-601 | audit-only |
| `reports/receipts/P0-codex-spark-hard-route-execution-receipt-20260529.md` | operational receipt | AH-601 | operational-receipt |
| `reports/audits/P0-codex-spark-route-technology-repair-audit-20260529.md` | audit report | AH-601 | audit-only |
| `reports/receipts/P0-codex-spark-route-technology-repair-receipt-20260529.md` | operational receipt | AH-601 | operational-receipt |
| `reports/audits/P0-codex-spark-json-usage-execution-audit-20260529.md` | audit report | AH-601 | audit-only |
| `reports/receipts/P0-codex-spark-json-usage-execution-receipt-20260529.md` | operational receipt | AH-601 | operational-receipt |
| `reports/audits/P0-codex-spark-circuit-breaker-full-closure-audit-20260529.md` | audit report | AH-601 | audit-only |
| `reports/receipts/P0-codex-spark-circuit-breaker-full-closure-receipt-20260529.md` | operational receipt | AH-601 | operational-receipt |
| `governance/model-portfolio-utilization-policy.md` | governance policy | AH-590 | active |
| `schemas/model_route_invocation_receipt.schema.json` | schema | AH-590 | active |
| `validators/model_portfolio_router_validator.rb` | validator | AH-590 | active |
| `evals/model-portfolio-routing/fixtures.json` | eval fixtures | AH-590 | active |
| `reports/audits/P0-global-model-portfolio-route-evaluation-20260529.md` | audit report | AH-590 | audit-only |
| `reports/validations/P0-global-model-portfolio-route-validation-20260529.md` | validation report | AH-590 | audit-only |
| `reports/receipts/P0-global-model-portfolio-inventory-receipt-20260529.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-global-model-portfolio-route-closure-receipt-20260529.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-agenthub-closed-contour-task-sprawl-closure-receipt-20260529.md` | operational receipt | AH-590 | operational-receipt |
| `reports/receipts/P0-model-route-terminal-finalizer-receipt-20260529.md` | operational receipt | AH-590 | operational-receipt |
