---
artifact_id: p0-global-agent-control-secrets-and-repo-audit-20260527
artifact_type: audit_report
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-590
run_id: RUN-P0-GLOBAL-AGENT-CONTROL-SECRETS-REPO-AUDIT-20260527
created_at: 2026-05-27
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 Global Agent Control, Secrets Registry, And Repo Audit

## Scope

This audit covers AgentHub control-plane enforcement, schema/policy alignment, secret-handle registry architecture, repo-first evidence coverage, and task-debt risk for AH-590-family governance work. It does not perform product/runtime/Docker/NPM/DNS/SSL mutation.

## Factcheck

- PR #68 is merged and added T0 hard-stop and isolation controls.
- PR #69 is merged and marked PR #68 merged, but the current queue snapshot did not expose PR #69 as a standalone queue row before this patch.
- `schemas/agent-run-isolation.schema.json` requires lowercase `run_id` and has `additionalProperties=false`.
- `governance/policies/t0-direct-action-hard-stop-policy.md` still listed `RUN_ID` as required metadata. That mismatch can reject otherwise valid runs or push agents into bypass/blocker loops.
- Existing secret protection policy blocks secret values in Git and chat, but there was no per-service redacted secret-handle registry schema/manifest.
- AgentHub MCP command dispatch for recent live DNS/NPM actions returned `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`; missing live-worker route remains a runtime-route defect, not permission for T0 direct CLI.

## Corrective Package

This branch adds:

- global T0 enforcement policy;
- redacted secrets registry policy;
- model/token routing policy;
- `RUN_ID` compatibility note in run isolation schema;
- secrets manifest schema;
- redacted secrets manifest;
- T0 violation and missing-secret-handle runbooks;
- global-agent-control and secrets-registry eval fixtures;
- receipt/register coverage.

## Self-Critique

The failure class is architectural: prompt instructions existed, but enforcement and schema alignment were incomplete. The most serious defect is allowing T0-like sessions to attempt live CLI fallbacks when AgentHub live-worker dispatch is blocked. The second defect is inconsistent field naming (`RUN_ID` vs `run_id`) across policy and schema. The third defect is secrets discovery ambiguity: workers should request a named handle, not search files or ask for raw credentials in chat.

## Validation Summary

Validation must treat this as control-spine governance evidence, not live runtime success. Required runtime enforcement remains subject to AgentHub hook/adapter installation readback. If runtime hook installation contradicts the policy, final state must be `AGENTHUB_HOOK_INSTALL_PATH_REQUIRED` or `LIVE_WORKER_POLICY_INSTALLER_REQUIRED`.

## Official Source Anchors

- GitHub secret scanning: https://docs.github.com/en/code-security/secret-scanning
- GitHub Actions secrets: https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions
- Docker Compose secrets: https://docs.docker.com/compose/how-tos/use-secrets/
- OpenAI models: https://platform.openai.com/docs/models
