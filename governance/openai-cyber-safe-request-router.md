---
artifact_id: governance-openai-cyber-safe-request-router
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-541
related_tasks:
  - AH-537
  - AH-538
run_id: RUN-agenthub-openai-cyber-flag-safe-router-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# OpenAI Cyber-Safe Request Router

This router separates authorized AgentHub operational work from genuinely
high-risk or prohibited cybersecurity requests. It is not a bypass policy and
must never instruct agents to evade, hide from, or disable OpenAI safeguards.

Official OpenAI Cyber Safety documentation says Trusted Access for Cyber is for
potentially high-risk cybersecurity work, and that trusted users still must
follow OpenAI Usage Policies and Terms of Use. AgentHub must therefore improve
clarity, authority, scope, and evidence, not weaken safety controls.

## Required Request Frame

Every prompt or worker dispatch containing Docker, shell, live adapter, proxy,
DNS, SSL, scanning, incident, security, credential, token, or exploit-like
language must be normalized before dispatch:

| Field | Required content |
|---|---|
| Authority | Controller task id, owner role, RUN_ID, and who is authorized to act. |
| Owned environment | Exact owned repo, service, host, or AgentHub control-plane surface. |
| Target scope | Exact allowed targets; no broad public targets or inferred assets. |
| Allowed actions | Read-only triage, scoped governance/config/template repair, backup, rollback, validation, or explicitly authorized bounded mutation. |
| Forbidden actions | Secret exposure, credential collection, data exfiltration, stealth, persistence, malicious code, public target testing, and destructive action without authority and rollback. |
| Secrets policy | No raw env, tokens, keys, passwords, private keys, raw webhook URLs, or raw transcript links. Redacted existence proof only. |
| Destructive-action policy | Block unless exact owner authority, target, backup/checkpoint, rollback, and validation are present. |
| Validation plan | User-visible or artifact-visible evidence required before Done. |

Do not use keyword-only filtering. Classify by intent, authorization, target
ownership, action class, blast radius, rollback, and evidence.

## Router Classes

### 1. AUTHORIZED_ADMIN_DEVOPS

Use for owned/internal service availability, Docker health, proxy-manager
health, logs, ports, backups, rollback, and validation.

Allowed only when the request states:

- owned/internal environment;
- task id and RUN_ID;
- exact services or hosts;
- no secrets in chat or artifacts;
- no destructive action unless explicitly scoped, backed up, and reversible;
- validation evidence and final gate.

Forbidden in this class:

- public target scanning;
- exploit development;
- credential collection;
- broad Docker prune/reset/delete;
- DB/Nginx/proxy/firewall mutation without exact owner-only gate.

If deletion of running containers, images, volumes, service data, or rollback
state is requested without exact scoped backup/rollback proof, return
`OWNER_ONLY_IRREVERSIBLE_GATE`.

### 2. AGENTHUB_CONTROL_PLANE

Use for AgentHub, Codex, YouTrack, GitHub, prompt, routing, register, template,
hook, validation, final-gate, and artifact lifecycle repair.

This class must continue even if a live runtime command adapter is unavailable.
Missing live command capability blocks only live runtime mutation. It must not
block GitHub artifact work, YouTrack updates, register updates, prompt/template
repair, schema/eval work, receipts, or read-only analysis.

Required typed blockers:

- `LIVE_RUNTIME_ADAPTER_NOT_EXPOSED` when live runtime command dispatch is not
  exposed.
- `SANDBOX_ONLY_NOT_RUNTIME_PROOF` when sandbox evidence exists but does not
  prove production/user outcome.
- `T0_DIRECT_RUNTIME_MUTATION_FORBIDDEN` when completion would require direct
  T0 shell/runtime mutation.

### 3. DEFENSIVE_SECURITY_AUTHORIZED

Use for defensive code review, vulnerability triage, patch validation, and
hardening in an authorized owned repo or environment.

Required fields:

- owner authority;
- owned environment;
- allowed targets;
- allowed defensive action;
- forbidden exploit/payload/exfiltration language;
- Trusted Access or support path when the request becomes high-risk cyber work.

If a defensive request needs high-risk cyber capability beyond ordinary
authorized hardening, return
`TRUSTED_ACCESS_REQUIRED_FOR_HIGH_RISK_DEFENSIVE_CYBER` and do not rewrite it
as ordinary DevOps.

### 4. PROHIBITED_OR_OWNER_ONLY_RISK

Use for credential theft, malicious deployment, stealth, persistence,
unauthorized external targets, public scanning, destructive infrastructure
actions, data exfiltration, or policy-bypass requests.

Required outcome:

- block;
- or escalate only through an explicit owner-only gate, Trusted Access, Support,
  or a new scoped governance task.

Never claim Trusted Access permits prohibited behavior. It does not.

## Safe Request Normalizer

Normalize noisy or flagged requests into this structure before dispatch:

```text
Authorized environment: owned/internal systems only.
Purpose: availability, maintenance, hardening, validation, or control-plane repair.
Target scope: exact repo/service/task/RUN.
Allowed actions: read-only triage, scoped config/template/policy change, backup, rollback, validation.
Forbidden actions: secrets exposure, destructive action without backup/authority, public target testing, malicious code, credential collection, data exfiltration, stealth, persistence, policy bypass.
Evidence: task readback, changed files, validation result, no-secret proof, receipt.
Final gate: evidence-backed Done or exact typed blocker.
```

When a ChatGPT/Codex cyber warning is reported, stop replaying noisy text. Build
a clean authorized-scope summary, split DevOps from defensive security and
control-plane work, then route each class separately. If high-risk defensive
cyber work remains necessary, use Trusted Access or Support; do not bypass.

## Repeated Blocker Rule

The same blocker may appear twice while evidence is being gathered. A third
loop is forbidden. On the second occurrence, the run must either install an
architecture repair for the blocker or end with one exact typed terminal
blocker from the approved list.

## Done Gate

Done requires:

- router class recorded;
- authorized-scope schema present;
- safe normalizer applied;
- live adapter absence not used to stop non-runtime work;
- eval fixtures pass;
- red-team checks pass or return an exact typed blocker;
- no-secret proof;
- register and index coverage;
- receipt attached to the task.
