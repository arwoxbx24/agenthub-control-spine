---
artifact_id: p0-methodology-enforcement-certification-20260528
artifact_type: audit_report
owner_role: T1 Architect / Verifier
source_task: AH-594
run_id: RUN-P0-METHODOLOGY-ENFORCEMENT-CERTIFICATION-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 Methodology Enforcement Certification

## 1. Executive Summary

Main had broad governance for role boundaries, self-healing, model routing,
repo-first reporting, and T0 direct-action denial. The methodology router itself
was only partially enforceable: `governance/agenthub-technical-assignment-methodology-router.md`
described selective methodology routing, but there was no dedicated 25-method
schema, validator, or eval suite. Black-box execution routes were also not
registered as a single enforceable registry with unregistered-route denial.

This RUN installs those missing control-spine surfaces:

- `governance/agenthub-methodology-router.md`
- `governance/agenthub-blackbox-route-registry.md`
- `schemas/agenthub_methodology_router.schema.json`
- `schemas/agenthub_blackbox_route_registry.schema.json`
- `validators/agenthub_methodology_router_validator.rb`
- `validators/agenthub_blackbox_route_validator.rb`
- `evals/agenthub-methodology-router/fixtures.json`
- `evals/agenthub-blackbox-routes/fixtures.json`

## 2. Evidence Sources

Read baseline:

- `AGENTS.md`
- `INDEX.md`
- `ARTIFACT_REGISTER.md`
- `PR_QUEUE_REGISTER.md`
- `governance/**`
- `schemas/**`
- `validators/**`
- `evals/**`
- `runbooks/**`
- PR #86/#87 artifacts and receipts
- YouTrack parent `AH-590`; child `AH-594`

No Docker, NPM, DB, proxy, firewall, DNS, SSL, product runtime, or secret values
were inspected or mutated.

## 3. PR #86/#87 Factcheck

| Claim | Evidence | Verdict |
|---|---|---|
| PR #86 installed self-healing core controls | `PR_QUEUE_REGISTER.md`, `reports/receipts/P0-agenthub-self-healing-core-install-receipt-20260528.md` | confirmed for repository-governance scope |
| PR #87 registered merge readback | `PR_QUEUE_REGISTER.md`, same install receipt final status | confirmed |
| 25-methodology stack had dedicated validator/evals | Absent before this RUN | gap repaired |
| Black-box route registry had dedicated validator/evals | Absent before this RUN | gap repaired |
| Live runtime hooks are fully installed | Not proven by repo files alone | not claimed |

## 4. 25-Methodology Certification Matrix

| # | Method | Activation | Enforcing artifact | Negative/positive fixture | Status |
|---|---|---|---|---|---|
| 1 | ReAct | tool/action loop | methodology router validator | P1-P5/P8 | CONDITIONALLY_ENFORCED |
| 2 | Chain/Tree of Thought | architecture optioning safe summary | methodology router validator | P2 | CONDITIONALLY_ENFORCED |
| 3 | Plan-and-Execute | multi-step task | methodology router validator | P4/P5 | CONDITIONALLY_ENFORCED |
| 4 | Reflexion | failed validation/repeated defect | methodology router validator | N18/P3/P8 | CONDITIONALLY_ENFORCED |
| 5 | ADR | durable architecture | methodology router validator | N11/P2 | CONDITIONALLY_ENFORCED |
| 6 | C4 | system boundary | methodology router validator | P2 | CONDITIONALLY_ENFORCED |
| 7 | DDD | domain boundary | methodology router validator | architecture conditional | CONDITIONALLY_ENFORCED |
| 8 | Event Storming | workflow modeling | router policy | not applicable to this repo-governance task | NOT_APPLICABLE |
| 9 | Test Pyramid | implementation work | methodology router validator | N12/P4/P8 | CONDITIONALLY_ENFORCED |
| 10 | TDD | behavior/code change | methodology router validator | N12/P4 | CONDITIONALLY_ENFORCED |
| 11 | BDD | user behavior scenarios | router policy | not applicable to this repo-governance task | NOT_APPLICABLE |
| 12 | Contract Testing | API/microservice integration | router policy | not applicable to this repo-governance task | NOT_APPLICABLE |
| 13 | Mutation Testing | critical test-quality certification | router policy | optional | NOT_APPLICABLE |
| 14 | Property-Based Testing | validators/parsers/edge rules | router policy | optional for future validator hardening | CONDITIONALLY_ENFORCED |
| 15 | SOLID/Clean Architecture | code design/refactor | router policy | not a product-code task | NOT_APPLICABLE |
| 16 | Trunk-Based/Feature Flags | rollout policy | router policy | GitOps PR route applies | CONDITIONALLY_ENFORCED |
| 17 | Conventional Commits/SemVer | change classification | methodology router validator | P5 | CONDITIONALLY_ENFORCED |
| 18 | Automated Review Checklist | before PR merge | methodology router validator | N12/P4/P8 | CONDITIONALLY_ENFORCED |
| 19 | Debugging Ladder | runtime/debug incident | methodology router validator | N10/P3 | CONDITIONALLY_ENFORCED |
| 20 | Observability 3 Pillars | incident evidence | methodology router validator | N10/P3 | CONDITIONALLY_ENFORCED |
| 21 | 5 Whys/RCA | incident/repeated blocker | methodology router validator | N10/N18/P3 | CONDITIONALLY_ENFORCED |
| 22 | Chaos Engineering | sandbox/staging only | router policy | owner-gated, not used | NOT_APPLICABLE |
| 23 | GitOps | repo/config/control-spine changes | methodology router validator | N13/P5 | CONDITIONALLY_ENFORCED |
| 24 | DevSecOps | code/config/receipt security | methodology router validator and gitleaks | P4/P5/P8 | CONDITIONALLY_ENFORCED |
| 25 | SRE | production incidents | methodology router validator | N10/P3 | CONDITIONALLY_ENFORCED |

## 5. Role Enforcement Matrix

| Role | Certification |
|---|---|
| T0/TMLI/TeamLead | Black-box route validator denies direct runtime/CLI/code routes; methodology router allows classification/delegation only. |
| T1_ARCHITECT | Black-box route validator denies runtime mutation; methodology router requires ADR/options for architecture. |
| T2_CODEX_WORKER | Requires RUN_ID, task_id, surfaces, Codex route attempt for code-like work, repo receipt target. |
| T2_DEVOPS_WORKER | Runtime routes remain blocked/owner-gated unless scoped and evidenced. |
| VERIFIER | QA profile permits read-only evidence review and rejects weak Done through methodology fixtures. |
| REGISTRAR | Registrar profile requires GitOps/artifact lifecycle and register readback. |

## 6. Model Router Certification

Existing validators certify Codex-capable route behavior:

- `validators/model_token_router_validator.rb`
- `validators/agenthub_action_policy_validator.rb`
- `reports/audits/P0-pr82-fallback-evidence-gate-fact-audit-20260528.md`
- `reports/receipts/P0-pr82-fallback-evidence-gate-fix-receipt-20260528.md`

This RUN adds black-box route checks for code-like work without Codex route
attempt and fallback without same-RUN primary-unavailable evidence. Concrete
model availability is not claimed from static repo artifacts; availability must
be runtime/registry evidence in the same RUN.

## 7. Black-Box Route Registry Findings

The new registry covers direct shell, language runtimes, Docker/Compose,
Kubernetes/system services, git/gh write, cloud CLIs, curl/API, SSH terminals,
MCP tools, AgentHub adapters, browser/headless tools, DB clients, and
proxy/NPM/DNS/SSL routes.

Unregistered execution surfaces are denied with `DENY_UNREGISTERED_ROUTE`.
T0 direct runtime/CLI/code attempts are denied with `DENY_T0_DIRECT_ACTION`.
Target surface allow/deny is explicitly enforced.

## 8. Negative Test Results

Installed negative coverage:

- N1-N9, N18, N22 in `evals/agenthub-blackbox-routes/fixtures.json`
- N10-N21 in `evals/agenthub-methodology-router/fixtures.json`

Local validation before PR:

- `agenthub_blackbox_route_validator.rb`: PASS, 17 cases
- `agenthub_methodology_router_validator.rb`: PASS, 18 cases

## 9. Positive Test Results

Installed positive coverage:

- P1-P5 and P8 in methodology fixtures
- P6, P7, P9, P10 in black-box route fixtures

## 10. Gaps Repaired In This RUN

| Gap | Repair |
|---|---|
| Methodology router existed mostly as prose | Added policy, schema, validator, fixtures |
| No all-method token-bloat denial | Added `DENY_TOKEN_BLOAT_METHODOLOGY_OVERLOAD` fixture and validator |
| No unified black-box route registry | Added registry policy, schema, validator, fixtures |
| No explicit target_surface allow/deny black-box gate | Added `DENY_SURFACE_NOT_ALLOWED` and `DENY_SURFACE_FORBIDDEN` |
| No unregistered route denial fixture | Added `DENY_UNREGISTERED_ROUTE` |

## 11. Residual Defects

No repository-governance residual remains for the installed validator/eval scope.
Live runtime hook enforcement cannot be proven by repository files alone and is
therefore not claimed here. If a live hook is missing at runtime, the new
policies classify it as a same-RUN route/control defect rather than permission
for T0 direct shell workaround.

## 12. YouTrack Readback

Child task: `AH-594`, parent: `AH-590`. Final task readback is recorded after PR
merge.

## 13. Control-Spine Coverage

This RUN updates `INDEX.md`, `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, and
adds audit/receipt/readback artifacts.

## 14. Final Decision

Decision after PR #88 merge: `DONE_WITH_EVIDENCE` for repository-governance
methodology router and black-box route registry scope after registrar readback,
post-readback validation, and task readback. Live runtime hook installation is
not claimed from repository files.
