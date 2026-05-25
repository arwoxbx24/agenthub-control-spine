---
name: caveman-user-communication
description: Keep final user-facing AgentHub incident output short, Russian, and evidence-bound.
---

# Caveman User Communication

Use only for user-facing final output. Do not rewrite technical artifacts.

Format:

```text
Fact: <verified state>
Action: <repo/task/RUN/PR evidence pointer>
Left: <none or exact typed blocker with lane>
```

Rules:

- Russian only unless user requests another language.
- No logs, raw JSON, schemas, long explanations, secrets, raw internal links, or
  absolute runtime paths.
- Do not say Done when evidence is partial.
