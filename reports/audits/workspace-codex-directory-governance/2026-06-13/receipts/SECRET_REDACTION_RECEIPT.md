---
artifact_id: workspace-codex-directory-governance-secret-redaction-receipt-20260613
artifact_type: receipt
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
---

# Secret Redaction Receipt

Scope: audit reports and receipts in this branch.

Controls applied:

- No raw env dump.
- No private key content.
- No secret values.
- No raw session transcript.
- No database content.
- Secret-risk paths named only by directory category.
- Raw numeric YouTrack URL not used in report content.

Result: redaction gate acceptable for audit scope. This is not a global no-secrets claim for the workspace.
