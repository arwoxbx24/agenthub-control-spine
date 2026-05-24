---
artifact_id: runbook-agent-shortlink-intake-and-report-placement
artifact_type: runbook
owner_role: T0 Registrar
source_task: AH-529
run_id: RUN-control-spine-agent-output-link-intake-repair-20260524
created_at: 2026-05-24
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Agent Short-Link Intake and Report Placement Runbook

Use this runbook when an AgentHub/Codex task touches protected links,
download/read links, report placement, PR queue state, or final user output.

## Report Placement

1. Write reports as files under the canonical repository, normally
   `reports/`, `reports/incidents/`, `reports/research/`, or
   `reports/receipts/`.
2. Do not use GitHub Issues for reports or task tracking.
3. Add every report and receipt to `INDEX.md`.
4. Add lifecycle metadata to `ARTIFACT_REGISTER.md`.
5. Reports must usually be `audit_only`, `default_load=false`,
   `safe_to_replay=false`.
6. Receipts must usually be `operational_receipt` or `historical_receipt`,
   `default_load=false`, `safe_to_replay=false`.
7. Add or update `PR_QUEUE_REGISTER.md` for any open or newly merged PR.

## Short-Link Resolver Spec

Input: short URL or Google Drive URL.

1. Run link intake once with intended mode: `read`, `download`, or `verify`.
2. If local storage returns `NOT_FOUND`, timeout, or a stale object, run live
   short-link resolution once.
3. If live route resolves and reads/downloads, classify local storage as
   `STALE_LOCAL_LINK_INDEX` and use the live artifact for the current task.
4. Write a receipt with:
   - `source_url` redacted or canonicalized when needed;
   - `resolved_url_type`;
   - `resolver_mode`;
   - `artifact_path_or_ref`;
   - `artifact_hash` when available;
   - `stale_index=true|false`;
   - `blocker` if unresolved.
5. Do not tell the user that a link is broken until both local and live routes
   have been checked once.
6. Do not repeat link intake/read/download loops. Same resolver gate twice
   requires architecture repair or a typed blocker.

## Final Output Discipline

For caveman user-facing closure:

```text
Fact: <one verified result>
Action: <PR/task/receipt/path or exact action>
Left: <none or exact blocker>
```

No raw logs, internal trace details, raw transcript fragments, internal links,
environment dumps, secrets, or long status blocks belong in chat.

## Validation Checklist

- `git diff --check`
- redacted secret scan
- unsafe marker scan for raw transcript, internal links, env dumps, private
  keys, tokens, and credentials
- `INDEX.md` coverage
- `ARTIFACT_REGISTER.md` coverage
- `PR_QUEUE_REGISTER.md` coverage when PR state changes
- no forbidden runtime/client/product surface diff
- task readback when YouTrack state is changed
