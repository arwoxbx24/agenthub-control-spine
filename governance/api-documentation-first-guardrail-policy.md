---
artifact_id: api-documentation-first-guardrail-policy
artifact_type: active_policy
owner_role: T1 Architect / Safety Controller
source_task: AH-P0-DOCS-API-FIRST-GUARDRAIL
run_id: RUN-P0-DOCS-API-FIRST-GUARDRAIL-20260531
created_at: 2026-05-31
default_load: false
safe_to_replay: false
---

# API And Documentation First Guardrail Policy

AgentHub must use documented mechanisms before product internals. This is not
API-at-any-cost. It is documented-mechanism first: official API, official admin
panel, official CLI, documented config, SDK, MCP interface, migration command,
or supported deployment path.

## Surface Classes

| Surface class | Required route before mutation | Forbidden by default |
|---|---|---|
| Ready-made product / vendor app / Dockerized product / CMS / SaaS / panel | official docs, API/admin/CLI/SDK/MCP/config route sheet, dry-run or read-only status, rollback, user-outcome validation | direct DB writes, container overlay edits, vendored-code surgery, UUID/password/secret regeneration, hardcoded product state |
| Owned application code | AGENTS/docs, entry point, tests; official docs only for framework/API/security/version-specific uncertainty | unrelated files, direct data mutation bypassing app invariants |
| Existing custom service API | route/schema/controller contract, integration tests, service API or migration path | direct table updates to bypass service invariants |
| Infrastructure/deployment | official docs and deployment docs, read-only state, supported config/deploy route, rollback, external validation | prune/reset/delete, port hijack, broad firewall/proxy rewrite, unrelated service stop |
| Unknown product/behavior | identify product/version/deployment/docs first | mutation before docs/product identity proof |

## Required Gates

- `DOCUMENTATION_LOOKUP_GATE`: mandatory for third-party products, auth,
  security, credentials, users, domains, routing, SSL, DNS, proxy, firewall,
  database, production/service behavior, model/agent/Codex/MCP/GitHub/YouTrack
  features, incidents, CLI flags, low confidence, or repeated failures.
- `API_ROUTE_SHEET_GATE`: required for packaged products and services before
  write-capable action.
- `MUTATION_FIREWALL`: blocks T0 mutation, product DB mutation, container
  internals, broad infrastructure mutation, secret dumps, hardcoded
  UUID/password/token/domain fixes, repeated same-gate retries, and mutation
  before required docs/API route sheet.
- `TRUTH_LEDGER_GATE`: material claims must be `EVIDENCED`, `HYPOTHESIS`,
  `UNVERIFIED`, or `REJECTED`.

## Extreme Product-Internal Exception

Product-internal mutation may only be proposed after all are true:

1. official docs were checked;
2. API/admin/CLI/MCP/config route is absent or insufficient;
3. internal mutation is the only possible route;
4. ADR records blast radius, update risk, supportability risk, and rollback;
5. isolated emergency scope exists;
6. explicit `DOCKER_INTERNAL_EMERGENCY_AUTHORITY` or
   `DB_MUTATION_AUTHORITY` exists;
7. backup/checkpoint exists;
8. product user outcome validation exists.

Without this authority the terminal state is `FORBIDDEN_SCOPE_BLOCKER`,
`DOCS_UNAVAILABLE_BLOCKER`, or `API_ROUTE_UNAVAILABLE_BLOCKER`.
