---
artifact_id: agenthub-komodo-browser-outcome-and-execution-truth-hardlock-policy
artifact_type: governance_policy
owner_role: T1 Architecture Broker / T2 Scoped Worker / Verifier / Registrar
source_task: AH-747
run_id: RUN-AGENTHUB-KOMODO-BROWSER-OUTCOME-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Komodo Browser Outcome And Execution Truth Hardlock

## Rule

For user-facing websites, transport evidence is not completion evidence.

- HTTP 200 is not Done.
- HTML shell is not Done.
- Container healthy is not Done.
- Static asset 200 is not Done.
- Environment model labels are not Codex execution proof.
- Shell-only logs are not AgentHub worker proof.
- Latest owner complaint overrides earlier green until browser/user-outcome proof is refreshed.

## Required Proof For Website Done

A UI/service task may reach Done only when the receipt contains browser-visible user outcome evidence:

- public URL checked from the intended user route;
- screenshot artifact readable by path/hash;
- DOM visible markers match the claimed state;
- console fatal errors counted;
- critical network failures counted;
- API/auth behavior checked when relevant;
- task board stage readback confirms Done.

`BACKEND_ONLY`, `HTML_SHELL_ONLY`, and `ASSETS_ONLY` evidence labels cannot close website tasks.

## Komodo-Specific Gate

Komodo Done requires browser-visible Komodo state, not only local Core process state:

- Core route visible in browser;
- login or dashboard visible;
- API health checked without secret output;
- Periphery/server list state checked where the task claims it works;
- stack/container list or authenticated empty state checked where expected.

If `KOMODO_HOST` or route evidence points at loopback/local-only access, the public user outcome remains unproven and the blocker is `PUBLIC_ROUTE_FAILURE` or a narrower typed route blocker.

## Execution Truth Gate

Requested/resolved model names are route metadata only. Actual model execution proof must come from usage/audit/client/API-response evidence. If missing, final output must not say Codex/Spark ran.

AgentHub worker execution proof must contain a real MCP/AgentHub dispatch or worker receipt. Shell-only output is rejected.

## Forbidden Scope

This policy does not authorize DB, Docker, proxy, firewall, DNS, SSL, VPN, secret, or destructive runtime mutation. Those require a separate scoped worker route, rollback proof, and explicit authority.

## Official Source Ledger

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
- Komodo intro/architecture: https://komo.do/docs/intro
- Komodo setup: https://komo.do/docs/setup
- Komodo connect servers: https://komo.do/docs/setup/connect-servers
