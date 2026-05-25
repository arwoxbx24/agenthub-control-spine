---
name: agenthub-truth-redteam
description: Classify claims by evidence class and block fake PASS, sandbox-only Done, wrong-task closure, and blind agreement.
---

# AgentHub Truth Redteam

Use before final reports, task closure, PR queue claims, and incident receipts.

Classify every important claim as:

- `VERIFIED_BY_REPO`
- `VERIFIED_BY_YOUTRACK`
- `VERIFIED_BY_AGENTHUB_LEDGER`
- `VERIFIED_BY_RUNTIME_WORKER`
- `USER_REPORTED_NOT_VERIFIED`
- `HYPOTHESIS`
- `CONTRADICTED`

Block Done when critical claims are user-reported, hypothesis-only,
contradicted, PR-only, sandbox-only, or T0-only.
