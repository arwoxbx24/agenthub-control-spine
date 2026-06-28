---
artifact_id: agenthub-authority-lifecycle-expansion-policy
artifact_type: active_policy
source_task: AH-765
run_id: RUN-AGENTHUB-AUTHORITY-LIFECYCLE-EXPANSION-20260612
created_at: 2026-06-12
lifecycle_status: active_control_candidate
default_load: false
safe_to_replay: false
---

# AgentHub Authority Lifecycle Expansion Policy

## Purpose

Routine blockers must become same-RUN PackFix repair work instead of final
owner chat. Safety gates remain for secrets, destructive action, legal/payment
approval, and forbidden global infrastructure.

## Official Source Packet

- `https://developers.openai.com/codex/cli/reference`: Codex CLI supports
  explicit model selection; route metadata is not execution proof.
- `https://developers.openai.com/codex/config-basic`: Codex configuration can
  set model, sandbox, approval, and MCP settings.
- `https://developers.openai.com/codex/agent-approvals-security`: scoped
  sandbox and approval policy are separate controls; full bypass is not the
  default repair.
- `https://modelcontextprotocol.io/docs/tutorials/security/authorization`:
  sensitive/admin/user-specific MCP operations need authorization.
- `https://modelcontextprotocol.io/specification/2025-11-25/server/tools`:
  tools must be discovered with stable names/schemas and invoked explicitly.
- `https://www.jetbrains.com/help/youtrack/devportal/youtrack-rest-api.html`:
  YouTrack state is changed through official JSON REST surfaces.
- `https://www.jetbrains.com/help/youtrack/devportal/resource-api-commands.html`:
  command-backed issue operations require query and issue ids.

## Lanes

- Lane 0: read-only diagnosis.
- Lane 1: control-spine artifact write.
- Lane 2: YouTrack stage/evidence movement.
- Lane 3: validator execution.
- Lane 4: browser/user outcome QA.
- Lane 5: scoped microservice repair with descriptor and rollback.
- Lane 6: destructive/stateful repair with backup or explicit owner approval.
- Lane 7: model routing and quota proof.

## Required Tool Routes

The following routes are required as real AgentHub/MCP/internal tools before
global Done can be claimed: authority envelope create/verify, permission broker
escalation, lane classifier, PackFix create/execute, blocker-to-PackFix,
repeat-gate breaker, route-repair dispatch, validator run, schema parse,
receipt validate, Done gate check, truth-redteam run, YouTrack readback/stage
move/duplicate/evidence, register autopatch, PR queue state, branch lifecycle,
Codex catalog/execution/usage probes, model router/fallback receipt,
docs packet fetch/verify/claim linter, microservice descriptor/read/repair,
rollback snapshot, browser outcome probe, secret redaction scan, secret vault
bridge, and destructive-action proof.

## Lifecycle

1. Bind one task and one RUN.
2. Read official docs before product claims.
3. Classify lane and create an authority envelope.
4. Dispatch the correct worker front.
5. Convert routine blockers to PackFix.
6. Deny a third identical retry.
7. Validate with task-bound receipts.
8. Update registers and task evidence.
9. Move YouTrack to Done only after full evidence.

## Methodology Triggers

- Five Whys: second identical blocker, fake Done, or contradiction.
- FMEA: destructive/stateful or multi-service repair.
- ADR: new lane, model policy, lifecycle change.
- C4/service map: microservice scope.
- DDD: ownership/domain confusion.
- OODA/PDCA: recurring incident.
- Pre-Done Red Team: before every Done.
- Brainstorm: unclear intake, two identical blockers, failed closure, or
  pre-Done red-team only.

## Final Gate

Generic `BLOCK`, prompt-only output, env-only model proof, HTTP-200-only proof,
sandbox-only implementation proof, and files-installed-without-validator-proof
are never Done.
