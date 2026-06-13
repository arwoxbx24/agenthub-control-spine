---
artifact_id: client-delivery-claim-ledger-template
artifact_type: prompt_template
source_task: AH-788
run_id: permanent-user-outcome-validation-governance-20260613
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Client Delivery Claim Ledger Template

Use before any client-facing full-delivery statement.

| Claim | Audience | Required evidence | Actual evidence | Verdict | Include in client text |
|---|---|---|---|---|---|
| <claim> | client/owner/internal | browser/API/service/static/security | <path/receipt> | GREEN/PARTIAL/UNKNOWN/RED/EXCLUDED | yes/no |

Rules:

- `GREEN` requires direct evidence.
- `PARTIAL`, `UNKNOWN`, and `RED` cannot appear in full delivery wording.
- Unsupported claims are removed, not beautified.
- Prior chat drafts, PRs, screenshots without user story, and local-only status are not enough.
- Browser/user-story proof is mandatory for user-visible claims.
