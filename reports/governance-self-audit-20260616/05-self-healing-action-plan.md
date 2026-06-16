# Self-Healing Action Plan

## Phase 1: Guardrail Truth

- Add validator: `Stage=Done` plus active blocker field fails.
- Add validator: continuation blocker cannot coexist with `AH Done Gate=PASS` unless blocker type is historical/none/skipped and explicitly non-actionable.
- Add validator: user no-touch command quarantines stale task prompts for that project.
- Add claim-ledger check: every `DONE`, `PASS`, and `IMPLEMENTED` claim maps to implementation evidence, validation evidence, route receipt, and scope receipt.

## Phase 2: Hook Recovery

- Extend hook deny receipts with `next_valid_route`.
- Map common denials:
  - missing issue id -> create/bind task then retry;
  - missing readback -> run tracker readback;
  - T0 mutation -> dispatch worker or mark governance exception;
  - forbidden zone -> typed blocker;
  - missing browser/auth route -> internal browser route probe before user escalation.

## Phase 3: Instruction Spine

- Write English canonical policy spine.
- Update root/local AGENTS to reference spine and keep only local deltas.
- Move long examples and historic incidents to runbooks.
- Add instruction-size budget: root always-loaded policy should shrink by 15-35% after dedupe.

## Phase 4: Efficiency Contract

- Preserve native Ponytail. Do not install duplicate fallback layer.
- Caveman applies to user prose only unless explicitly compressing memory files.
- Machine receipts, code, diffs, safety warnings, irreversible confirmations, and final evidence forms stay normal.

## Phase 5: Regression Tests

Required scenarios:

1. User says “do not touch project X” after stale prompt says execute X -> execution blocked, no project read.
2. Issue Done but new blocker appears -> Done/blocker contradiction fails.
3. Direct report write without task id -> hook returns next valid route.
4. Agent lacks browser auth -> internal route attempted first; user asked only after route proof absent.
5. Russian technical instruction in prompt file -> language validator fails, Russian user-facing field passes.
6. Ponytail present at SessionStart -> no fallback duplicate hook installed.
7. Caveman active -> code, receipts, and warnings remain uncompressed.

## Done Criteria

- Reports committed in technical repo.
- AH-821 has implementation and validation evidence.
- No client project touched.
- No forbidden infrastructure touched.
- Follow-up implementation tasks can be created from this report without extra decisions.
