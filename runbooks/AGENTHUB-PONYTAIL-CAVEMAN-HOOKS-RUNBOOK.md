---
artifact_id: AGENTHUB-PONYTAIL-CAVEMAN-HOOKS-RUNBOOK
lifecycle: active_control
default_load: false
safe_to_replay: false
source_task: AH-813
run_id: RUN-AGENTHUB-EFFICIENCY-HOOKS-20260616
---

# AgentHub Ponytail/Caveman Hooks Runbook

## Verify

1. Confirm task binding and AgentHub RUN receipt.
2. Confirm Ponytail and Caveman plugin manifests are present.
3. Confirm Codex hooks are enabled and `.codex/hooks.json` parses as JSON.
4. Start a fresh supported Codex session from the repository root.
5. Expect the startup banner or prompt hook line:
   `[AH-HOOKS] ponytail=full caveman=full safety=on task_first=on`.
6. Run one overengineering trap and verify the response chooses stdlib/native or
   the smallest correct diff.
7. Run one verbosity trap and verify filler is removed without changing exact
   technical strings.
8. Run one destructive/security prompt and verify warning text stays precise.
9. Record receipt metadata and no-secret scan result.

## Rollback

Remove only the AH-813 additions:

- `.codex/hooks.json` if no other task has taken ownership of it.
- `governance/AGENTHUB-PONYTAIL-CAVEMAN-HOOK-POLICY.md`.
- `runbooks/AGENTHUB-PONYTAIL-CAVEMAN-HOOKS-RUNBOOK.md`.
- `schemas/agenthub-efficiency-hook-receipt.schema.json`.
- `reports/receipts/RUN-AGENTHUB-EFFICIENCY-HOOKS-20260616-ponytail-caveman-hook-install-receipt.md`.
- AH-813 rows in `INDEX.md`, `ARTIFACT_REGISTER.md`, and `PR_QUEUE_REGISTER.md`.

Do not delete plugin cache, user auth, history, logs, or third-party plugin
internals.

## Troubleshooting

- `CODEX_HOOK_AUTOACTIVATION_UNCONFIRMED`: project hook trust or fresh-session
  proof is missing. Use the repo banner as fallback evidence, not Done.
- `HOST_HAS_NO_VISIBLE_STATUSLINE`: rely on SessionStart/UserPromptSubmit output
  and receipt.
- `NODE_NOT_AVAILABLE_TO_NONINTERACTIVE_HOOK`: current fallback does not require
  Node; plugin-owned hooks may still need Node.
- `PLUGIN_HOOKS_NOT_TRUSTED`: do not edit plugin internals. Use Codex hook trust
  UI/settings and re-run fresh-session proof.
