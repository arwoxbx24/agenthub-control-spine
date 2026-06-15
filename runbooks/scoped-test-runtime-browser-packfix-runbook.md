---
artifact_id: scoped-test-runtime-browser-packfix-runbook
artifact_type: runbook
source_task: AH-793
status: active_control_candidate
safe_to_replay: false
---

# Scoped Test Runtime Browser PackFix Runbook

1. Bind task and RUN_ID.
2. Classify target URL and reject anything except `https://stroy-test.b244.ru/a/?p=banners`.
3. Read PR/code state and current task evidence.
4. If runtime or browser route is blocked, create same-RUN PackFix instead of owner-facing blocker text.
5. Request lane `L6_AGENTHUB_COMMAND_WORKER` for test-only rollout or `L7_AGENTHUB_BROWSER_WORKER` for browser-only outcome.
6. Include task id, run id, exact URL, branch/PR, allowed action, forbidden surfaces, expiry, receipt, and rollback plan.
7. Run browser checklist: page reachable, form visible, valid 240x400 upload, banner visible, cleanup.
8. If page shows `AH793-*`, capture it and route same-RUN code PackFix.
9. Done only after visible proof, cleanup proof, no production touch, receipt, and task readback.
