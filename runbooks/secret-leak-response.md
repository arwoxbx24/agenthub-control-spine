---
artifact_id: secret-leak-response-runbook
artifact_type: runbook
owner_role: Security Worker
source_task: AH-500
created_at: 2026-05-22
supersedes: none
status: active
---

# Secret Leak Response Runbook

## First Rule

Do not copy, paste, screenshot, store, or discuss the secret value.

## Response Steps

1. Stop propagation.
   - Block commit, push, merge, or publication if the gate can enforce it.
   - Preserve only redacted metadata.

2. Classify the finding.
   - Repository and branch/ref.
   - Commit SHA.
   - File path.
   - Detector/rule id.
   - Secret type.
   - Confidence.
   - Redacted fingerprint.

3. Create or link one bounded incident task.
   - Do not create one task per log line or per finding.
   - Group related findings by repository or source family.

4. Rotate or revoke first.
   - Assume exposed real credentials are compromised.
   - Service owner must rotate or revoke confirmed active credentials before cleanup is called complete.

5. Decide whether history cleanup is needed.
   - History rewrite is a separate, explicitly authorized incident task.
   - Do not run BFG, filter-repo, force-push, prune, reset, or destructive cleanup inside the detection task.

6. Close only with evidence.
   - Redacted scan receipt.
   - Rotation/revocation evidence for confirmed active credentials.
   - Follow-up scan result.
   - No secret values in comments, artifacts, or chat.

## Redacted Finding Format

```json
{
  "repo": "owner/name",
  "ref": "main",
  "commit": "short-or-full-sha",
  "path": "relative/path",
  "detector": "rule-id",
  "secret_type": "provider-or-category",
  "confidence": "low|medium|high",
  "redacted_fingerprint": "sha256-prefix-or-scanner-fingerprint",
  "remediation_status": "review_required|rotated|revoked|false_positive_approved"
}
```

## Done Gate

Done is blocked until redacted evidence exists and confirmed active credentials have service-owner rotation or revocation evidence.
