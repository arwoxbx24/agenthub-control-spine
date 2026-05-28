---
artifact_id: agenthub-x-capability-matrix
artifact_type: governance_policy
owner_role: T1 Architect / Lifecycle Controller / Registrar
source_task: AH-590
run_id: RUN-P0-AGENTHUB-X-CAPABILITY-HARD-ENFORCEMENT-20260528
created_at: 2026-05-28
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub X Capability Matrix

## Decision

AgentHub X uses a closed-contour capability matrix. It is neither an unlimited
root grant nor a blocker-first system. Every action must match a named
capability profile with role, allowed surface, forbidden surface, rollback,
validation, evidence, and receipt rules.

T0 may request routing and validate receipts only. T0 cannot execute shell,
Linux, Docker, Python, Node, PHP, Ruby, YC, TWC, NPM, git mutation, runtime
mutation, product edits, secret reads, or broad black-box work.

## Owner-Only Gates

Only these gates may be returned to the owner:

- external credential/account access no agent can possess;
- legal or payment authority;
- destructive or globally irreversible action;
- explicit non-delegable identity proof;
- missing secret handle after metadata-only lookup.

All other missing capability is an internal AgentHub X remediation task that
patches the matrix, hook, adapter, worker profile, or validator and resumes the
same RUN.

## Methodology Gate

Risky work must record selected methods before action. Selecting every method
without a reason fails as `TOKEN_BLOAT / METHOD_OVERLOAD_DEFECT`. Selecting no
method for a risky task fails as `METHODOLOGY_GATE_MISSING`.

| Task class | Required method set |
|---|---|
| T0/T1 architecture defect | FULL: 5 Whys, FMEA, ADR, evals, repo-first receipt |
| Runtime incident | INCIDENT: debugging ladder, observability, rollback, user outcome |
| Code/config task | STANDARD or FULL: Plan-and-Execute, Test Pyramid, code review |
| Domain/product design | FULL: DDD/Event Storming, C4, ADR |
| Registrar/report task | MICRO/STANDARD: lifecycle register, evidence ledger |

## Capability Profiles

| Profile | Owner role | Allowed | Forbidden | Evidence |
|---|---|---|---|---|
| `CONTROL_PLANE_ADMIN` | AgentHub X / Lifecycle Controller / Registrar | AgentHub policies, hooks, validators, schemas, evals, worker templates, dispatcher templates, model router, task router, repo registers | product/runtime/Docker/DB/proxy/DNS/firewall mutation | policy diff, validation output, receipt, register update |
| `T0_CONTROL_ONLY` | TeamLead T0 | intake, classify, bind task, start/resume RUN, route worker, verify receipts, final owner summary | shell, Linux, Docker, Python, node/php/go/ruby, git mutation, product code/config/YAML/env edits, DB, proxy, DNS, SSL, NPM, firewall, secrets | route receipt and final readback |
| `T1_ARCHITECT` | Architect | system design, ADR, micro-TZ, profile approval, method selection, risk review | runtime mutation and product code edits | ADR and risk evidence |
| `T2_CODEX_IMPLEMENTER` | Scoped code/config worker | code, config, YAML, shell-script changes inside assigned repo/scope/branch | production runtime mutation unless separate runtime profile is granted | worker model, model route reason, tests, diff review, secret scan, PR, receipt |
| `P4_RUNTIME_READ` | Runtime read worker / Verifier | bounded Docker/NPM/DNS/YC/TWC/curl/logs/system inventory through adapters | mutation, env dump, secret read, broad logs | redacted bounded read receipt |
| `P4_RUNTIME_REPAIR` | Runtime repair worker | minimal scoped Docker/NPM/DNS/SSL/YC/TWC/PM2/systemd repair when exact surface is granted | broad infrastructure changes, DB writes, prune/reset/delete, secret exposure, cross-project mutation | rollback/checkpoint, before/after validation |
| `SECRET_HANDLE_READER` | Secret metadata worker | approved secret handles and metadata from registry | printing values, dumping env, arbitrary filesystem search, committing values | redacted handle receipt |
| `VERIFIER_READONLY` | Verifier | read-only repo/task/runtime evidence and public outcome checks | mutation | validation report |
| `REGISTRAR` | Registrar | INDEX, ARTIFACT_REGISTER, PR_QUEUE_REGISTER, lifecycle states, context packs, quarantine/supersede records | runtime/product mutation | register diff and receipt |

## Missing Capability Rule

If an action lacks a matching profile, return
`INTERNAL_CAPABILITY_REMEDIATION_REQUIRED` and create a same-RUN remediation
task unless the request is owner-only. AgentHub route blocked is never
permission for T0 direct fallback.

## Loop Rule

The same gate may fail at most twice in one scope. The third retry is blocked
with `SAME_GATE_LOOP_BLOCKED` and must switch to remediation or a typed final
blocker.
