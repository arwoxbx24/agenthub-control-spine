---
artifact_id: final-runtime-contour-enforcement-policy
artifact_type: governance-policy
owner_role: T1 Architect / T0 Control Plane
source_task: AH-632
run_id: RUN-P0-FINAL-CONTOUR-RUNTIME-ENFORCEMENT-20260601
created_at: 2026-06-01
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Final Runtime Contour Enforcement Policy

This policy binds the already installed no-chat, task-first, boundary, model,
task-graph, and silent-to-Done controls into one final release gate for
AgentHub/Codex runtime contours.

## Required Gates

Every executable contour must prove all of these gates before terminal owner
output:

1. `SILENT_UNTIL_TERMINAL`: after initial intake, owner chat is blocked until
   `DONE_WITH_EVIDENCE`, `OWNER_ONLY_IRREVERSIBLE_GATE`, or `SAFETY_QUARANTINE`.
2. `USER_DELTA_QUEUE`: later owner messages are buffered as classified deltas
   and must not stop scoped workers.
3. `FORBIDDEN_PATH_PRETOOL`: writes and implementation evidence under
   `/root/gemini-space`, `/root/codex-space`, `/tmp`, Docker data, DB data,
   proxy/firewall/certificate, or secret surfaces are rejected before write.
4. `LIVE_PATH_PROOF`: product file evidence is accepted only when canonical
   live-path proof exists; Hiddify live path proof must come from an official
   API/panel route or the live panel process root.
5. `TASK_GRAPH_PHYSICAL_WRITE_READBACK`: YouTrack stage/evidence updates require
   physical issue write/readback; local ledgers are temporary queues only.
6. `DONE_GATE_PARSER_REPAIR`: if full evidence exists but the parser rejects
   Done, create same-run parser repair instead of fake Done.
7. `MODEL_SPAWN_RECEIPT`: spawned implementation requires requested, resolved,
   actual model, and non-`not_applicable` spawn receipt. `agenthub-sandbox-worker`
   is not Spark proof.
8. `CONTEXT_BUDGET_LOOP_BREAKER`: after two identical gate failures or context
   overflows, compact and route a repair task; do not replay the full transcript.
9. `ANTI_SPAM_NOT_FREEZE`: duplicate task creation/watchers may be blocked, but
   existing implementation, evidence, QA, stage updates, and closure must
   continue.
10. `STALE_PROMPT_QUARANTINE`: reports, receipts, and consumed prompts are not
    executable instructions unless the artifact register says
    `safe_to_replay=true`.
11. `EVIDENCE_NO_SECRET`: receipts and owner output must not contain secrets,
    raw env, tokens, private keys, or raw internal operational dumps.
12. `USER_OUTCOME_PROOF`: product/UI/domain Done requires exact user-outcome
    proof, not a homepage/login-only or unrelated curl result.

## Bad Examples That Must Be Rejected

- Hiddify implementation from `/root/gemini-space`.
- Mid-contour progress chat that stops workers.
- `requested_model=gpt-5.3-codex-spark` with
  `actual_model=agenthub-sandbox-worker` and no approved fallback receipt.
- Spawned implementation with `spawn_receipt=not_applicable`.
- Parent Done while child task is `Backlog`, `Develop`, `Review`, or `Test`.
- Duplicate VPN/Hiddify/Telegram task creation while a master contour exists.
- Local ledger-only Done without YouTrack physical write/readback.
- Full prompt replay after context overflow.

## Domain Tail Rule

Hiddify/VPN work is a child contour only when exact YouTrack readback shows an
open AH-623/AH-624/AH-625/AH-626 tail or directly linked active duplicate.
If all linked tails are terminal, do not create a domain task.

