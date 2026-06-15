---
artifact_id: owner-output-solution-only-hardlock
artifact_type: governance-policy
source_task: AH-794
prompt_id: AGENTHUB-OWNER-OUTPUT-SOLUTION-ONLY-HARDLOCK-20260615
lifecycle: active_control_candidate
default_load: false
safe_to_replay: false
---

# Owner Output Solution-Only Hardlock

## Purpose

Prevent owner-facing final output from becoming routine blocker narration, factcheck-only reporting, apology loops, or status spam.

## Allowed Owner Output Classes

Owner-facing output is valid only when it is exactly one of these classes:

1. `SUCCESS`: `Готово: <result>, <evidence/readback>.`
2. `ACTION`: `Действие: <exact autonomous action being executed now>.`
3. `OWNER_ONLY_GATE`: `Нужен владелец: <exact irreversible/account/legal/payment/security action>.`

Any other final output class is invalid for owner delivery.

## Hard Denials

The owner-facing final must not contain:

- `Статус: blocked`
- `Осталось`
- `я остановился`
- `вставь команду`
- `не могу`
- `нужно включить worker`
- `PR готов, но`
- `factcheck:`
- long explanations
- technical logs
- internal tool output

## Routine Blocker Handling

Routine blockers are not owner finals. They must be converted into same-RUN PackFix/remediation tasks.

If the same routine blocker appears twice, the agent must stop blind retries and route architecture repair. It must not send blocker narration as a normal final.

## Owner-Only Gate Definition

`OWNER_ONLY_GATE` is allowed only for irreversible or account-bound actions that the agent cannot safely or lawfully perform autonomously, including account owner security settings, payment/legal approval, protected production release approval, or branch protection override when policy explicitly requires owner/admin authority.

## Done Gate

Done requires implementation evidence, validation evidence, receipt, main/readback or product/user proof when applicable, task readback, no active blocker, and no same-scope PR/task tail.

## Output Limit

Owner-facing final output must be Russian only, one line maximum, and contain no markdown sections.
