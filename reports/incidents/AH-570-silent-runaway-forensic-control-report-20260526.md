---
artifact_id: AH-570-silent-runaway-forensic-control-report-20260526
artifact_type: forensic-incident-report
owner_role: T1_CONTROL_REPAIR / REGISTRAR / VERIFIER
source_task: AH-570
run_id: P0-AGENTHUB-SILENT-RUNAWAY-FORENSIC-CONTROL-RESTORE-20260525
created_at: 2026-05-26
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# AH-570 Silent Runaway Forensic Control Report

## Verdict

This is an AgentHub control-plane incident, not a product implementation task. Product and runtime surfaces were out of scope for this report.

## Run Inventory Summary

- Active registered AgentHub/Codex processes found by MCP inventory: none.
- Dry-run reap planned actions: none.
- Unknown or unregistered processes were not touched.

## Controls Verified

- MCP-first AgentHub route was available.
- Ownership bind for AH-570 passed.
- Contract includes direct-route bypass blocking, duplicate-run policy, worker lease policy, terminal non-success states, and no self-repair loops.
- Cost/resource controller is enabled with hard stops, bounded retry, compact handoff, and no full transcript handoff.

## Control Defect

Owner danger/stop/no-code language was classified as queue work instead of a hard interrupt. This means the communication interrupt hook is not proven as installed at the enforcement point.

## Stopped Or Quarantined

No registered active runaway sessions were present during this validation window, so no session stop was executed. No safe registrar or verifier route was cancelled.

## Forbidden Scope Check

No BMC, n8n, Appsmith, Stroyremont, Dolibarr, Docker, proxy, DB, firewall, PM2, product repository, or runtime service mutation was performed by this incident contract.

## Residual Blocker

T0_HOOK_INSTALL_PATH_REQUIRED: the owner-interrupt pre-tool hook needs an enforcement install path or approved control-plane patch route. T0 must not install it through direct shell/code/runtime edits.
