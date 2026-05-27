---
artifact_id: secrets-manifest-redacted
artifact_type: redacted_registry
owner_role: Security Controller / Registrar
source_task: AH-590
run_id: RUN-P0-GLOBAL-AGENT-CONTROL-SECRETS-REPO-AUDIT-20260527
created_at: 2026-05-27
lifecycle_status: current_baseline
default_load: false
safe_to_replay: false
---

# Redacted Secrets Manifest

This file is a metadata registry only. It must never contain passwords, tokens, private keys, env dumps, raw provider responses, or transcript links.

| Secret id | Service | Provider | Handle name | Location class | Allowed roles | Allowed scopes | Owner gate | Rotation status | Last verified | Validation method | Redaction proof |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `npm-api-admin` | Nginx Proxy Manager API | NPM | `NPM_API_CREDENTIAL_HANDLE` | protected runtime secret root or provider-native secret store | T2_LIVE_WORKER, VERIFIER_READONLY metadata-only | scoped NPM API host/cert tasks | none when handle exists | unknown | null | metadata handle only | metadata_only |
| `timeweb-dns-api` | Timeweb DNS | Timeweb Cloud CLI/API | `TIMEWEB_DNS_HANDLE` | provider CLI profile or protected runtime secret root | T2_LIVE_WORKER, VERIFIER_READONLY metadata-only | scoped DNS record tasks | none when handle exists | unknown | null | metadata handle only | metadata_only |
| `komodo-admin-api` | Komodo Core | Komodo API/UI | `KOMODO_ADMIN_HANDLE` | protected runtime secret root | T2_LIVE_WORKER | scoped Komodo stack import tasks | owner_credential_required until handle is installed | unknown | null | missing handle receipt | metadata_only |
| `github-control-spine` | GitHub control-spine | GitHub App/CLI | `GITHUB_CONTROL_SPINE_HANDLE` | GitHub connector or protected CLI auth | REGISTRAR, VERIFIER_READONLY | control-spine repo PR/register tasks | none when connector is active | unknown | null | connector readback | metadata_only |
| `youtrack-ah` | YouTrack AH project | YouTrack connector | `YOUTRACK_AH_HANDLE` | YouTrack connector auth | T0_CONTROL, REGISTRAR, VERIFIER_READONLY | AH task readback/update | none when connector is active | unknown | null | connector readback | metadata_only |

Missing handles must return `SECRET_HANDLE_MISSING`; workers must not search arbitrary files for secret values.
