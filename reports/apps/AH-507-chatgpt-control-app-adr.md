---
artifact_id: AH-507-chatgpt-control-app-adr
artifact_type: architecture-decision-record
owner_role: T0 Control Plane
source_task: AH-507
run_id: AH-CHATGPT-APP-BOOTSTRAP-20260523
status: active
---

# ADR: ChatGPT Control App for AgentHub

## Context

ChatGPT needs a dedicated control connector for AgentHub/GitHub/YouTrack work.
The ordinary GitHub connector is useful for repository access, but it is not the
execution layer or acceptance proof for controlled AgentHub operations.

## Options

### A. Conservative

Expose read-only tools and artifact creation requests. AgentHub/Codex performs
all writes. This has the lowest risk but does not close the write-proof
requirement.

### B. Balanced

Expose controlled GitHub write tools with server-side validation, ChatGPT
confirmation, branch/PR writes, redacted audit logs, and no delete capability.
YouTrack remains the task system. AgentHub/Codex remains the execution
environment. This closes the useful MVP without turning ChatGPT into an
unbounded runtime.

### C. Progressive

Expose AgentHub/Codex/YouTrack/GitHub as one orchestrated control plane with
stronger auth, policy gates, queueing, and validation bundles. This is the target
architecture after the MVP has proven endpoint, credential, and audit controls.

## Decision

Use Option B for MVP. Prepare Option C only after a real ChatGPT Developer Mode
connector can call `health_check`, `list_allowed_repositories`, and
`github_write_proof`.

## Consequences

- Public HTTPS hosting and server-side credential storage are required before
  final PASS.
- Repository deletion is intentionally absent.
- Merge remains blocked until approval/status-check gates are wired.
- The app skeleton is safe to review without secrets.
