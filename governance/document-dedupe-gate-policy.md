---
artifact_id: document-dedupe-gate-policy
artifact_type: governance-policy
owner_role: Registrar / Verifier
source_task: AGENTHUB_DOCUMENT_DEDUPE_GATE_REPAIR_PROMPT_20260607
run_id: RUN-P1-DOCUMENT-DEDUPE-GATE-20260607
created_at: 2026-06-07
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Document Dedupe Gate Policy

## Purpose

The document dedupe gate prevents AgentHub control-spine artifacts from
silently becoming duplicate active instructions, duplicate reports, duplicate
receipts, duplicate prompts, or duplicate PR/task evidence tails.

This policy governs repository artifacts only. It is not runtime repair,
server repair, Docker/DB/proxy/firewall work, product implementation, or
authority to delete historical evidence.

## Rules

- No automatic deletion is allowed.
- Registrar owns lifecycle decisions for duplicate, near-duplicate, stale,
  superseded, quarantine, and consumed prompt artifacts.
- Exact duplicate active artifacts must be blocked unless the older artifact is
  explicitly marked `superseded`, `quarantine`, `consumed_prompt`, or
  `audit_only` with `default_load=false`.
- `reports/`, `reports/receipts/`, `reports/audits/`, incident reports,
  handoffs, prompts, and generated status notes default to `default_load=false`
  unless `ARTIFACT_REGISTER.md` explicitly says otherwise.
- A prompt is safe to replay only when `ARTIFACT_REGISTER.md` says
  `safe_to_replay=true` and an active policy names the replay scope.
- Duplicate documents become Registrar lifecycle work: quarantine, supersede,
  consume, or preserve as audit-only evidence.
- Content duplicate detection is a gate and finding system, not deletion
  authority.

## Required Dedupe Signals

The gate must check:

- exact duplicate paths in `INDEX.md`;
- exact duplicate paths in `ARTIFACT_REGISTER.md`;
- duplicate `artifact_id` values across registered files;
- duplicate normalized filename families for active/current artifacts;
- duplicate `source_task` plus `scope_signature` for active/control artifacts;
- duplicate normalized content digests;
- near-duplicate title/metadata/first-heading signatures;
- lifecycle replay risk for `audit_only`, `consumed_prompt`, `superseded`, and
  `quarantine` artifacts used as active instructions.

## Finding Severity

- `FAIL`: active/current duplicate instruction or control risk.
- `WARN`: historical, audit-only, or operational receipt duplicate that is
  preserved with `default_load=false` and `safe_to_replay=false`.
- `PASS`: no duplicate risk found, or duplicate is explicitly superseded,
  quarantined, consumed, or audit-only.

## Done Gate

`DOCUMENT_DEDUPE_GATE_MISSING` can close only when the policy, validator,
fixtures, validation report, receipt, `INDEX.md`, and `ARTIFACT_REGISTER.md`
are present and validation passes.
