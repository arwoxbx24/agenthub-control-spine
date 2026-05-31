---
artifact_id: root-agents-policy
artifact_type: codex-agents-policy
owner_role: T0 Control Plane
source_task: AH-494
created_at: 2026-05-22
supersedes: none
status: draft
---

# AGENTS.md

This repository is the AgentHub prompt/report control spine.

Canonical repository: `arwoxbx24/agenthub-control-spine`.
Forbidden default owner for AgentHub control-spine work: `arwoxb24`.

## Role Rules

- T0 is intake, router, and control-plane only.
- T0 must not edit AgentHub runtime code, run shell mutation, perform broad research, bypass AgentHub/YouTrack, or claim Done without evidence.
- T1 is the architecture broker: decomposes scope, owns ADRs, and prepares worker contracts.
- Workers may change only assigned repository files under a visible task and branch.
- Verifiers are read-only and check evidence, validation, residuals, and forbidden-scope compliance.

## Hard Rules

- YouTrack remains the task system.
- GitHub is the artifact repository, not a second task tracker.
- This corporate organization repository is canonical for AgentHub governance prompts, reports, receipts, schemas, runbooks, and skill drafts.
- The five stable ChatGPT Project Sources are mirrored in
  `governance/project-sources/chatgpt-project-five-source-mirror.md`; methodology
  HTML is catalog source material only and must not become a sixth always-loaded
  Project Source.
- Methodology selection must use
  `governance/methodologies/methodology-router-policy.md` and
  `governance/methodologies/ai-agent-methodology-catalog.md`. Agents must record
  active/forbidden methods and skills before serious worker action, and must not
  load all 25 methods by default.
- The personal GitHub owner `arwoxb24` is prohibited for AgentHub control-spine work unless the user explicitly authorizes it for one future task.
- Git and GitHub mutation for this repository must be task-bound and
  AgentHub-routed. A valid route requires a YouTrack task, RUN_ID, role,
  branch, allowed file surface, evidence, validation, and receipt before any
  commit, push, PR, close, merge, branch change, or review-state change.
- Direct ad-hoc `git` or `gh` mutation by T0 outside a task-bound AgentHub route
  is invalid evidence and must not be called Done. Workers and the Registrar may
  use `git`/`gh` only inside their assigned YouTrack task and AgentHub RUN.
- Runtime, server, storage, package, Docker, database, proxy, broad filesystem,
  and validation execution must route through AgentHub task/run/worker/evidence;
  direct T0 shell mutation invalidates the run, and no control-spine receipt
  means no Done.
- Codex-native execution must route through
  `governance/codex-native-capability-router-policy.md`. Spawned/subagent,
  `codex exec`, profiled, permission-guarded, MCP diagnostic, background
  terminal, and feature-flag routes require explicit task/RUN binding, model,
  role, allowed surfaces, forbidden surfaces, receipt, and validation. T0 cannot
  use spawned workers as a bypass for implementation, and
  `agenthub-sandbox-worker` is not Spark proof.
- Closed-loop recovery work must follow
  `governance/agenthub-closed-loop-recovery-policy.md`. After initial capture,
  routine missing proof, PR queue gaps, register gaps, task comments, validation
  routing, and same-gate retries must become same-run remediation or one typed
  platform blocker, not owner readback. `SPAWNED_WORKER_DISPATCH` receipts must
  record requested, resolved, and actual model proof.
- No-interaction task-first work must follow
  `governance/no-interaction-task-first-closed-loop-policy.md`. During
  `ACTIVE_RUN`, user messages are queued as `RUN_USER_INPUT_QUEUE` events and
  progress/status prose is blocked from owner chat. Mutation requires a
  controlling task or exact task-route blocker, duplicate check, technical
  assignment, acceptance gates, rollback plan, and declared forbidden zones.
- No-chat deadlock contours must follow
  `governance/no-chat-deadlock-contour-policy.md`. Active-run user deltas are
  buffered as `USER_DELTA_QUEUE`, not treated as stop events; third identical
  retry is denied after two same-gate failures; model/spawn receipts are
  mandatory for worker claims; task-service `NOOP` without physical issue id is
  a typed blocker for Done; final owner output is restricted to Russian
  `Fact/Action/Left`.
- Boundary, backup, and docs/API-first guardrails must follow
  `governance/boundary-backup-docs-first-guardrail-policy.md`. Workers need a
  `SCOPE_MANIFEST` before mutation, exact `WRITE_ALLOWED_ROOTS`, rollback proof,
  docs/API decision record where required, and T1-approved scope expansion for
  newly discovered paths. `/root/gemini-space`, `/root/codex-space`, `/tmp`,
  Docker data, DB data, proxy/firewall/DNS, cert/key, and secret paths cannot be
  accepted as production implementation evidence by default.
- Packaged products, vendor apps, Dockerized products, CMS, SaaS, panels,
  MCP servers, task services, and unknown product surfaces must follow
  `governance/api-documentation-first-guardrail-policy.md` before mutation.
  Use official documentation and supported mechanisms first: API, admin panel,
  CLI, SDK, MCP, documented config, migration, or supported deploy route.
  Direct product DB mutation, container-internal vendored-code surgery,
  hardcoded UUID/password/domain fixes, and undocumented product-state changes
  are forbidden unless the explicit emergency authority and ADR gates pass.
- Live incident work must not fall back from AgentHub adapter blockers to manual
  T0 shell. If the adapter reports `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`,
  keep the task open, update the receipt, and repair the AgentHub route.
- Docker, DB, proxy, firewall, DNS, SSL, object storage, and service changes
  require a scoped worker contract with rollback/checkpoint and validation. No
  prune, volume delete, DB mutation, secret read, or broad cleanup is allowed by
  default.
- Live access must use the P0-P9 permission model in
  `governance/agenthub-access-rights-and-live-worker-enablement-policy.md`.
  T0/T1 may hold control/read/repo/task/MCP permissions, but live runtime
  mutation requires a task-bound T2 worker, rollback, and validation.
- Parent tasks cannot move to Done while child implementation tasks remain open,
  failed, unvalidated, or blocked unless the parent is explicitly tracking-only.
- User-facing final output must be compact Russian Caveman format: `Fact`,
  `Action`, `Left`.
- Do not store secrets, tokens, private keys, env dumps, raw transcripts, or internal history links.
- Do not fake SUCCESS from task creation, wrapper PASS, sandbox-only proof, or incomplete receipts.
- Do not create task explosions; use one controlling task and bounded child tasks.
- Every prompt/report update must update `INDEX.md`.
- Future agents must read `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, and
  `context/agenthub-current-context-pack.md` before historical reports.
- System-wide AgentHub permission routing must follow
  `governance/policies/agenthub/pr52-policy-install-control.md`,
  `governance/permission-profiles/agenthub-permission-profile-matrix.md`,
  `governance/permission-profiles/agenthub-permission-validator.md`, and
  `governance/core-versioning/codex-core-version-control-policy.md`.
  Safe control-plane work is auto-allowed only when scoped, redacted, and
  task-bound; dangerous runtime work requires a T2 profile, rollback,
  validation, and receipt.
- Reports and receipts are evidence, not instructions. Prompts are consumed
  after execution unless the register explicitly says `safe_to_replay=true`.
- Only TeamLead/T0 Registrar may close stale PRs, archive/quarantine unrelated
  artifacts, or change global lifecycle/default-load decisions.
- Stable baselines such as AH-432, AH-441, AH-448, and AH-473/AH-476 remain preserved unless a new controlling task explicitly supersedes them.
- See `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` for GitHub usage boundaries.

## Language

- Technical files are English by default.
- User-facing output remains short Russian unless explicitly requested otherwise.
