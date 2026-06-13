---
artifact_id: workspace-codex-directory-governance-policy-20260613
artifact_type: governance_policy
source_task: AH-787
source_audit: AH-786
run_id: workspace-codex-directory-governance-implementation-20260613
lifecycle: active_policy
default_load: false
safe_to_replay: false
---

# Workspace + Codex Directory Governance Policy

## Purpose

Prevent uncontrolled folders, uncontrolled reports, blind retries, fake Done states, unverified client claims, and user-interruption loops across AgentHub, Codex, workspace, and control-spine surfaces.

## Allowed Roots

| Root | Purpose | Mutation authority | Final artifact allowed |
|---|---|---|---|
| `@workspace/projects/agenthub-control-spine` | canonical governance repo | task-bound branch/PR | yes |
| `@workspace/projects/<client-project>` | client/product source | project task only | no AgentHub proof folders |
| `@runtime` | Codex/AgentHub runtime | runtime governance task only | no final docs |
| `@agenthub-runs/<RUN_ID>` | operational run evidence | AgentHub runtime only | receipt evidence only |
| `@artifacts` | registered artifacts | artifact service route | yes when registered |

## Forbidden Final Artifact Locations

- unmanaged `/tmp` or scratch roots;
- random `/root` folders;
- client project roots for AgentHub proof;
- `.codex` sessions, logs, caches, plugin staging, generated runtime outputs;
- DB/proxy/Docker/firewall/service paths;
- folders named `tmp`, `temp`, `scratch`, `final2`, `reports2`, `old`, `new`, `copy`, `backup-new`, or similar unless registered as restore-only or operational runtime.

## Artifact Lifecycle Defaults

Reports, audits, handoffs, transcripts, receipts, prompts, and run outputs default to `default_load=false` and `safe_to_replay=false` unless a current active policy/schema/context explicitly allows otherwise.

## Directory Creation Rule

New persistent directory creation is allowed only when the directory is in the directory map or the task includes a registered map update with owner, purpose, lifecycle, mutation authority, cleanup policy, and evidence pointer.

## Done Markers

YouTrack Done descriptions must include exact canonical markers:

```text
Implementation evidence: <installed control/diff/artifact path>
Validation evidence: <validator/eval/readback/user proof>
Receipt: <receipt path>
Blocker: none
```

Residual text such as `pending`, `remaining`, `later`, `separate deployment`, `needs user`, or `validation missing` blocks Done unless explicitly scoped outside current task.

## Agent Cycle

Capture task, classify task, bind YouTrack task and RUN_ID, read source of truth, select role and skills, build exact scope, discover read-only, mutate minimally, validate, write receipt, update registers, update/readback YouTrack, and close only if Done Evidence Tuple is complete.

## PackFix Rules

Routine blockers do not go to user chat. Missing register row, PR queue state, parser format, validation route, browser route, stale prompt conflict, or unclear directory purpose becomes same-RUN PackFix.

## Testing Contract

No vague `many tests passed`. Each closure requires a scoped matrix for applicable layers: schema, policy fixtures, role boundary, directory allow/deny, lifecycle/register, YouTrack Done/readback, PR queue, redaction, MCP/AgentHub route, service/API, browser/user story, external route, replay/idempotency, and negative matches.

## Client Claim Ledger

Client-facing full delivery requires a claim ledger with every claim green and directly evidenced. Unknown or partial claims must be excluded or marked not included.
