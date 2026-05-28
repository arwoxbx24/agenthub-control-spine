---
artifact_id: ai-agent-methodology-catalog
artifact_type: active_methodology_catalog
owner_role: T1 Architect / Methodology Router
source_task: AH-595
run_id: RUN-P0-PROJECT-METHODOLOGY-MIRROR-20260528
created_at: 2026-05-28
lifecycle_status: active_source
default_load: false
safe_to_replay: false
source_link: https://b244.ru/fx
source_read_sha256: f93f5d383cc8a5865bfceccda436f3104e18061b2b5eca014cff4906cfe35eb9
---

# AI Agent Methodology Catalog

This catalog mirrors the owner-provided HTML methodology source into
control-spine. It is selected through the adaptive router and must not be pasted
into every worker prompt.

| # | Method | Purpose | Activation trigger | Forbidden misuse | Expected evidence |
|---|---|---|---|---|---|
| 1 | ReAct | Reason/action/observation loop for traceable agent work | Any tool/action loop | Exposing hidden reasoning to owner chat | action/observation receipt |
| 2 | Chain-of-Thought / Tree-of-Thought | Structured diagnosis and optioning | Complex diagnosis or architecture choice | Publishing hidden reasoning verbatim | safe summary/options |
| 3 | Plan-and-Execute | Separate planning from execution | Multi-step work | T0 executing worker actions | plan plus worker evidence |
| 4 | Reflexion | Correct after failed gate or repeated defect | Failed validation/blocker loop | Blind retry loop | corrective action receipt |
| 5 | ADR | Durable architecture decision record | Policy, model routing, system rule changes | Cosmetic ADR after implementation only | ADR with options/consequences |
| 6 | C4 Model | System boundary overview | Multi-service/system architecture | Drawing code-level detail for simple task | context/container summary |
| 7 | Domain-Driven Design | Business/domain boundary decomposition | Product/domain logic boundaries | Forcing DDD on pure repo-governance task | bounded-context notes |
| 8 | Event Storming | Workflow event mapping | Domain event/process modeling | Using for small bugfix | event/command/aggregate map |
| 9 | Test Pyramid | Select correct test layer | Implementation work | E2E-only proof for unit behavior | test-layer plan/results |
| 10 | TDD | Red/green/refactor behavior change | New code or behavior change | Skipping tests without exception | failing/passing test evidence |
| 11 | BDD | Given/When/Then acceptance scenarios | User behavior drives acceptance | Replacing actual tests with prose | scenario acceptance proof |
| 12 | Contract Testing | API/microservice contract safety | API/provider-consumer change | Claiming API safety from unit tests only | contract result |
| 13 | Mutation Testing | Test quality certification | Critical business logic | Running as default on every task | mutation score or waiver |
| 14 | Property-Based Testing | Edge-case validation | Validators, parsers, business rules | Using random tests without invariants | properties and failing seeds |
| 15 | SOLID + Clean Architecture | Code design and boundary review | Refactor/service boundary work | Architecture theater for docs-only task | review checklist |
| 16 | Trunk-Based Development + Feature Flags | Safe branch/rollout strategy | Branching or rollout policy | Long-lived unreviewed branches | branch/flag plan |
| 17 | Conventional Commits + SemVer | Change classification | Commit/release/change log work | Mislabeling risk/impact | commit/release classification |
| 18 | Automated Code Review Checklist | Pre-merge quality gate | Before commit/PR merge | Treating PR merge as review proof | review checklist receipt |
| 19 | Debugging Ladder | Code -> config -> container -> orchestration -> network -> host triage | Runtime/debug incident | Skipping levels into blind shell | triage ladder evidence |
| 20 | Observability: Logs + Metrics + Traces | Correlate incident signals | Incidents and runtime diagnosis | Claiming observability when sources absent | source availability matrix |
| 21 | 5 Whys + RCA | Root-cause analysis | Incidents/repeated blockers | Stopping at symptom | RCA summary |
| 22 | Chaos Engineering | Safe failure simulation | Explicit sandbox/staging experiment | Production disruption or owner-less destructive test | experiment plan/approval |
| 23 | GitOps | Git as source of truth | Repo/config/control-spine changes | Manual mutation outside PR | PR/receipt/register evidence |
| 24 | Shift-Left Security / DevSecOps | Security before merge | Code/config/secret/receipt changes | Secret dump or unredacted report | redacted scan receipt |
| 25 | SRE | SLO/error budget/postmortem discipline | Production incident/service reliability | Applying SRE labels without evidence | postmortem/runbook/SLO note |

## Task-Class Mapping

- `MICRO`: ReAct only when a tool/action is used; all unrelated methods
  forbidden.
- `STANDARD`: ReAct, Plan-and-Execute, review checklist, GitOps when repo
  artifacts change.
- `INCIDENT`: ReAct, Reflexion, Debugging Ladder, Observability, 5 Whys/RCA,
  SRE.
- `FULL`: ReAct, Chain/Tree safe summary, Plan-and-Execute, Reflexion, ADR,
  C4 where system boundary applies, GitOps, DevSecOps, SRE discipline.
- `CODE_IMPLEMENTATION`: ReAct, Plan-and-Execute, Test Pyramid, TDD,
  Automated Review Checklist, GitOps, DevSecOps; Contract/PBT where applicable.
- `QA_VALIDATION`: ReAct, Reflexion, Test Pyramid, Review Checklist,
  DevSecOps.
- `REGISTRAR`: ReAct, Plan-and-Execute, Conventional Commits/SemVer, GitOps,
  DevSecOps.

