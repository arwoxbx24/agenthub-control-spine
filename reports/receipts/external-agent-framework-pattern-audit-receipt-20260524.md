---
artifact_id: external-agent-framework-pattern-audit-receipt-20260524
artifact_type: research-receipt
owner_role: T0 Control Plane
source_task: AH-527
run_id: RUN-agenthub-external-repo-pattern-audit-20260524
created_at: 2026-05-24
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# External Agent Framework Pattern Audit Receipt - 2026-05-24

## Identity

| Field | Value |
|---|---|
| task_id | `AH-527` |
| RUN_ID | `RUN-agenthub-external-repo-pattern-audit-20260524` |
| worker_id | `T1-external-repo-pattern-audit-20260524` |
| repository | `arwoxbx24/agenthub-control-spine` |
| branch | `agenthub/external-repo-pattern-audit-20260524` |
| report | `reports/research/external-agent-framework-pattern-audit-20260524.md` |
| receipt | `reports/receipts/external-agent-framework-pattern-audit-receipt-20260524.md` |

## Prompt Quality Gate

Score: 88/100.

Result: PASS before T1 research execution.

Basis: clear research-only scope, explicit negative matches, exact source set,
no-install/no-runtime constraints, source questions, report requirements,
validation gates, and typed blockers.

## AgentHub Receipts

| Action | Status | Receipt hash |
|---|---|---|
| create | PASS | `49d3dcc947cf9c8f9c15757eeb7e1b0c51bef7257c438eab9b765072898da93a` |
| dispatch | PASS | `9379e9a55e505c4303ac81fa5f400fe0b64bcf232d908c22807d5d2dd4624774` |
| execute | PASS | `58f798b374e3c140c26767851301631e002c77908eba60efea41ca7896494e87` |

## Source Readback

| Source | Readback |
|---|---|
| `anthropics/knowledge-work-plugins` | public repo, default branch `main`, Apache-2.0, README and plugin examples read through GitHub API |
| `microsoft/AI-Engineering-Coach` | public repo, default branch `main`, MIT, README/docs/package/rule examples read through GitHub API |

## Validation

| Gate | Result |
|---|---|
| Duplicate YouTrack check | PASS: no matching task found before creating `AH-527` |
| YouTrack task anchor | PASS: `AH-527` |
| Runtime mutation | PASS: none |
| External code execution | PASS: none |
| Install/import/vendor | PASS: none |
| License check | PASS: Apache-2.0 and MIT identified |
| No raw transcripts/secrets/env dumps | PASS |
| Technical artifact language | PASS: English |
| User-facing output language | PASS: Russian final only |
| Recommendation | PASS: pattern adaptation only |

## Final Recommendation

Adopt patterns only.

Do not integrate either repository as a runtime dependency. Use Anthropic's
plugin layout as a pattern for AgentHub skill packs and use Microsoft's
observer/eval taxonomy as a pattern for AgentHub prompt evaluation and
Registrar hygiene.

## Done Gate

`RESEARCH_DONE_ALLOWED`: report exists, receipt exists, task anchor exists,
both repositories were evaluated, license/security/privacy notes are included,
and no runtime mutation occurred.

