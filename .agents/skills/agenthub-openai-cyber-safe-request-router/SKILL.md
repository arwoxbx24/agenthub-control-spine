---
name: agenthub-openai-cyber-safe-request-router
description: Classify cyber-adjacent AgentHub requests into safe authorized DevOps, control-plane, defensive security, or prohibited/owner-only risk before dispatch.
---

# AgentHub OpenAI Cyber-Safe Request Router

## Trigger

Activate before any prompt, task card, worker dispatch, report, or runbook that
contains Docker, shell, live adapter, proxy, DNS, SSL, scanning, incident,
security, credential, token, exploit-like language, or a reported ChatGPT/Codex
cyber warning.

## Purpose

Reduce false cybersecurity flags and agent paralysis by making authorized
scope, target ownership, action class, forbidden actions, rollback, validation,
and evidence explicit. This skill is not a bypass policy and must not instruct
evasion of OpenAI safeguards.

## Router Classes

Select exactly one primary class:

- `AUTHORIZED_ADMIN_DEVOPS`: owned/internal availability, Docker health,
  proxy-manager health, logs, ports, backups, rollback, and validation.
- `AGENTHUB_CONTROL_PLANE`: AgentHub/Codex/YouTrack/GitHub prompts, routing,
  registers, templates, schemas, validators, hooks, final gates, and receipts.
- `DEFENSIVE_SECURITY_AUTHORIZED`: defensive code review, vulnerability triage,
  patch validation, and hardening in an owned environment.
- `PROHIBITED_OR_OWNER_ONLY_RISK`: credential theft, malicious code, stealth,
  persistence, unauthorized targets, public scanning, data exfiltration, or
  irreversible infrastructure actions.

## Required Fields

Do not dispatch until the normalized request includes:

- task id and RUN_ID;
- owner authority;
- owned environment;
- allowed targets;
- forbidden targets;
- allowed actions;
- forbidden actions;
- secrets policy;
- destructive-action policy;
- rollback policy;
- validation policy;
- final gate.

## Safe Normalizer

When input is noisy, panic-driven, or flagged, rewrite it internally into this
neutral structure:

```text
Authorized environment: owned/internal systems only.
Purpose: availability, maintenance, hardening, validation, or control-plane repair.
Target scope: exact repo/service/task/RUN.
Allowed actions: read-only triage, scoped config/template/policy change, backup, rollback, validation.
Forbidden actions: secrets exposure, destructive action without backup/authority, public target testing, malicious code, credential collection, data exfiltration, stealth, persistence, policy bypass.
Evidence: task readback, changed files, validation result, no-secret proof, receipt.
Final gate: evidence-backed Done or exact typed blocker.
```

## Class-Specific Rules

### AUTHORIZED_ADMIN_DEVOPS

Allowed only for owned/internal systems. Require exact service scope and no
secret output. Destructive Docker/container/data deletion requires explicit
owner authority plus backup, rollback, and validation.

### AGENTHUB_CONTROL_PLANE

Continue even if live runtime command adapters are unavailable. Missing live
adapter blocks only live runtime mutation, not GitHub artifact work, YouTrack
updates, register updates, prompt/template/schema/eval repair, receipts, or
read-only analysis.

### DEFENSIVE_SECURITY_AUTHORIZED

Use only for defensive work in an owned repo/environment. If high-risk
defensive cyber capability is required, return
`TRUSTED_ACCESS_REQUIRED_FOR_HIGH_RISK_DEFENSIVE_CYBER`.

### PROHIBITED_OR_OWNER_ONLY_RISK

Block or escalate. Never transform prohibited cyber behavior into DevOps.

## Typed Blockers

Use only these blockers:

- `OPENAI_CYBER_FLAG_FALSE_POSITIVE_REPORTED`
- `TRUSTED_ACCESS_REQUIRED_FOR_HIGH_RISK_DEFENSIVE_CYBER`
- `LIVE_RUNTIME_ADAPTER_NOT_EXPOSED`
- `SANDBOX_ONLY_NOT_RUNTIME_PROOF`
- `T0_DIRECT_RUNTIME_MUTATION_FORBIDDEN`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `MISSING_ACCOUNT_CREDENTIAL`
- `INSTRUCTION_SOURCE_DRIFT`
- `DUPLICATE_PR_OR_TASK_EXISTS`
- `PROMPT_SCORE_BELOW_85`
- `SAFETY_QUARANTINE`

Do not use vague blocked states.

## Final Format

Return:

```text
router_class: <class>
normalized_scope: <one paragraph>
allowed_actions: <bounded list>
forbidden_actions: <bounded list>
evidence_required: <bounded list>
final_gate: <DONE_WITH_EVIDENCE or exact typed blocker>
```
