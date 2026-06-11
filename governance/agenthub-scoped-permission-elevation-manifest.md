---
artifact_id: agenthub-scoped-permission-elevation-manifest-20260611
artifact_type: governance_manifest
source_task: AH-743
run_id: RUN-AGENTHUB-YOUTRACK-GITHUB-BOARD-FINAL-CLOSURE-20260611
status: active
---

# AgentHub Scoped Permission Elevation Manifest

## Purpose

AgentHub permission elevation is lane-scoped. A worker receives only the authority required for the task and must record lane, scope, rollback requirement, validation evidence, and blocker state.

## Lanes

| Lane | Authority | Allowed work | Required gate |
|---|---|---|---|
| 0 | Read-only audit | inspect issues, repo metadata, docs, receipts | no mutation |
| 1 | Task mutation | YouTrack card, comments, stage movement | task id, duplicate check, readback |
| 2 | GitHub artifact mutation | repo artifacts, registers, receipts, PR metadata | branch, commit, PR evidence |
| 3 | CI/PR metadata repair | branch/PR/check metadata repair | scoped PR, no production runtime |
| 4 | Microservice diagnostic | read-only runtime diagnostic | no DB/proxy/secret mutation |
| 5 | Runtime repair | scoped runtime repair with rollback | rollback proof and validation |
| 6 | Destructive action | replacement, deletion, irreversible action | explicit owner approval or backup/replacement proof |

## Default For AH-743

AH-743 uses Lane 1 for YouTrack task mutation and Lane 2 for GitHub control-spine artifact mutation. It does not grant DB, Docker, proxy, firewall, DNS, SSL, port, secret, or destructive authority.

## Closure Rule

The receipt must list exercised lanes. Final Done is blocked if a mutation was performed outside its declared lane or if a required lane lacks readback evidence.
