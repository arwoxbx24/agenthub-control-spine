# AgentHub Scoped Autonomy: Lane and Destructive Proof Profile

## LANE CLASSIFIER

1. `lane=0` — Chat/Report compression.
2. `lane=1` — Control-spine artifact authorship (governance, policy, receipts, registers).
3. `lane=2` — Repository hygiene/lifecycle and archival actions.
4. `lane=3` — Routine platform self-healing.
5. `lane=4` — Runtime read-only diagnostics.
6. `lane=5` — Bounded runtime repair via scoped T2 worker.
7. `lane=6` — Destructive/owner-confirmed actions only.

## ROUTER RULES

1. Routine blockers must map to one retry `repair` event:
   - `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` → `TASK_ID_SELF_HEALING_REQUIRED`.
   - `DISPATCH_TASK_GATE_MISSING` → `RUN_STATE_SELF_HEALING_REQUIRED`.
   - `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` → `SCOPED_T2_REPAIR_ALLOWED_WHEN_BOUND`.
   - `T0_DIRECT_AUTHORSHIP_DEFECT` in lane1 control-spine context → `CONTROL_SPINE_AUTHORSHIP_CLASSIFICATION_REPAIR_REQUIRED`.
   - `MODEL_FALLBACK_RECEIPT_MISSING` → `MODEL_FALLBACK_RECEIPT_REPAIR_REQUIRED`.
   - `DUPLICATE_PROGRESS_OUTPUT_BLOCKED` → `PROGRESS_OUTPUT_SUPPRESSED_CONTINUE`.
   - `PHYSICAL_TASK_WRITE_MISSING` → `TASK_CARD_PAYLOAD_REPAIR_REQUIRED`.
   - word filter reject → `WORD_FILTER_PAYLOAD_REWRITE_REQUIRED`.
   - share/publication missing → `SHARE_FALLBACK_TO_REPO_ARTIFACT_REQUIRED`.
   - legacy mapping mismatch → `STATUS_CONTEXT_MAPPING_REPAIR_REQUIRED`.
2. After one repair attempt, repeated same gate becomes one terminal `TASK_CARD_PAYLOAD_REPAIR_REQUIRED`.
3. `lane=1` permits control-spine authoring for T0/T1 on approved artifacts:
   - `governance/`, `artifacts/`, `schemas/`, `INDEX.md`, register/queue artifacts.
4. `lane=4` forbids mutation intents; only status, log, health, inspect diagnostics.
5. `lane=5` requires scoped runtime route evidence (`scope` includes repair or `evidence.t2_worker_route`).
6. `lane=6` requires proof schema:
   - `evidence.lane6.owner_approved`
   - `evidence.lane6.replacement_proven` or
   - `evidence.lane6.backup_verified` (+ dependency scan/deletion receipt when destructive).

## TERMINAL BLOCKS

- `OWNER_APPROVAL_REQUIRED_FOR_DESTRUCTIVE_DELETE`
- `BACKUP_OR_REPLACEMENT_PROOF_REQUIRED`
- `UNKNOWN_PRODUCTION_DATA_RISK`
- `SECRET_EXPOSURE_RISK`
- `BROAD_INFRASTRUCTURE_MUTATION_NOT_AUTHORIZED`
- `NO_SCOPED_T2_ROUTE_FOR_RUNTIME_REPAIR`
