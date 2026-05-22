---
artifact_id: root-security
artifact_type: security-policy
owner_role: Verifier
source_task: AH-494
created_at: 2026-05-22
supersedes: none
status: draft
---

# Security Policy

Do not commit:

- API keys, OAuth tokens, PATs, private keys, or passwords.
- `.env` files or env dumps.
- Raw terminal logs with secrets.
- Internal transcript/history URLs.
- Production runtime configs.

Before finalizing any report or prompt bundle, run a narrow secret/redaction scan and record the result in the receipt.

