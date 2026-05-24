---
artifact_id: governance-cyber-safe-prompt-wording-policy
artifact_type: governance-policy
owner_role: T0 Registrar
source_task: AH-528
run_id: RUN-control-spine-cyber-safe-prompt-wording-20260524
created_at: 2026-05-24
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Cyber-Safe Prompt Wording Policy

This policy prevents legitimate AgentHub/Codex maintenance prompts from using
ambiguous cybersecurity wording that can cause false-positive platform blocks.
It is not a bypass policy. It blocks exploit, credential theft, stealth,
persistence, malware, public-target scanning, and secret exposure requests.

## Authorized-Scope Preamble

Every cyber-adjacent prompt must begin with a clear defensive scope:

```text
This is authorized defensive maintenance for owned infrastructure under
YouTrack task <TASK_ID>. No exploitation, no credential theft, no persistence,
no malware, no public-target scanning, and no secret exposure.
```

The prompt must also name the controlling task, RUN_ID, owner role, exact owned
assets, allowed actions, forbidden actions, evidence, rollback/checkpoint rule,
validation evidence, and typed blocker format.

## Wording Normalizer

| Ambiguous or unsafe wording | Required handling |
|---|---|
| `hack`, `взлом`, `обойти` | Forbidden unless quoting blocker text. Use `authorized maintenance`, `restore owned service`, or `repair approved route`. |
| `достань токен`, `вытащи секрет`, `show key` | Forbidden. Use `verify secret exists without printing it` and return only redacted proof. |
| `сканируй все`, `scan everything` | Forbidden. Use `bounded readback for owned task scope` with explicit assets. |
| `зайди в ssh и делай` | Use `approved scoped worker route; read before write; no T0 shell mutation`. |
| `прокси` alone | Require exact class: `NPM/Proxy Manager`, `Telegram MTProxy`, `HTTP proxy`, `VPN route`, or `Docker upstream`. |
| `urgently fix server` | Require task id, owned assets, allowed surface, forbidden zones, validation, rollback, and blocker class. |

## Safe Task Brief Template

```text
Task: <TASK_ID>
RUN_ID: <RUN_ID>
Owner role: <T0/T1/Worker/Verifier>
Authorized scope: owned infrastructure only; defensive maintenance.
Owned assets: <exact assets>
Allowed actions: <bounded read/repair actions>
Forbidden actions: no exploitation, credential theft, persistence, malware,
public-target scanning, secret exposure, or out-of-scope runtime mutation.
No-secret proof: verify presence or route availability without printing values.
Rollback/checkpoint: <checkpoint and rollback rule>
Validation evidence: <bounded checks and expected proof>
Typed blocker: SAFETY_SCOPE_UNCLEAR | FORBIDDEN_CYBER_ACTION |
ROUTE_AUTHORITY_MISSING | SECRET_REDACTION_REQUIRED | VALIDATION_FAILED
```

## False-Positive Gate

Before sending a cyber-adjacent prompt to Codex, TeamLead, or a worker:

1. If the prompt contains cyber-adjacent words without authorization and exact
   scope, repair the prompt first.
2. If it asks for secrets, exploitation, stealth, persistence, credential
   extraction, malware, or broad/public scanning, block with
   `FORBIDDEN_CYBER_ACTION`.
3. If legitimate ownership or scope is unclear, block with
   `SAFETY_SCOPE_UNCLEAR`.
4. If the work is legitimate but likely to be flagged, rewrite it to precise
   authorized defensive maintenance language and continue in the same task.
5. If a platform warning appears, do not ask Andrey to rewrite repeatedly.
   Create or update a remediation receipt, normalize the prompt safely, and
   continue if the rewritten scope is allowed.

## Prompt Red-Team Checklist

Use this checklist before dispatch:

- Authorization is explicit and tied to a YouTrack task.
- Assets are owned and exact.
- T0 does not perform shell/runtime mutation.
- Secrets are never printed; only redacted existence proof is allowed.
- Proxy class is exact. Proxy Manager is not Telegram MTProxy.
- Authorized maintenance is not exploit work.
- Secret existence check is not secret printing.
- Review/platform gate becomes remediation task, not an Andrey-click request.
- Broad scans are replaced with bounded readback.
- Final state is evidence-backed or one typed blocker.

## Required Outcomes

Compliant prompt wording must preserve safety and clarity at the same time:

- allow authorized defensive maintenance on owned assets;
- make forbidden cyber actions impossible to route accidentally;
- reduce false-positive platform blocking from ambiguous wording;
- keep the task inside YouTrack, AgentHub/Codex, and control-spine evidence;
- avoid user interruption when same-task prompt normalization can repair the
  issue.
