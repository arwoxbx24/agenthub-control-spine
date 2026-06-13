---
artifact_id: linux-final-truth-gate-policy
artifact_type: governance_policy
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-790
run_id: linux-final-truth-gate-20260613
created_at: 2026-06-13
lifecycle_status: active_control
default_load: false
safe_to_replay: false
extends: governance/permanent-user-outcome-validation-policy.md
---

# Linux Final Truth Gate Policy

## Purpose

This policy extends AH-788 permanent user-outcome validation governance. It adds one Linux-visible final truth rule: a Codex/AgentHub final claim is allowed only when the executing Linux agent can read an approved evidence artifact from its own repository, runtime, MCP, YouTrack, or browser-worker context.

ChatGPT browser conversation, owner pressure, prior draft response, or agent self-report is not completion evidence.

## Linux-Visible Truth Rule

Every final answer must be generated from a `Final Claim Ledger`. The final text may include only ledger claims with:

- `evidence_readback_status: PASS`
- `verdict: GREEN`
- `allowed_in_final: true`

Claims with `PARTIAL`, `UNKNOWN`, `RED`, `FAIL`, missing evidence, or excluded scope must not be converted into Done wording.

## Allowed Evidence Classes

- Repository diff or file readback from `main` after merge.
- Validator output artifact with path and digest/hash where available.
- YouTrack readback containing canonical Done markers.
- AgentHub/MCP receipt artifact.
- Approved browser-worker receipt with user story, URL or route, steps, expected result, actual result, and screenshot/trace path when user-visible behavior is in scope.
- Service/API test artifact when non-UI service scope is explicitly declared.
- Security/redaction proof for published artifacts.

## Disallowed Evidence Classes

- Agent self-report without artifact.
- Owner or ChatGPT chat text as proof.
- Previous draft response.
- PR title/body alone.
- Local-only curl/process/socket status for user-visible features.
- Screenshot without mapped user story and route.
- Old report not marked `current_context`, `active_source`, or `active_policy`.
- Unknown or partial claim renamed as Done.

## Browser Invisibility Rule

The Linux agent does not see the ChatGPT browser context. It must not infer browser or user success from chat. If browser/user-visible outcome is required, it must use an approved browser-worker route that writes a machine-readable receipt. Missing browser-worker route is a same-RUN PackFix, not owner-proof request and not Done.

## Completion Rule

Stage Done is last. It is allowed only when the Done Evidence Tuple exists and passes parser/readback:

```text
Implementation evidence: <installed control/diff/artifact path>
Validation evidence: <validator/browser/API/readback proof path>
Receipt: <receipt path or route receipt>
Blocker: none
```

Blocked, pending, remaining, later, missing proof, browser missing, route missing, user needs to verify, draft PR state, or unresolved child text blocks Done.

## Compatibility With AH-788

This policy does not replace AH-788 controls. It narrows final-answer generation to Linux-visible evidence and uses AH-788 browser-first validation matrix when user-visible outcomes are in scope.

## Forbidden Scope

This policy does not authorize production runtime, Docker, DB, proxy/NPM, firewall, PM2, Grafana, DNS, SSL, Railway, object storage, client product code, secrets, raw env/log dumps, broad cleanup, delete, prune, reset, or unmanaged temporary folders.
