---
artifact_id: agenthub-skill-pack-command-connector-patterns
artifact_type: governance-control
owner_role: T0 Registrar
source_task: AH-531
run_id: RUN-pattern-implementation-ah531-ah532-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Skill-Pack, Command, and Connector Pattern Control

## Purpose

This control adapts the AH-527 Anthropic pattern findings into AgentHub-local
governance. It does not install, clone, vendor, execute, import, or run
`anthropics/knowledge-work-plugins`.

## Pattern Decision

AgentHub may use file-based skill-pack structure as a design pattern:

- skill packs are local AgentHub artifacts, not upstream plugin installs;
- commands are explicit task-bound actions, not implicit chat authority;
- connectors are declared requirements for approved MCP routes, not copied
  external `.mcp.json` files;
- lifecycle and default-load state are owned by `ARTIFACT_REGISTER.md`;
- every mutable action remains bound to YouTrack, AgentHub RUN, branch,
  evidence, validation, and receipt.

## AgentHub Skill-Pack Contract

An AgentHub skill pack or equivalent control bundle must define:

| Field | Requirement |
|---|---|
| `artifact_id` | Stable id matching the file or bundle. |
| `source_task` | YouTrack task that authorizes the artifact. |
| `owner_role` | T0, T1, Worker, Verifier, or another approved AgentHub role. |
| `task_classes` | Task classes that may load the skill. |
| `activation_rules` | Narrow trigger conditions and negative matches. |
| `allowed_surfaces` | Files, artifact types, tools, or MCP routes the role may use. |
| `forbidden_surfaces` | Runtime, secrets, product, infra, or unrelated repo surfaces that are blocked. |
| `connector_requirements` | MCP/app routes needed, with no embedded credentials. |
| `command_contracts` | Explicit command/action briefs with task id, RUN_ID, evidence, and rollback/checkpoint rules. |
| `validation_gates` | Checks required before Done. |
| `evidence_output` | Receipt paths, register entries, and task readback fields. |
| `lifecycle_metadata` | Lifecycle, default-load, and replay safety state. |

## Command Boundary

AgentHub commands are not generic shell permission. A command-like action is
valid only when all are true:

1. A YouTrack task or approved child task owns the work.
2. An AgentHub RUN and worker ownership receipt exist.
3. The command scope matches the task class and allowed surfaces.
4. Secrets are never printed or reconstructed.
5. Validation and receipt outputs are defined before mutation.
6. The result is written back to task evidence and control-spine artifacts when
   the task changes governance state.

## Connector Boundary

Connector declarations must stay separate from workflow instructions.

Allowed connector metadata:

- connector class, for example YouTrack, GitHub, AgentHub MCP, safe link intake;
- why the connector is required;
- allowed read/write actions;
- forbidden actions;
- evidence/receipt fields returned by the route.

Forbidden connector metadata:

- copied credentials, tokens, private keys, OAuth secrets, or endpoint secrets;
- copied upstream `.mcp.json` files;
- direct runtime or production service mutation without a separate scoped task;
- connector use that bypasses YouTrack or AgentHub receipts.

## Lifecycle Rule

External plugin examples remain `audit_only` evidence until they are:

1. adapted into AgentHub-local language;
2. reviewed for role boundary, secret, and runtime risk;
3. indexed in `INDEX.md`;
4. registered in `ARTIFACT_REGISTER.md`;
5. tied to a YouTrack task and AgentHub receipt.

## Rejection Rules

Reject any proposed skill-pack adaptation that:

- installs or vendors upstream plugin code;
- uses GitHub Issues as task tracking;
- merges connector config with role instructions;
- allows T0 direct runtime or product mutation;
- treats a command, PR, or report as Done without task readback and receipt.

## Acceptance

AH-531 is satisfied when this control, register/index coverage, validation
evidence, PR readback, and YouTrack Done gate all pass.
