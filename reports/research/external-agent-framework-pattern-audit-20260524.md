---
artifact_id: external-agent-framework-pattern-audit-20260524
artifact_type: research-report
owner_role: T1 Architecture Broker
source_task: AH-527
run_id: RUN-agenthub-external-repo-pattern-audit-20260524
created_at: 2026-05-24
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# External Agent Framework Pattern Audit - 2026-05-24

## Scope

This is a research/adaptation report only. No external code was installed,
executed, vendored, imported, or treated as an AgentHub Orchestrator
replacement.

Candidate repositories:

- `anthropics/knowledge-work-plugins`: <https://github.com/anthropics/knowledge-work-plugins>
- `microsoft/AI-Engineering-Coach`: <https://github.com/microsoft/AI-Engineering-Coach>

AgentHub source constraints used for fit:

- YouTrack is the task system.
- GitHub is artifact storage and PR surface.
- AgentHub/Codex MCP is execution/control.
- T0 is control-plane only.
- Reports and receipts are evidence, not default instructions.
- Runtime, product, secret, and infrastructure mutation are out of scope.

## Source Ledger

| Source | Readback used | Why it matters |
|---|---|---|
| `anthropics/knowledge-work-plugins` README | Plugin purpose, marketplace table, file structure, skills/commands/connectors explanation | Establishes the role-plugin architecture and file-based pattern. |
| `anthropics/knowledge-work-plugins` root listing | Plugin directories including `productivity`, `data`, `product-management`, `customer-support`, `cowork-plugin-management` | Confirms role/domain segmentation. |
| `anthropics/knowledge-work-plugins` plugin manifests and `.mcp.json` examples | Manifest metadata and connector declarations | Shows separation between skills and MCP connector config. |
| `anthropics/knowledge-work-plugins` skills/commands examples | `write-query`, `validate-data`, `brainstorm`, `task-management`, plugin creation/customization skills | Shows workflow-oriented skill pattern and explicit connector awareness. |
| `anthropics/knowledge-work-plugins` license | Apache-2.0 | Permissive, but attribution/license retention required if copying occurs. This report recommends pattern-only adoption. |
| `microsoft/AI-Engineering-Coach` README and extension README | Observe/Measure/Improve model, anti-patterns, skill finder, context health, supported harnesses, privacy claims | Establishes the observer/coach pattern for AgentHub evals. |
| `microsoft/AI-Engineering-Coach` package manifest | VS Code extension commands, activation events, MIT license | Confirms VS Code extension surface and local-tool assumptions. |
| `microsoft/AI-Engineering-Coach` docs/rules listing | Anti-pattern, context-health, skill-finder docs and rule files | Shows markdown rule DSL and context/session-health taxonomy. |
| `microsoft/AI-Engineering-Coach` license | MIT | Permissive, but attribution/license retention required if copying occurs. This report recommends pattern-only adoption. |

## Hard Verdict

Pilot only, pattern adaptation.

Do not integrate either repository as a runtime dependency. Do not install
Claude plugins, VS Code extensions, VSIX packages, scripts, MCP connector
configs, or local-log analyzers into AgentHub in this task.

Recommended adoption:

- Anthropic: adapt the file-based plugin/skill/command/connector separation
  into AgentHub skill-pack design and register lifecycle rules.
- Microsoft: adapt the anti-pattern, context-health, prompt-hygiene,
  skill-discovery, and session-quality concepts into AgentHub prompt evaluation
  and Registrar hygiene.

## Scorecard

Scores are 0-10. For implementation risk, higher means higher risk.

| Repository | AgentHub fit | Codex fit | T0 control fit | Implementation risk | Adaptation value |
|---|---:|---:|---:|---:|---:|
| `anthropics/knowledge-work-plugins` | 8 | 8 | 6 | 6 | 8 |
| `microsoft/AI-Engineering-Coach` | 7 | 8 | 8 | 7 | 9 |

## Anthropic Pattern Findings

Useful patterns:

- File-based role packs: one plugin directory owns manifest, skills, optional
  commands, optional MCP connectors, and documentation.
- Component separation: skills encode domain workflows, commands are explicit
  user-invoked actions, connectors are declared separately in `.mcp.json`.
- Progressive skill detail: `SKILL.md` files combine activation metadata with
  workflow steps, examples, and connector awareness.
- Role/domain segmentation: data, product-management, customer-support,
  productivity, sales, legal, finance, and plugin-management are separate
  packages rather than one giant prompt.
- Connector abstraction: external tools are described as connector classes, not
  always hardcoded into the core workflow.
- Plugin management skill: the repository includes explicit guidance for
  creating/customizing plugins, which maps to AgentHub skill intake and
  lifecycle governance.

Adapt to AgentHub:

- Define AgentHub skill packs as file-based bundles with:
  `SKILL.md`, optional `references/`, optional command templates, connector
  requirements, owner role, lifecycle metadata, allowed/forbidden surfaces, and
  validation gates.
- Require a skill-pack manifest that binds each skill to YouTrack task classes,
  AgentHub role ownership, MCP connector needs, and evidence output.
- Keep connectors outside skills. Skills may declare connector needs, but
  approved MCP routes own runtime authorization.
- Use role-pack examples as design inspiration for T0 Registrar, T1 Architect,
  Verifier, DevOps Incident Worker, and Repo Artifact Worker skill packs.
- Add a register rule: external plugin examples are `audit_only` until adapted,
  reviewed, and approved as AgentHub-local skills.

Reject:

- Cowork-specific assumptions such as desktop plugin packaging, Cowork outputs
  directory, and Claude-specific marketplace install commands.
- Direct `.mcp.json` adoption into AgentHub runtime without approved MCP intake.
- Role plugins that bypass YouTrack or AgentHub control-plane receipts.
- Task tracking through local `TASKS.md` for AgentHub governance. AgentHub uses
  YouTrack as the task system.
- Any connector credential, OAuth, or remote MCP endpoint config copied from the
  examples.

## Microsoft Pattern Findings

Useful patterns:

- Observe/Measure/Improve model for agent practice quality.
- Anti-pattern rules grouped by prompt quality, session hygiene, code review,
  tool mastery, and context management.
- Markdown rule files with metadata, severity, thresholds, examples, and
  detection logic.
- Context-health checklist: instruction files, custom skills, prompt templates,
  hooks, dev containers, MCP servers, freshness, context provision, and
  compaction health.
- Skill finder concept: repeated prompt patterns can become reusable skills.
- Local/privacy-first framing: session analysis should not ship raw logs or
  telemetry by default.
- Supported harness inventory includes Codex, Claude, OpenCode, VS Code, Xcode,
  and Copilot CLI, which is useful as a taxonomy reference.

Adapt to AgentHub:

- Create AgentHub evaluation rules for:
  direct T0 implementation, repeated blockers, runaway tool loops, stale report
  replay, missing skill use, context drift, auto-approval/YOLO, no receipt,
  incomplete Done evidence, and prompt bloat.
- Represent evals as local markdown or JSON rule artifacts with lifecycle
  metadata, owner role, privacy gate, source fields, evidence output, and
  false-positive policy.
- Add a skill-discovery gate: repeated user prompts and repeated worker
  failures become candidate skills only after redaction and Registrar review.
- Add context-health metrics to Registrar receipts: current context pack loaded,
  reports not default-loaded, skill selection recorded, token budget respected,
  no stale prompt replay.
- Keep privacy boundary strict: analyze only redacted receipts/registers and
  approved metadata, not raw session logs, raw transcripts, private prompts, or
  secret-bearing terminal output.

Reject:

- VS Code extension runtime, VSIX packaging, dashboard UI, local screenshot
  gallery, local session parsers, and harness-specific filesystem scans.
- Raw `.codex/sessions`, `.claude/projects`, or IDE storage parsing without a
  separate security/privacy task and redaction policy.
- Community skill auto-install.
- Local log analysis as Done proof.
- Any score that treats high activity or repository popularity as evidence of
  AgentHub success.

## Options

### Option A: No Adoption, Only Citations

Lowest implementation risk. This keeps the report as a source note only, but it
does not capture useful architecture improvements.

### Option B: Pattern Adaptation Into Existing Artifacts

Recommended. Adapt file-based skill-pack structure, connector separation,
prompt-evaluation rules, context-health checks, and skill-discovery gates into
existing AgentHub governance, schemas, and runbooks. No runtime dependency.

### Option C: Pilot Observer/Skill-Pack Integration

Higher payoff but requires a new implementation task. A pilot could add
AgentHub-native eval rules and skill-pack manifests, but only after security,
privacy, and register validators are defined.

## Selected Option

Option B now, with Option C deferred.

Reasons:

- It improves AgentHub governance without installing external code.
- It fits the control-spine repository purpose.
- It avoids VS Code/Cowork/runtime assumptions.
- It produces clear follow-up implementation candidates while keeping this task
  research-only.

## Proposed Follow-Up Tasks

Create these only after this research report is accepted:

1. AgentHub skill-pack manifest schema.
   - Inputs: Anthropic-style manifest/skill/connector separation.
   - Output: `schemas/agenthub-skill-pack.schema.json` and a runbook.

2. AgentHub prompt-evaluation rule schema.
   - Inputs: Microsoft-style markdown rule metadata and detection taxonomy.
   - Output: schema/runbook for redacted receipt-based evals.

3. Registrar context-health validator.
   - Inputs: Microsoft context-health categories and current AgentHub context
     pack rules.
   - Output: validator specification, not raw log analysis.

4. Skill-discovery intake gate.
   - Inputs: repeated prompt/worker failure patterns.
   - Output: a safe process that creates candidate skills only after redaction,
     lifecycle classification, and Registrar approval.

## Security, Privacy, and Supply Chain Notes

- Do not install either repository in AgentHub.
- Do not run package scripts, VSIX packaging, Claude plugin install commands, or
  external MCP connector configs.
- Do not copy third-party code into runtime.
- If future work copies more than short excerpts or templates, retain upstream
  license notices and perform legal review.
- Apache-2.0 and MIT are permissive licenses, but this task uses pattern
  adaptation only.
- Any future session/log analysis must run on redacted AgentHub receipts and
  metadata first. Raw logs, raw transcripts, session stores, screenshots, and
  local IDE storage require a separate privacy/security review.
- External connector examples must be treated as untrusted until an MCP intake,
  secret review, and route receipt exist.

## Acceptance Gates

| Gate | State |
|---|---|
| Duplicate YouTrack check | PASS: no existing matching task found |
| One task anchor | PASS: `AH-527` |
| One RUN | PASS: `RUN-agenthub-external-repo-pattern-audit-20260524` |
| Prompt quality gate | PASS: 88/100 before research execution |
| Both repositories read | PASS |
| License checked | PASS: Apache-2.0 and MIT |
| Runtime mutation | PASS: none |
| External code execution | PASS: none |
| Recommendation explicit | PASS: Option B now, Option C deferred |

