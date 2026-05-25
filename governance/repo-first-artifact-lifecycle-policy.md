---
artifact_id: repo-first-artifact-lifecycle-policy
artifact_type: governance-policy
owner_role: T0 Control Plane Registrar
source_task: AH-542
run_id: RUN-agenthub-p0-paralysis-breaker-repo-first-control-repair-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Repo-First Artifact Lifecycle Policy

## Default Load

Only these lifecycle classes may default-load:

- `active_policy`
- `current_policy`
- `active_control`
- `active_schema`
- `current_context_pack`
- `current_baseline`

Reports, receipts, handoffs, research reports, incident reports, prompt outputs,
and generated status notes default to `default_load=false`.

## Replay Safety

Prompts are one-time by default. A prompt may be replayed only when
`ARTIFACT_REGISTER.md` explicitly sets `safe_to_replay=true` and an active
policy references it. Consumed prompts must not be replayed as active
instructions.

## Quarantine

Set lifecycle to `quarantine` or `consumed_prompt` when an artifact:

- conflicts with current policy;
- uses the wrong canonical repository owner;
- contains stale recovery instructions;
- tries to override source priority;
- includes raw secret, env, token, private key, or internal transcript material;
- can trigger duplicate tasks, duplicate PRs, or same-gate loops.

## Registrar Duty

Every new or changed repo artifact must update:

- `INDEX.md`;
- `ARTIFACT_REGISTER.md`;
- `PR_QUEUE_REGISTER.md` when a PR exists or is queued;
- a receipt under `reports/receipts/` for non-trivial control changes.
