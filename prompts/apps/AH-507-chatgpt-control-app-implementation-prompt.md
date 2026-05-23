---
artifact_id: AH-507-chatgpt-control-app-implementation-prompt
artifact_type: implementation-prompt
source_task: AH-507
run_id: AH-CHATGPT-APP-BOOTSTRAP-20260523
status: active
---

# AgentHub ChatGPT Control App Implementation Prompt

Build and validate a dedicated ChatGPT Apps SDK / MCP connector for the
AgentHub Orchestrator control spine. The app must expose audited tools for
repository reads, safe artifact writes, YouTrack task routing, receipt creation,
and write-proof validation. It must not rely on the ordinary ChatGPT GitHub
connector as final execution proof.

Hard constraints:

- Use only `arwoxbx24/agenthub-control-spine` by default.
- Block personal owner `arwoxb24` unless explicitly authorized by a future task.
- Do not expose repository deletion tools.
- Keep all credentials server-side.
- Do not store secrets, raw env dumps, private keys, raw transcripts, or internal
  history links in GitHub artifacts.
- Mark write tools as write tools and require human confirmation in ChatGPT.
- Validate all inputs server-side and maintain redacted audit logs.

Done requires a real ChatGPT Developer Mode connector, visible tool list,
successful `health_check`, successful owner-restricted repository listing,
successful `github_write_proof` through this app's own tool path, secret scan
PASS for added files, and a receipt in `reports/receipts/`.
