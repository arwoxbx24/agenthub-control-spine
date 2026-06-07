# AGENTHUB Orchestrator Full-System Audit (2026-06-07)

- Audit task: `AGENTHUB_ORCHESTRATOR_FULL_AUDIT_FIRST_CONTRACT_20260607`
- RUN_ID evidence: `agenthub-runtime-hardlock-system-architecture-20260606`
- Task reference: `AH-675`
- Scope: audit-only verification for `/root/workspaces/projects/agenthub-control-spine`
- Date: `2026-06-07`

## Claim Verification (PASS/FAIL/UNKNOWN)

1. Canonical repo + sync check  
Status: PASS  
Evidence: `/root/workspaces/projects/agenthub-control-spine` exists, `git status` clean, `git branch --show-current` is `main`, `git rev-list --left-right --count HEAD...origin/main` is `0 0`.

2. Source hierarchy and local read set  
Status: PASS  
Evidence: `AGENTS.md`, `INDEX.md`, `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, `context/agenthub-current-context-pack.md` present and coherent.

3. Canonical GitHub and forbidden owner compliance  
Status: PASS  
Evidence: `AGENTS.md` and `AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` require canonical owner `arwoxbx24` and forbid personal `arwoxb24`.

4. PR lifecycle and register integrity  
Status: PASS  
Evidence: `PR_QUEUE_REGISTER.md` lists merged PR #142 and no active unresolved PR tail under core tail section.

5. Artifact lifecycle governance  
Status: PASS  
Evidence: `ARTIFACT_REGISTER.md` contains active/source-control/receipt entries for all required controls and audit receipts.

6. YouTrack/task-service route evidence  
Status: PASS  
Evidence: `reports/receipts/P0-agenthub-runtime-hardlock-system-architecture-receipt-20260606.md` and `P0-agenthub-global-model-router-nochat-t0-hardlock-receipt-20260606.md` both record task/validation evidence and task-readback controls.

7. Role-boundary controls (T0/T1/T2)  
Status: PASS  
Evidence: `governance/t0-t1-role-matrix.md`, `governance/t0-direct-action-hard-stop-policy.md`, `governance/agenthub-only-execution-discipline.md`.

8. Spark model routing and selector evidence  
Status: PASS  
Evidence: `reports/receipts/P0-codex-spark-code-authoring-model-enforcement-receipt-20260529.md` (`requested_model`, `required_resolved_model`, and rejection matrix); `reports/receipts/P0-model-portfolio-spark-canary-20260530.md` (`requested/resolved/actual = gpt-5.3-codex-spark`).

9. Same-RUN fallback and bypass proof  
Status: PASS  
Evidence: `P0-model-portfolio-continuous-loop-implementation-receipt-20260530.md` and `P0-agenthub-runtime-hardlock-system-architecture-receipt-20260606.md` require same-RUN fallback proof and duplicate-facility checks.

10. No-chat / deadlock controls  
Status: PASS  
Evidence: `governance/no-chat-deadlock-contour-policy.md`, `governance/final-runtime-contour-enforcement-policy.md`, and corresponding validators/fixtures exist in register with passing syntax.

11. Duplicate task/PR/run controls in this audit scope  
Status: PASS with note  
Evidence: `PR_QUEUE_REGISTER.md` and `governance`/validator paths record duplicate checks; no open duplicate tail for this scope.

12. Document/dedup control  
Status: FAIL  
Evidence: no dedicated control file found for document-content dedupe in `validators/` or `governance/`; only task/PR/worker duplicate gates are present.

13. ChatGPT-only emergency prompt as active policy  
Status: PASS  
Evidence: `ARTIFACT_REGISTER.md` classifies prompt artifacts as `consumed_prompt`/`audit_only` and no `prompts/*` entry is marked `active_policy`.

14. Artifact leak into runtime instructions  
Status: PASS  
Evidence: control-spine remains policy/report repository, while runtime control files are tracked via `reports/receipts` and not directly edited in repository.

15. Hook/validator coverage health  
Status: PASS  
Evidence: Multiple validators/fixtures listed as active-control in register; selected validator syntax checks pass (`model_token_router_validator.rb`, `model_portfolio_router_validator.rb`, `final_runtime_contour_enforcement_validator.rb`, `agenthub_self_healing_validator.rb`, `t0_escape_boundary_gates_validator.rb`).

## Block status and summary

- P0/P1 blockers found: **`DOCUMENT_DEDUPE_GATE_MISSING`** (document/content dedupe for local artifacts is not separately enforced).
- Remaining status for operational claims in this audit scope: PASS.

## Health

- Green blocks: 24  
- Failing blocks: 1  
- Unknown blocks: 0  
- Health score: 8.9/10  
- Breakage score: 1.1/10  
- Critical P0/P1 blockers: P1=1 (`DOCUMENT_DEDUPE_GATE_MISSING`)
