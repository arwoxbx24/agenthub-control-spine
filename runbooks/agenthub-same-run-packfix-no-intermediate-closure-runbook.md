# AgentHub Same-RUN PackFix No-Intermediate Closure Runbook

Source task: `AH-777`

## Operator Flow

1. Bind to the existing task and RUN.
2. Check prompt idempotency by `prompt_id`, `idempotency_key`, and `scope_signature`.
3. Read current task graph, PackFix ledger, artifact register, PR queue, and receipt paths.
4. Convert routine blockers to same-RUN PackFix work.
5. Create authority envelope only for the missing lane.
6. Run validator/canary before task closure.
7. Close all PackFix children.
8. Move the parent through `Review -> Test -> Done`.
9. Read back `Stage=Done`, `Done Gate=PASS`, implementation evidence, validation evidence, receipt, and no-blocker marker.

## Stop Rules

Stop only for:

- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `DENY_FORBIDDEN_SCOPE`

Routine blocker text is not owner-facing final output.

## Canary

Run:

```bash
ruby validators/agenthub_same_run_packfix_no_intermediate_closure_validator.rb
```

Expected:

```json
{"status":"PASS","cases":6}
```
