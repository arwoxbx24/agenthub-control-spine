---
artifact_id: P0-full-owner-requirements-intake-ledger-20260526
artifact_type: requirements_ledger
owner_role: T0 Control Plane / T1 Architect
source_task: AH-590
run_id: RUN-P0-FULL-REQ-BACKEND-ONLY-ARCH-20260526
created_at: 2026-05-26
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 Full Owner Requirements Intake Ledger

## Scope

This ledger normalizes the owner's repeated incident evidence into enforceable
requirements, controls, and acceptance gates. Repeated urgent wording is treated
as a signal of severity and recurrence risk, not as noise.

## Requirements

| ID | Status | Requirement | Control surface | Acceptance |
|---|---|---|---|---|
| R01_BACKEND_ONLY_USER_OUTPUT | accepted | Owner chat must not become a work log. | backend-only output policy; post-output gate | Final owner message only or exact owner-only gate. |
| R02_CONTROL_SPINE_REPORTING_ALWAYS | accepted | Every success/failure must be mirrored to control-spine. | reports, receipts, registers | INDEX/ARTIFACT_REGISTER/PR_QUEUE coverage exists. |
| R03_T0_NO_CODE_NO_LINUX_NO_RUNTIME | accepted | T0 is not an implementation author. | role profiles; pre-tool gate | T0 mutation requests denied. |
| R04_AGENTHUB_ONLY_EXECUTION_CHAIN | accepted | Implementation goes through lifecycle RUN -> worker -> evidence. | AgentHub route | Route receipt exists before Done. |
| R05_NO_BLIND_BRUTE_FORCE | accepted | No random command loops. | retry/gate policy | Same gate fails twice -> repair/blocker. |
| R06_RESUME_FROM_CHECKPOINT | accepted | Resume from last verified checkpoint. | checkpoint schema; runbook | Safe resume state recorded. |
| R07_MULTI_AGENT_SESSION_ISOLATION | accepted | Independent agents/sessions stay isolated. | scope signature; run id | No mixed output as Done evidence. |
| R08_TASK_EXPLOSION_CONTROL | accepted | One parent and bounded children; no zombie loops. | task-first router | Duplicate check before create. |
| R09_MODEL_AND_TOKEN_ECONOMY | accepted | Cheap/deterministic route for routine work. | model routing policy | Registrar-only expensive route fails eval. |
| R10_CODEX_USAGE_FOR_CODE | accepted | Code/config tasks use Codex/code worker. | model routing; role profile | T0 cannot author code. |
| R11_TECHNICAL_ASSIGNMENT_BEFORE_IMPLEMENTATION | accepted | Serious work needs TZ/micro-TZ. | methodology router | Worker has scope, risk, tests, rollback. |
| R12_METHODOLOGY_ROUTING | corrected | Use necessary methods, not all methods always. | methodology router | Task class maps to method set. |
| R13_REPOSITORY_HYGIENE | accepted | Keep control-spine clean. | registrar lifecycle | queue/registers updated; stale states tracked. |
| R14_NO_FAKE_DONE | accepted | Done requires real evidence. | Done gate/evals | GitHub-only/sandbox-only proof is rejected. |
| R15_SAFE_PERMISSION_EXPANSION | accepted | Safe routes should not be blocked endlessly. | permission profiles | Missing safe profile becomes remediation. |
| R16_PLATFORM_GATE_AUTOREMEDIATION | accepted | Routine gates are same-run remediation. | registrar runbook | No owner ask for routine buttons. |
| R17_OWNER_ONLY_GATE_LIMIT | accepted | Owner interrupted only for true external authority. | blocker taxonomy | Exact owner action required. |
| R18_NO_USER_CHAT_AS_WORK_LOG | accepted | Chat is not evidence. | backend-only policy | Evidence lives in repo/run/task. |
| R19_PRODUCT_SCOPE_ISOLATION | accepted | AgentHub core and domain services stay separate. | scope signature | No mixed Done claim. |
| R20_EVERY_CLAIM_HAS_EVIDENCE | accepted | Important claims need evidence reference. | truth-redteam | Unsupported claims marked hypothesis. |

## Architecture Verdict

Chosen option: balanced policy-as-code, skill router, hooks, validators, scoped
workers, model routing, backend-only output, resume checkpoints, and
control-spine receipts.

Rejected:

- prompt-only warning, because it does not enforce behavior;
- unlimited root/full-auto execution, because it is unsafe and noisy.

## Residual

Runtime hook deployment remains governed by existing AgentHub hook paths and
policy installers. This package installs the control-spine source of truth and
regression expectations; runtime mutation is not performed by this governance
artifact.

