---
artifact_id: omega-fallback-permission-lane-runbook
artifact_type: runbook
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-796
run_id: omega-fallback-permission-lane-hardlock-20260615
created_at: 2026-06-15
lifecycle_status: active_runbook
default_load: false
safe_to_replay: false
---

# Omega Fallback Permission Lane Runbook

## Flow

1. Bind task id, RUN id, repo, branch, allowed paths, and forbidden surfaces.
2. Try GitHub connector/API first.
3. If connector fails, try AgentHub-approved GitHub route.
4. If unavailable, use `gh` CLI only inside the task-bound contour and only for
   `arwoxbx24/agenthub-control-spine`.
5. Select the smallest permission lane.
6. Convert routine blocker to same-RUN PackFix.
7. Stop on repeated same command plus same blocker.
8. Validate fixtures.
9. Update registers and PR queue.
10. Finalize only after main/readback and task readback, or record typed blocker.

## Permission Lifecycle

Every lane grant records task id, run id, repository, paths, action, expiry,
proof, rollback, and evidence sink. Wildcards and product/prod/test/runtime
surfaces are denied.

## Platform Blockers

Use exact blockers:

- `GITHUB_CONNECTOR_AND_GH_FALLBACK_UNAVAILABLE`
- `GH_FALLBACK_SCOPE_UNSAFE`
- `BRANCH_PROTECTION_PLATFORM_GATE`
- `YOUTRACK_READBACK_UNAVAILABLE`
- `AGENTHUB_ROUTE_MISSING`
- `CONTROL_SPINE_WRITE_ROUTE_MISSING`
- `OWNER_ONLY_PLATFORM_GATE`
- `SAFETY_QUARANTINE`

