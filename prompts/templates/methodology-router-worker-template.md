---
artifact_id: methodology-router-worker-template
artifact_type: worker_prompt_template
owner_role: T1 Architect / T2 Worker
source_task: AH-595
run_id: RUN-P0-PROJECT-METHODOLOGY-MIRROR-20260528
created_at: 2026-05-28
lifecycle_status: active_template
default_load: false
safe_to_replay: false
---

# Methodology Router Worker Template

Use this compact template instead of pasting the full methodology catalog.

```text
RUN_ID: <run id>
task_id: <YouTrack id>
role: <T1_ARCHITECT|T2_REPO_WORKER|VERIFIER|REGISTRAR>
scope_signature: <normalized scope>

Catalog reference:
- path: governance/methodologies/ai-agent-methodology-catalog.md
- source_read_sha256: f93f5d383cc8a5865bfceccda436f3104e18061b2b5eca014cff4906cfe35eb9

Methodology selection:
- TASK_CLASS: <MICRO|STANDARD|INCIDENT|FULL|CODE_IMPLEMENTATION|QA_VALIDATION|REGISTRAR>
- ACTIVE_METHODS: <numbers only>
- FORBIDDEN_METHODS: <numbers intentionally not loaded>
- ACTIVE_SKILLS: <selected skills>
- FORBIDDEN_SKILLS: <forbidden skills>
- NEGATIVE_MATCHES: <what this task is not>
- EVIDENCE_TARGETS: <repo receipt/report/register paths>

Rules:
- Do not load all 25 methods unless explicitly justified by the profile.
- T0 never writes code or runs shell/runtime commands.
- Code/config/YAML/shell work requires a Codex-capable model route or same-RUN fallback evidence.
- Report-only, PR-only, sandbox-only, and GitHub-only Done are invalid.
- Store evidence in control-spine and update registers before Done.
```

