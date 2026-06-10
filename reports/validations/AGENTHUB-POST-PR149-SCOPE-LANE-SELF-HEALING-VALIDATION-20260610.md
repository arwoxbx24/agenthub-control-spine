---
artifact_id: agenthub-post-pr149-scope-lane-self-healing-validation-20260610
artifact_type: validation_report
owner_role: Verifier / T0 Registrar
source_task: AH-738 / AH-731 follow-up
run_id: RUN-AGENTHUB-POST-PR149-SCOPE-LANE-SELF-HEALING-20260610
created_at: 2026-06-10
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# Post-PR149 Scope-Lane Self-Healing Validation

## Readback

- Repository: `arwoxbx24/agenthub-control-spine`.
- PR #149 merged: PASS.
- PR #149 merge SHA: `923b3123e46124a6a39a74938eb33b0744bcbe69`.
- PR #149 receipt path exists in main commit diff: `reports/receipts/RUN-CONTROL-SPINE-BRANCH-HYGIENE-20260610-receipt.md`.
- Obsolete blocker `GITHUB_CONNECTOR_WRITE_UNAVAILABLE`: superseded by merge readback.
- Branch readback after follow-up cleanup: `main`, `repo-bridge-contract-20260607`, `agenthub/ah-728-minimal-core-recovery-20260610`.

## Gate Results

| Gate | Result | Evidence |
|---|---|---|
| `PR149_OBSOLETE_BLOCKERS_CLEARED` | PASS | PR #149 merged and receipt exists. |
| `SOFT_BLOCKER_SELF_HEALING_ENABLED` | PASS | Contract maps routine task/share/dispatch/status failures to Lane 1 same-run repair. |
| `NO_DUPLICATE_PROGRESS_SPAM` | PASS | Contract requires progress freeze and final-only compact owner output. |
| `TASK_PAYLOAD_FULL_CARD_ONCE` | PASS | Lane 1 requires one full safe task payload before terminal blocker. |
| `FORBIDDEN_WORD_PAYLOAD_REWRITE_OK` | PASS | Lane 1 allows neutral wording rewrite without safety weakening. |
| `LANE_CLASSIFICATION_PRESENT` | PASS | Lanes 0-3 defined. |
| `REPO_INVENTORY_PRESENT` | PARTIAL | Inventory model defined; full artifact inventory remains next Lane 2 execution. |
| `APP_AH507_CLASSIFIED_AUDIT_ONLY_OR_REPLACED_BY_REGISTER` | PASS_FOR_CONTRACT | Contract requires register readback before any app archive/delete. |
| `NO_BROAD_DELETE` | PASS | Broad delete forbidden. |
| `NO_FRESH_BRANCH_DELETE` | PASS | Fresh branches deferred unless lifecycle proof exists. |
| `NO_SECRET_OUTPUT` | PASS | No secrets, env values, raw links, private keys, or tokens included. |
| `REGISTER_AND_INDEX_PATCH_PRESENT_WHEN_SCOPE_REQUIRES` | PASS | Patch proposal artifact included. |
| `FINAL_FACT_ACTION_LEFT_ONLY` | PASS | Final output rule present. |

## Red-Team

- Wrong-task attack: PASS.
- Role-drift attack: PASS.
- Evidence fraud attack: PASS.
- Scope creep attack: PASS.
- User-action leak attack: PASS.
- Token-bloat attack: PASS.
- Stale-source attack: PASS.
- PR-tail attack: PASS.
- Secret leak attack: PASS.
- Replay attack: PASS with `safe_to_replay=false`.

## Residual

`REPO_LIFECYCLE_INVENTORY_REQUIRED` remains for the future full repository artifact inventory. It is not a blocker for installing this post-PR149 control contract.
