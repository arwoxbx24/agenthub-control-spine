---
artifact_id: owner-output-solution-only-hardlock
artifact_type: governance-policy
source_task: AH-803
prompt_id: AGENTHUB-OWNER-OUTPUT-SOLUTION-ONLY-HARDLOCK-20260615
lifecycle: active_control
default_load: false
safe_to_replay: false
---

# Owner Output Solution Only Hardlock Policy

Owner-facing output must be action-bound and evidence-backed. Routine blocker,
apology, status-only, factcheck-only, and not-done messages are not valid final
owner output.

## Allowed Owner Output Classes

- `SUCCESS`: `Готово: <result>, <evidence/readback>.`
- `ACTION`: `Действие: <exact autonomous action being executed now>.`
- `OWNER_ONLY_GATE`: `Нужен владелец: <exact irreversible/account/legal/payment/security action>.`

## Routine Blockers

Routine blockers must become same-RUN PackFix or remediation work. They are not
owner-facing finals. If the same blocker repeats twice, stop retrying that path
and route architecture repair instead of owner chat.

## Done Evidence

Done requires implementation evidence, validation evidence, receipt,
main/readback or user proof when applicable, task readback, no active blocker,
and no same-scope PR/task tail.
