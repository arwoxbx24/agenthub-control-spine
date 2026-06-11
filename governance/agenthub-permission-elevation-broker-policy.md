---
artifact_id: agenthub-permission-elevation-broker-policy-20260611
artifact_type: governance_policy
source_task: AH-745
run_id: RUN-AGENTHUB-BLOCKER-INVERSION-SCOPED-SELF-HEALING-20260611
status: active
---

# AgentHub Permission Elevation Broker Policy

## Purpose

Permission elevation is lane-scoped, single-purpose, receipt-backed, and never global. The broker grants only the operation required to repair a blocker or execute a scoped worker action.

## Lanes

- Lane 0: chat/output only.
- Lane 1: control-spine artifacts.
- Lane 2: YouTrack task lifecycle.
- Lane 3: GitHub control-spine branch/commit/PR/register/receipt.
- Lane 4: MCP tool discovery, authorization, tool call, route repair.
- Lane 5: live service read/repair via scoped worker with rollback/checkpoint.
- Lane 6: destructive/high-risk action only with replacement, backup, or explicit owner confirmation plus receipt.

## Required Receipt Fields

Every elevation records task id, run id, requester role, granted role, lane, tool name, exact operation, allowed scope, forbidden scope, duration/single-use flag, rollback/checkpoint requirement, validation requirement, receipt path, secret redaction proof, and reason it is routine self-healing rather than owner-only.

## Denied Grants

No elevation may grant global shell, global Docker, global DB, global firewall, global secret, or global network access.
