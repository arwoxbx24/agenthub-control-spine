---
artifact_id: agenthub-komodo-browser-outcome-truth-validation-20260612
artifact_type: validation_report
owner_role: Verifier / Truth Redteam
source_task: AH-747
run_id: RUN-AGENTHUB-KOMODO-BROWSER-OUTCOME-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: validation_record
default_load: false
safe_to_replay: false
---

# AgentHub Komodo Browser Outcome + Execution Truth Validation

## Scope

Repository control package validation only. No VPN, DB, Docker, proxy, firewall, DNS, SSL, secret, or live Komodo mutation was performed.

## Official Docs Checked

- Playwright assertions: https://playwright.dev/docs/test-assertions
- Playwright screenshots: https://playwright.dev/docs/screenshots
- Playwright network testing: https://playwright.dev/docs/network
- Playwright trace viewer: https://playwright.dev/docs/trace-viewer
- YouTrack REST API: https://www.jetbrains.com/help/youtrack/devportal/youtrack-rest-api.html
- YouTrack Commands API: https://www.jetbrains.com/help/youtrack/devportal/resource-api-commands.html
- OpenAI Codex approvals/security: https://developers.openai.com/codex/agent-approvals-security
- OpenAI Codex config: https://developers.openai.com/codex/config-basic
- MCP authorization: https://modelcontextprotocol.io/docs/tutorials/security/authorization
- MCP tools: https://modelcontextprotocol.io/specification/2025-11-25/server/tools
- Komodo architecture/docs: https://komo.do/docs/intro and https://komo.do/docs/setup/connect-servers

## Installed Controls

- Policy rejects HTTP 200, HTML shell, container health, asset 200, env-only model labels, and shell-only worker proof as Done evidence.
- Browser user outcome schema requires screenshot, DOM markers, console, network, assets, API, auth flow, and evidence quality label.
- Komodo receipt schema requires Core/Mongo/Periphery/public route/browser/login/API/user-outcome fields.
- Model execution truth schema separates requested/resolved metadata from actual proof.
- AgentHub worker route schema rejects shell-only route proof.
- Validators cover HTTP-only Done, browser outcome, Komodo outcome, worker route truth, model truth, screenshot durability, latest complaint override, YouTrack Done gate, prompt dump, and duplicate task/PR suppression.

## AH-747 Truth Ledger

- Previous green based on HTTP/HTML/container/headless evidence: `BACKEND_OR_HTML_ONLY`.
- Latest owner contradiction: present.
- YouTrack latest root-cause comment: `PUBLIC_KOMODO_ROUTE_MISSING_OR_MISCONFIGURED / KOMODO_HOST_LOOPBACK`.
- Current user outcome: not proven.
- Correct final blocker: `PUBLIC_ROUTE_FAILURE`.

## Acceptance Gate Status

- `HTTP_200_NOT_USED_AS_DONE`: PASS.
- `MODEL_TRUTH_STATUS_PROVEN_OR_NOT_CLAIMED`: PASS; no Codex execution claim is made by this control package.
- `NO_PROMPT_DUMP`: PASS.
- `NO_DUPLICATE_TASK_OR_PR`: PASS; AH-747 reused.
- `BROWSER_SCREENSHOT_READABLE`: BLOCKED for live Komodo claim; not required for repository control package closure.
- `KOMODO_USER_OUTCOME_VALIDATED`: FAIL for live Komodo; do not claim site works.
- `YOUTRACK_STAGE_DONE_READBACK`: intentionally not attempted because live user outcome remains unproven.

## Validator Status

Static validator package installed with fixtures. The fixtures encode current AH-747 as blocked, not Done. Negative canaries are named for HTTP-only Done, env-only model claims, prompt dumps, YouTrack Done without user outcome, and latest complaint after green.

## Verdict

Repository hardlock package installed. Live Komodo user outcome remains not proven. Final green is blocked by `PUBLIC_ROUTE_FAILURE` until intended public route and external/browser-equivalent outcome are proven through a scoped worker route.
