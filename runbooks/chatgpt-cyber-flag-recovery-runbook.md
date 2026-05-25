---
artifact_id: chatgpt-cyber-flag-recovery-runbook
artifact_type: runbook
owner_role: T1 Architecture Broker
source_task: AH-541
run_id: RUN-agenthub-openai-cyber-flag-safe-router-20260525
created_at: 2026-05-25
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# ChatGPT Cyber-Flag Recovery Runbook

Use this runbook when a user or worker reports a ChatGPT/Codex notice such as
possible cybersecurity risk or when agents stop on cyber-adjacent wording.

## Recovery Steps

1. Stop replaying the flagged noisy text.
2. Preserve the user goal as a clean authorized-scope summary.
3. Split the request into DevOps, defensive security, control-plane, and
   prohibited/owner-only risk parts.
4. Route AgentHub control-plane work through
   `AGENTHUB_CONTROL_PLANE`; it continues even when live runtime adapters are
   unavailable.
5. Route owned infrastructure incidents through `AUTHORIZED_ADMIN_DEVOPS` only
   with exact owned scope, rollback, no-secret policy, and validation.
6. Route owned defensive hardening through `DEFENSIVE_SECURITY_AUTHORIZED`.
7. Block credential theft, malicious code, stealth, persistence, public
   scanning, data exfiltration, or destructive unbacked action as
   `PROHIBITED_OR_OWNER_ONLY_RISK`.
8. Use Trusted Access or Support for legitimate high-risk defensive cyber work
   that exceeds normal allowed capabilities. Do not describe this as bypass.

## Clean Summary Template

```text
The user reports a platform cyber-safety warning during authorized AgentHub
work. The intended work is <availability|maintenance|hardening|validation|
control-plane repair> for owned/internal scope <exact target>. No exploitation,
credential collection, data exfiltration, stealth, persistence, malware, public
target testing, policy bypass, or secret exposure is requested. Allowed actions
are <bounded list>. Forbidden actions are <bounded list>. Evidence required is
<validation and receipt>. Final gate is <Done gate or exact typed blocker>.
```

## Stop Conditions

Stop with an exact typed blocker when:

- the target is not owned or authorized;
- the request requires prohibited behavior;
- high-risk defensive cyber work requires Trusted Access;
- runtime mutation is required but the live adapter is missing;
- destructive action lacks explicit owner authority, backup, rollback, and
  validation.
