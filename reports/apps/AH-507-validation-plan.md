---
artifact_id: AH-507-validation-plan
artifact_type: validation-plan
source_task: AH-507
run_id: AH-CHATGPT-APP-BOOTSTRAP-20260523
status: active
---

# Validation Plan

Required PASS gates:

1. `AGENTS.md` and `INDEX.md` read from `main`.
2. Exactly one YouTrack task exists for the bootstrap.
3. Official source map is recorded.
4. MCP server prototype builds.
5. Static policy test confirms no repository deletion surface and no committed
   tokens.
6. Secret scanner returns no findings for added files.
7. Public HTTPS `/sse` or `/mcp` endpoint exists.
8. ChatGPT Developer Mode connector is created.
9. ChatGPT tool list shows the MVP tools.
10. `health_check` succeeds from ChatGPT.
11. `list_allowed_repositories` returns only `arwoxbx24` repositories.
12. `github_write_proof` succeeds through this app's own tool path.
13. Receipt is recorded.

Current expected status for this branch is PARTIAL until gates 7-12 are executed
with real hosting, ChatGPT Developer Mode access, and approved server-side
GitHub credentials.
