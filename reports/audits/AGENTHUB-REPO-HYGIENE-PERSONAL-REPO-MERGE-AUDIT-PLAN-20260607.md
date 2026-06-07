# AgentHub Repo Hygiene + Personal Repository Merge Audit Plan

Date: 2026-06-07
Repository: `arwoxbx24/agenthub-control-spine`
Artifact type: audit/architecture plan
Lifecycle: audit_only until Registrar promotes a specific implementation task
Default load: false
Safe to replay: false
Owner role: T1 Architect / Registrar / Verifier

## 1. Owner directive

All detailed planning, audit notes, correction architecture, and execution instructions for this topic must be recorded in the corporate repository, not expanded in owner chat.

Canonical repository:

- `arwoxbx24/agenthub-control-spine`

Forbidden by default:

- `arwoxb24/*`
- personal repositories
- personal control-spine copies

Personal repositories may be inspected only after explicit owner permission for that exact task and exact repository. Until then, agents must treat personal repositories as forbidden source and forbidden write target.

## 2. Problem statement

There may be a personal repository named:

- `arwoxb24/agenthub-control-spine`

The owner suspects it may be hidden/stale and may confuse agents. The corporate organization repository is the only canonical control-spine location.

The owner requests a safe architecture plan for two workstreams:

1. Review whether anything from the personal repository should be merged into the organization repository.
2. Clean and normalize the organization repository by removing or quarantining stale/noisy artifacts, outdated date-prefixed files, obsolete reports, duplicate prompt families, and unused clutter.

## 3. Critical critique

### 3.1. Do not blindly merge personal into organization

A direct merge from `arwoxb24/agenthub-control-spine` into `arwoxbx24/agenthub-control-spine` is not safe by default.

Reasons:

- The personal repository is non-canonical.
- It may contain stale prompts, old reports, duplicate governance, raw experiments, or private artifacts.
- It may include instructions that conflict with current `AGENTS.md`, `ARTIFACT_REGISTER.md`, or active policies.
- It may reintroduce obsolete prompt loops or reports-as-instructions.
- It may contain secrets, raw links, or non-redacted history.
- A Git merge would import history and noise, not only useful content.

Correct approach:

- Inventory first.
- Read-only diff second.
- Whitelist useful artifacts third.
- Copy selected content into corporate repo as new reviewed artifacts only.
- Preserve provenance.
- Never merge personal repo wholesale.

### 3.2. Organization repo cleanup must not delete evidence blindly

Cleaning the organization repo is also dangerous if done as broad deletion.

Reasons:

- Reports and receipts may be historical evidence.
- Old artifacts may be superseded but still needed for traceability.
- Deleting receipts can break audit chain.
- Renaming date-prefixed files can break index/register references.
- Large cleanup can create context drift and PR review risk.

Correct approach:

- Registrar-led lifecycle cleanup.
- Mark obsolete artifacts as `audit_only`, `superseded`, or `quarantine` first.
- Delete only files already proven unsafe or duplicate and only with deletion receipt.
- Prefer index/register cleanup before physical deletion.
- Use validators after every batch.

## 4. Required task model

No implementation starts without a physical YouTrack task.

Required tasks:

### Task A — Personal repository inventory gate

Russian title:

`Проверить личный agenthub-control-spine без слияния`

Purpose:

- Read-only inventory of `arwoxb24/agenthub-control-spine` only after explicit owner permission.
- Produce a compare report against `arwoxbx24/agenthub-control-spine`.
- Do not write to the personal repository.
- Do not merge anything.

Required output:

- inventory report;
- secret-scan/redaction result;
- duplicate/conflict matrix;
- whitelist of potentially useful artifacts;
- reject list;
- recommendation: copy / ignore / quarantine / archive.

### Task B — Corporate repository hygiene audit

Russian title:

`Навести порядок в arwoxbx24/agenthub-control-spine без потери evidence`

Purpose:

- Audit corporate repo clutter.
- Identify stale date-prefixed artifacts, obsolete prompts, superseded reports, duplicate families, and index/register drift.
- Do not delete during audit.

Required output:

- cleanup candidate report;
- lifecycle update plan;
- deletion candidate list with reason;
- no-delete evidence list;
- PR batching plan.

### Task C — Corporate cleanup implementation

Russian title:

`Выполнить безопасную очистку control-spine через Registrar`

Purpose:

- Apply only approved cleanup from Task B.
- Use small PR batches.
- Update `INDEX.md`, `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, receipts, and validations.

Required output:

- cleanup PR(s);
- validation report;
- deletion/quarantine receipt;
- no-secret proof;
- final task readback.

## 5. Execution order

1. Confirm owner permission for personal repo inventory.
2. If permission is not explicit, skip personal repo read and record `PERSONAL_REPO_PERMISSION_MISSING`.
3. Create or locate physical YouTrack task for Task A.
4. Read corporate baseline:
   - `AGENTS.md`
   - `INDEX.md`
   - `ARTIFACT_REGISTER.md`
   - `PR_QUEUE_REGISTER.md`
   - `context/agenthub-current-context-pack.md`
5. Inventory corporate repo only.
6. If personal repo permission exists, read personal repo in read-only mode.
7. Compare by:
   - path;
   - artifact_id;
   - lifecycle;
   - source_task;
   - scope_signature;
   - title/heading;
   - normalized content digest;
   - prompt family;
   - report/receipt type;
   - register/index coverage.
8. Classify every personal artifact:
   - ignore;
   - copy candidate;
   - conflict candidate;
   - unsafe/quarantine candidate;
   - duplicate of corporate;
   - unknown.
9. Do not perform wholesale Git merge.
10. Produce report to corporate repository only.
11. For corporate cleanup, produce candidate list first.
12. Cleanup only through separate approved task/PR.
13. Validate with existing and new validators.
14. Final owner output: compact `Fact / Action / Left` only.

## 6. Forbidden actions

- No direct merge from personal repository.
- No personal repo writes.
- No personal repo reads unless exact owner permission exists.
- No broad delete.
- No rewrite of Master Artifact or Project Instructions.
- No runtime/server/Docker/DB/proxy/firewall/DNS/SSL mutation.
- No raw transcript links.
- No secrets, tokens, env dumps, private keys.
- No deleting reports/receipts without replacement receipt and register update.
- No direct main commit.
- No PR without YouTrack task/readback.
- No treating GitHub Issues as replacement for YouTrack.

## 7. Missing data before personal repo review

The following must be known before any personal repo inspection:

- Exact explicit owner permission to read `arwoxb24/agenthub-control-spine`.
- Whether personal repo should be archived, renamed, or only marked non-canonical.
- Whether any personal repo branches must be preserved.
- Whether personal repo contains secrets or private history requiring special handling.
- Whether the intended end state is:
  - leave personal repo untouched but documented as forbidden;
  - archive personal repo;
  - rename personal repo;
  - make it private;
  - delete it later;
  - copy selected artifacts into corporate repo.

Owner-only gates:

- archive personal repository;
- delete personal repository;
- transfer personal repository;
- change visibility;
- expose private contents;
- authorize reading private personal repo contents.

## 8. Corporate cleanup candidate categories

Cleanable only after audit:

- duplicate prompt families;
- consumed prompts not referenced by register;
- audit reports that became pseudo-instructions;
- stale date-prefixed reports with no active task reference;
- superseded receipts missing lifecycle state;
- orphan files absent from `INDEX.md` and `ARTIFACT_REGISTER.md`;
- duplicate rows in register/index;
- old handoffs that should be `audit_only`;
- old PR queue entries missing terminal state.

Not cleanable by default:

- receipts required for proof chain;
- active policies;
- validators;
- schemas;
- current context pack;
- AGENTS.md;
- INDEX.md;
- ARTIFACT_REGISTER.md;
- PR_QUEUE_REGISTER.md;
- security reports unless redaction requires quarantine.

## 9. Required validators / controls

Use or create validators for:

- document dedupe gate;
- artifact lifecycle gate;
- PR queue state gate;
- no personal repo canonical reference;
- no stale prompt replay;
- no secret/raw link exposure;
- index/register coverage;
- deletion receipt requirement.

## 10. Acceptance gates

A cleanup/merge-control task is complete only if:

- physical YouTrack task exists;
- task readback exists;
- corporate repo is the only target;
- personal repo read was authorized or skipped with typed blocker;
- no wholesale merge happened;
- every copied artifact has provenance and review reason;
- every ignored artifact has reason;
- every deleted/quarantined artifact has receipt;
- `INDEX.md` updated;
- `ARTIFACT_REGISTER.md` updated;
- `PR_QUEUE_REGISTER.md` updated if PR exists;
- validators pass;
- secret scan passes;
- final receipt exists;
- owner output is compact.

## 11. Typed blockers

Use only exact blockers:

- `PERSONAL_REPO_PERMISSION_MISSING`
- `PERSONAL_REPO_SECRET_RISK`
- `NO_WHOLESALE_MERGE_ALLOWED`
- `TASK_ID_MISSING`
- `TASK_READBACK_MISSING`
- `INDEX_REGISTER_DRIFT`
- `ARTIFACT_LIFECYCLE_DRIFT`
- `PR_QUEUE_DRIFT`
- `DELETE_RECEIPT_MISSING`
- `SECRET_OR_RAW_LINK_RISK`
- `OWNER_ONLY_IRREVERSIBLE_GATE`

## 12. Recommended decision

Recommended decision now:

- Do not merge personal repository into corporate repository.
- Create read-only personal repo inventory only after explicit permission.
- Keep corporate repo canonical.
- Clean corporate repo through Registrar lifecycle gates, not broad deletion.
- Move only selected artifacts by whitelist copy, never Git merge.
- Add explicit non-canonical marker for personal repo in corporate policy if not already covered.

## 13. Final owner-facing text after implementation

```text
Fact: personal repo not merged; corporate repo remains canonical; cleanup plan recorded.
Action: audit/cleanup tasks created through YouTrack and corporate control-spine.
Left: none or exact blocker.
```
