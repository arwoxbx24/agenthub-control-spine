---
artifact_id: adr-api-documentation-first-agenthub-guardrail-20260531
artifact_type: architecture_decision
owner_role: T1 Architect
source_task: AH-P0-DOCS-API-FIRST-GUARDRAIL
run_id: RUN-P0-DOCS-API-FIRST-GUARDRAIL-20260531
created_at: 2026-05-31
default_load: false
safe_to_replay: false
---

# ADR: API And Documentation First AgentHub Guardrail

## Context

Incident evidence shows agents can overfit to direct filesystem, database,
container, or proxy-level changes and then claim weak PASS from partial
signals. Packaged products and vendor apps have supported mechanisms that
preserve invariants and survive updates; product-internal surgery often does
not.

## Options

### Option A: Policy-only prompt tightening

Fast and cheap, but weak. It does not block tool use, stale report replay, fake
PASS, or direct product-internal mutation. Rejected as insufficient.

### Option B: Control-spine guardrails, templates, validators, and eval suite

Install durable policy, API route sheet template, documentation lookup template,
truth ledger schema, mutation/firewall validator, fixtures, registers, and
receipts. This is enforceable and low risk. Selected baseline.

### Option C: Runtime capability firewall

Strongest enforcement through runtime action blocking. Desirable where
AgentHub already supports hooks/tool gates, but deeper integration is higher
risk. Adopt incrementally through validators/templates now and runtime policy
engine work as separate platform remediation when needed.

## Decision

Adopt Option B now. Use Option C only where current runtime gates already
support it. Never rely on Option A alone.

## Consequences

- Third-party/product/service mutation must pass documentation lookup and API
  route sheet gates first.
- Direct product DB mutation and container-internal surgery are denied by
  default.
- Owned source code can still be edited normally inside scoped repository
  boundaries with tests.
- Hiddify-like runtime work remains isolated as child tasks with explicit live
  authority and browser/user-outcome validation.
