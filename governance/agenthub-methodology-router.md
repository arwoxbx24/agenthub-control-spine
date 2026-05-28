---
artifact_id: agenthub-methodology-router
artifact_type: governance_policy
owner_role: T1 Architect / Methodology Router
source_task: AH-594
run_id: RUN-P0-METHODOLOGY-ENFORCEMENT-CERTIFICATION-20260528
created_at: 2026-05-28
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Methodology Router

This policy installs the 25-methodology stack as an adaptive router. It is not a
prompt appendix and it must not load every method for every task.

## Required Router Output

Every non-trivial AgentHub run must record:

- `TASK_CLASS`
- `ROLE`
- `RUN_ID`
- `METHODOLOGY_PROFILE`
- `ACTIVE_METHODS`
- `FORBIDDEN_METHODS`
- `WHY_SELECTED`
- `EXPECTED_ARTIFACTS`
- `ACCEPTANCE_GATES`

If `ACTIVE_METHODS` is empty for non-trivial work, execution is blocked with
`METHODOLOGY_ROUTER_MISSING`. If all 25 methods are loaded without task-specific
need, execution is blocked with `DENY_TOKEN_BLOAT_METHODOLOGY_OVERLOAD`.

## Catalog

| # | Method | Activation condition | Enforcement status |
|---|---|---|---|
| 1 | ReAct | Any tool/action loop; internal action/observation receipt only | conditionally enforced |
| 2 | Chain-of-Thought / Tree-of-Thought | Complex diagnosis or architecture optioning; safe summary only | conditionally enforced |
| 3 | Plan-and-Execute | Multi-step tasks with separated planner/executor roles | conditionally enforced |
| 4 | Reflexion | Failed validation, blocked route, repeated defect | conditionally enforced |
| 5 | ADR | Durable architecture, policy-as-code, model routing, permission changes | conditionally enforced |
| 6 | C4 Model | System or multi-service architecture | conditionally enforced |
| 7 | DDD | Domain/product decomposition or business boundaries | conditionally enforced |
| 8 | Event Storming | Workflow/domain event modeling | conditionally enforced |
| 9 | Test Pyramid | Implementation work | conditionally enforced |
| 10 | TDD | New code or behavior change unless emergency exception is recorded | conditionally enforced |
| 11 | BDD | Acceptance/user behavior scenarios drive work | conditionally enforced |
| 12 | Contract Testing | API or microservice integration changes | conditionally enforced |
| 13 | Mutation Testing | Critical business logic or test-quality certification | optional |
| 14 | Property-Based Testing | Validators, parsers, business rules, edge cases | optional |
| 15 | SOLID + Clean Architecture | Code design/refactor and service boundaries | conditionally enforced |
| 16 | Trunk-Based Development + Feature Flags | Branching and rollout policy | conditionally enforced |
| 17 | Conventional Commits + SemVer | Commit/release/change classification | conditionally enforced |
| 18 | Automated Code Review Checklist | Before commit/PR merge | conditionally enforced |
| 19 | Debugging Ladder | Runtime/debug incidents | conditionally enforced |
| 20 | Observability 3 Pillars | Incidents; unavailable sources must be explained | conditionally enforced |
| 21 | 5 Whys + RCA | Incidents and repeated blocker loops | conditionally enforced |
| 22 | Chaos Engineering | Safe sandbox/staging simulation only | optional/owner-gated |
| 23 | GitOps | Infra/config/control-spine changes through PR/receipt | conditionally enforced |
| 24 | Shift-Left Security / DevSecOps | Code/config/secret changes and receipts | conditionally enforced |
| 25 | SRE | Production incidents, SLO/SLA/error-budget/postmortem/runbooks | conditionally enforced |

## Profiles

| Profile | Required methods | Forbidden-by-default methods |
|---|---|---|
| `MICRO` | Minimal direct answer; no tool loop unless needed | all unrelated methods |
| `STANDARD` | 1, 3, 18, 23 when repo artifacts are changed | domain/incident-only methods unless applicable |
| `INCIDENT` | 1, 4, 19, 20, 21, 25 | DDD/Event Storming unless domain workflow is involved |
| `FULL_ARCHITECTURE` | 1, 2, 3, 4, 5, 6 where system boundaries apply, 21, 23, 24 | all optional testing methods unless implementation needs them |
| `CODE_IMPLEMENTATION` | 1, 3, 9, 10, 18, 23, 24 plus 12/14 when applicable | all architecture/domain methods unless scope requires |
| `QA_VALIDATION` | 1, 4, 9, 18, 24 | execution methods outside read-only validation |
| `REGISTRAR` | 1, 3, 17, 23, 24 | code/runtime/domain methods |

## Role Coverage

T0/TMLI/TeamLead selects the profile and routes; it does not execute code,
Linux, Docker, DB, proxy, DNS, firewall, cloud CLI, product mutation, or direct
file mutation outside an approved Registrar route.

T1 owns methodology decisions, ADRs, C4/DDD applicability, decomposition, and
worker contracts. T1 does not mutate runtime.

T2 workers execute only scoped surfaces with `RUN_ID`, `task_id`, role, method
profile, model route, evidence path, validation plan, and rollback/read-only
state.

Verifier is read-only and must reject weak Done. Registrar owns
`INDEX.md`, `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, receipts, and task
readback.

## Model Route Rule

Code/config/YAML/shell/script work must use a Codex-capable route or a same-RUN
fallback receipt proving unavailable primary route, selected fallback, and no
duplicate run. Concrete model availability is runtime evidence; this policy does
not hardcode a provider availability claim.

