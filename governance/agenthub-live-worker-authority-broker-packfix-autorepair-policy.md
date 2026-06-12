---
artifact_id: agenthub-live-worker-authority-broker-packfix-autorepair-policy
artifact_type: governance_policy
owner_role: T1 Architecture Broker / T0 Registrar / T2 Worker Authority Broker / Verifier
source_task: AH-748 / PR-159 follow-up
run_id: RUN-AGENTHUB-LIVE-WORKER-AUTHORITY-BROKER-PACKFIX-AUTOREPAIR-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Live Worker Authority Broker + PackFix Autorepair Policy

## Mission

Replace routine terminal blockers with scoped PackFix autorepair through an Authority Broker. This policy does not remove safety controls. It turns ordinary missing route, worker, task movement, validator, receipt, and scoped recovery defects into lane-bound repair work with receipts and validation.

## Core Rule

A routine missing route is not a final blocker. AgentHub must classify the capability gap, create or update one PackFix under the controlling task/RUN, obtain the smallest scoped lane grant, execute or validate through the scoped worker, write evidence, move YouTrack only after evidence, and continue until Done or a real owner-only gate.

## Roles

- T0 Control Plane: classify, bind task/RUN, create PackFix, request Authority Broker, update control-spine artifacts when scoped, verify receipts, move YouTrack through approved tools. T0 must not mutate runtime directly.
- T1 Architecture Broker: choose lane, worker profile, rollback, validation gates, and destructive proof requirements.
- Authority Broker: convert routine blockers into scoped grants or typed owner-only gates; prevent repeated blocker loops; issue short-lived receipts.
- T2 Scoped Worker: read first, checkpoint before mutation, touch only allowed surfaces, validate outcome, write receipt.
- Verifier: read-only rejection of fake green and weak evidence.
- Registrar: artifact lifecycle, index/register/PR queue, stale prompt quarantine, prompt-dump denial.

## Permission Lanes

- Lane 0: chat, prompt, reports, receipts, schemas, validators, fixtures, control-spine artifacts. No runtime mutation.
- Lane 1: YouTrack task readback, duplicate check, updates, stage movement, comments, evidence fields, Done gate fields.
- Lane 2: GitHub control-spine branch, PR, register, receipt work. No personal repo by default.
- Lane 3: read-only runtime diagnostics by scoped worker: service status, process/container readback, filtered logs, ports, disk/memory, HTTP/API smoke, browser screenshot/DOM/console/network proof.
- Lane 4: scoped runtime repair after checkpoint: one named service/container restart, one documented route/proxy/app config repair, one named reload, validation after repair.
- Lane 5: one named microservice/app source or config repair with validation; deploy/restart only with Lane 4 grant.
- Lane 6: destructive/data/global surface. Owner-only unless exact approval, validated replacement, tested backup, disposable lifecycle evidence, or task emergency authority exists.

## Blocker Inversion

These blocker families are routine by default and must become PackFix + Authority Broker work: live worker authority missing, contract-only runtime dispatch blocked, no approved worker route after repair, T0 direct runtime mutation defect when T2 route can exist, T0 direct authorship defect when repo write route exists, model fallback receipt missing, duplicate progress output blocked, public route failure, UI/backend/browser proof missing, task-service readback missing, index/register/PR queue pending, validator not run.

Terminal blockers are only: owner-only irreversible gate, missing account credential no agent can access, legal/payment gate, explicit destructive owner confirmation required, secret access not delegable, or unsafe scope conflict.

## Loop Rule

The same blocker signature may appear at most twice in one RUN. On second occurrence, stop status repetition, update one PackFix, invoke Authority Broker, and either repair route or end with one real owner-only gate. Third same-gate retry is forbidden.

## Evidence Requirements

Every repair must record task id, RUN_ID, lane id, authority grant receipt, worker role, allowed and forbidden surfaces, checkpoint/rollback proof, action evidence, validation evidence, YouTrack stage readback, final receipt, and residual blocker if any.

## Done Rule

Done requires one controlling task, no duplicate active task/PR/RUN for the same scope, routine blockers converted and resolved or owner-only escalated, required service/browser/API/task evidence, YouTrack Stage=Done with Done gate PASS, receipts, no active owner-only gate, and compact final output.

## Prompt Dump Ban

This policy must be installed and executed as controls. It must not be printed as a terminal or final result.
