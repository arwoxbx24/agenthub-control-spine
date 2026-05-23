---
artifact_id: AH-507-source-map
artifact_type: source-map
source_task: AH-507
run_id: AH-CHATGPT-APP-BOOTSTRAP-20260523
status: active
---

# Source Map

Official sources checked:

- OpenAI Apps SDK / MCP server guidance:
  `https://developers.openai.com/api/docs/mcp`
- OpenAI Apps SDK quickstart:
  `https://developers.openai.com/apps-sdk/quickstart`
- OpenAI Connect from ChatGPT:
  `https://developers.openai.com/apps-sdk/deploy/connect-chatgpt`
- OpenAI Apps SDK security and privacy:
  `https://developers.openai.com/apps-sdk/guides/security-privacy`
- OpenAI app submission guidelines:
  `https://developers.openai.com/apps-sdk/app-submission-guidelines`
- OpenAI submit and maintain app:
  `https://developers.openai.com/apps-sdk/deploy/submission`
- GitHub App permissions:
  `https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/choosing-permissions-for-a-github-app`
- GitHub REST contents API:
  `https://docs.github.com/en/rest/repos/contents?apiVersion=2022-11-28`
- GitHub REST pull requests API:
  `https://docs.github.com/en/rest/pulls/pulls?apiVersion=2022-11-28`

Verified anchors:

- ChatGPT apps use MCP servers to expose tools and capabilities.
- A data-only app can expose tools without a UI component.
- Developer Mode connection requires a public MCP server URL for ChatGPT testing.
- Apps SDK security guidance requires least privilege, explicit consent,
  server-side validation, audit logs, and human confirmation for irreversible
  operations.
- Submission guidance requires privacy policy, support contact, verified
  publisher or appropriate app-management permission, a public MCP endpoint, and
  accurate tool annotations.
- GitHub repository content writes require repository contents write access.
- Pull request creation/update requires pull request write access.
