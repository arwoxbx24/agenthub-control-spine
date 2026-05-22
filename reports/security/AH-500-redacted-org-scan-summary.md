---
artifact_id: AH-500-redacted-org-scan-summary
artifact_type: redacted-security-audit-summary
owner_role: Security Worker
source_task: AH-500
created_at: 2026-05-22
supersedes: none
status: active
---

# AH-500 Redacted Organization Secret Scan Summary

## Scope

- Organization: `arwoxbx24`
- Repositories inventoried: 25
- Personal owner `arwoxb24`: out of scope and not used as canonical
- Scanner: `gitleaks 8.21.2`
- Mode: full local git history scan where clone completed
- Disclosure rule: no secret values stored in this report

## Inventory Summary

- Non-archived repositories visible: 25
- Repositories with admin permission: 25
- Public repositories: 3
- Private repositories: 22
- GitHub org plan observed: `free`
- Native defaults observed: secret scanning for new repositories disabled; push protection for new repositories disabled
- Organization secret-scanning alert API open count observed: 0

## Redacted Scan Results

| Repository | Status | Finding Count | Rule Summary |
|---|---:|---:|---|
| `arwoxbx24/.github` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/codex-state` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/claude-state` | REVIEW_REQUIRED | 4 | generic-api-key |
| `arwoxbx24/claude-projects` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/claude-profile-acc1` | REVIEW_REQUIRED | 1581 | curl-auth-header, curl-auth-user, generic-api-key, grafana-service-account-token, jwt |
| `arwoxbx24/claude-profile-acc2` | REVIEW_REQUIRED | 126 | generic-api-key, jwt |
| `arwoxbx24/claude-shared` | REVIEW_REQUIRED | 3 | curl-auth-header, generic-api-key |
| `arwoxbx24/browser-logger-extension` | REVIEW_REQUIRED | 1 | private-key |
| `arwoxbx24/stroyremont` | REVIEW_REQUIRED | 384 | generic-api-key |
| `arwoxbx24/whisper-voice` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/telegram-ai-bot` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/bitrix-production-calendar` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/yubikey-v1` | REVIEW_REQUIRED | 1 | generic-api-key |
| `arwoxbx24/timeweb` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/scripts_others` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/kpd-proxy` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/photo_downloader_dist` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/support-mvp-landing` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/win10-assistant-setup` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/agramak` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/okna-plus` | REVIEW_REQUIRED | 4 | gcp-api-key, generic-api-key |
| `arwoxbx24/asense-store` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/yacht-rental` | PASS_NO_FINDINGS | 0 | none |
| `arwoxbx24/client-video-transcription` | REVIEW_REQUIRED | 6 | generic-api-key, stripe-access-token |
| `arwoxbx24/agenthub-control-spine` | PASS_NO_FINDINGS | 0 | none |

## Blockers

- `BLOCKER_CONFIRMED_SECRET_ROTATION_REQUIRED`: redacted candidate findings exist in 9 repositories and require service-owner review. Confirmed active credentials must be rotated or revoked before cleanup closure.
- `BLOCKER_GITHUB_SECRET_PROTECTION_UNAVAILABLE`: organization defaults show native secret scanning and push protection disabled for new repositories on the observed plan.
- `BLOCKER_RULESET_PERMISSION_MISSING`: repository rulesets for private repositories returned plan/permission unavailability in readback.

## Notes

This report intentionally omits matched values, raw scanner JSON, raw logs, and secret material. Redacted local scanner artifacts were used only to produce counts and rule summaries.
