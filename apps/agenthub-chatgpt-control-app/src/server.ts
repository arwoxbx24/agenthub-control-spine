import express from "express";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StreamableHTTPServerTransport } from "@modelcontextprotocol/sdk/server/streamableHttp.js";
import { z } from "zod";
import { audit } from "./audit.js";
import {
  APP_VERSION,
  CONTROL_REPO_FULL_NAME,
  DEFAULT_OWNER,
  PolicyError,
  RUN_ID
} from "./policy.js";
import {
  createBranchCommitPr,
  createControlSpineArtifact,
  githubWriteProof,
  listAllowedRepositories,
  mergePullRequestControlled,
  readControlSpineFile,
  updateControlSpineArtifact,
  validateRepository
} from "./github.js";
import { createOrUpdateYouTrackTask } from "./youtrack.js";

const server = new McpServer({
  name: "AgentHub Control App",
  version: APP_VERSION
});

function result(data: Record<string, unknown>) {
  return {
    structuredContent: data,
    content: [{ type: "text" as const, text: JSON.stringify(data) }]
  };
}

function errorResult(error: unknown) {
  const code = error instanceof PolicyError ? error.code : "UNEXPECTED_ERROR";
  const message = error instanceof Error ? error.message : "Unknown error";
  return result({ status: "BLOCKED", code, message });
}

server.registerTool(
  "health_check",
  {
    title: "Health check",
    description: "Return connector version and build metadata without secrets.",
    annotations: { readOnlyHint: true, destructiveHint: false, openWorldHint: false },
    inputSchema: {}
  },
  async () => {
    await audit("health_check", { ok: true });
    return result({
      status: "PASS",
      run_id: RUN_ID,
      version: APP_VERSION,
      default_owner: DEFAULT_OWNER,
      control_repository: CONTROL_REPO_FULL_NAME,
      secrets_returned: false
    });
  }
);

server.registerTool(
  "list_allowed_repositories",
  {
    title: "List allowed repositories",
    description: "List repositories visible to the server-side integration for the arwoxbx24 organization only.",
    annotations: { readOnlyHint: true, destructiveHint: false, openWorldHint: false },
    inputSchema: {}
  },
  async () => {
    try {
      const repositories = await listAllowedRepositories();
      await audit("list_allowed_repositories", { count: repositories.length });
      return result({ status: "PASS", repositories });
    } catch (error) {
      await audit("list_allowed_repositories_blocked", { error });
      return errorResult(error);
    }
  }
);

server.registerTool(
  "read_control_spine_file",
  {
    title: "Read control spine file",
    description: "Read a safe non-secret file from arwoxbx24/agenthub-control-spine.",
    annotations: { readOnlyHint: true, destructiveHint: false, openWorldHint: false },
    inputSchema: {
      path: z.string().min(1),
      ref: z.string().optional()
    }
  },
  async ({ path, ref }) => {
    try {
      const file = await readControlSpineFile(path, ref);
      await audit("read_control_spine_file", { path: file.path, ref });
      return result({ status: "PASS", ...file });
    } catch (error) {
      await audit("read_control_spine_file_blocked", { path, error });
      return errorResult(error);
    }
  }
);

server.registerTool(
  "create_control_spine_artifact",
  {
    title: "Create control spine artifact",
    description: "Create a safe prompt, report, receipt, or write-proof artifact through a scoped branch and pull request.",
    annotations: { readOnlyHint: false, destructiveHint: false, openWorldHint: true },
    inputSchema: {
      path: z.string().min(1),
      content: z.string().min(1),
      branch: z.string().optional()
    }
  },
  async (input) => {
    try {
      const created = await createControlSpineArtifact(input);
      await audit("create_control_spine_artifact", { path: created.path, branch: created.branch, pr: created.pr_number });
      return result({ status: "PASS", ...created });
    } catch (error) {
      await audit("create_control_spine_artifact_blocked", { path: input.path, error });
      return errorResult(error);
    }
  }
);

server.registerTool(
  "update_control_spine_artifact",
  {
    title: "Update control spine artifact",
    description: "Update a safe artifact on a scoped branch using an expected blob SHA.",
    annotations: { readOnlyHint: false, destructiveHint: false, openWorldHint: true },
    inputSchema: {
      path: z.string().min(1),
      content: z.string().min(1),
      sha: z.string().min(1),
      branch: z.string().min(1)
    }
  },
  async (input) => {
    try {
      const updated = await updateControlSpineArtifact(input);
      await audit("update_control_spine_artifact", { path: updated.path, branch: input.branch });
      return result({ status: "PASS", ...updated });
    } catch (error) {
      await audit("update_control_spine_artifact_blocked", { path: input.path, error });
      return errorResult(error);
    }
  }
);

server.registerTool(
  "github_write_proof",
  {
    title: "GitHub write proof",
    description: "Create one harmless write-proof artifact through the app-controlled GitHub route.",
    annotations: { readOnlyHint: false, destructiveHint: false, openWorldHint: true },
    inputSchema: {}
  },
  async () => {
    try {
      const proof = await githubWriteProof();
      await audit("github_write_proof", { path: proof.path, pr: proof.pr_number });
      return result({ status: "PASS", ...proof });
    } catch (error) {
      await audit("github_write_proof_blocked", { error });
      return errorResult(error);
    }
  }
);

server.registerTool(
  "create_branch_commit_pr",
  {
    title: "Create branch commit PR",
    description: "Create or reuse a scoped branch and pull request for safe artifact changes.",
    annotations: { readOnlyHint: false, destructiveHint: false, openWorldHint: true },
    inputSchema: {
      branch: z.string().min(1),
      title: z.string().min(1),
      body: z.string().min(1),
      files: z.array(z.object({ path: z.string().min(1), content: z.string().min(1) })).min(1)
    }
  },
  async (input) => {
    try {
      const pr = await createBranchCommitPr(input);
      await audit("create_branch_commit_pr", { branch: pr.branch, pr: pr.pr_number, file_count: input.files.length });
      return result({ status: "PASS", ...pr });
    } catch (error) {
      await audit("create_branch_commit_pr_blocked", { branch: input.branch, error });
      return errorResult(error);
    }
  }
);

server.registerTool(
  "merge_pull_request_controlled",
  {
    title: "Merge pull request controlled",
    description: "Merge only scoped PRs after policy checks and approvals; prototype blocks automatic merge until gates are wired.",
    annotations: { readOnlyHint: false, destructiveHint: false, openWorldHint: true },
    inputSchema: {
      pr_number: z.number().int().positive()
    }
  },
  async ({ pr_number }) => {
    try {
      const merged = await mergePullRequestControlled(pr_number);
      await audit("merge_pull_request_controlled", { pr_number, merged: merged.merged });
      return result({ status: "PASS", ...merged });
    } catch (error) {
      await audit("merge_pull_request_controlled_blocked", { pr_number, error });
      return errorResult(error);
    }
  }
);

server.registerTool(
  "create_or_update_youtrack_task",
  {
    title: "Create or update YouTrack task",
    description: "Create or update exactly one YouTrack implementation task after duplicate checks.",
    annotations: { readOnlyHint: false, destructiveHint: false, openWorldHint: false },
    inputSchema: {
      task_id: z.string().optional(),
      summary: z.string().optional(),
      evidence: z.string().optional()
    }
  },
  async (input) => {
    const task = await createOrUpdateYouTrackTask(input);
    await audit("create_or_update_youtrack_task", { task_id: task.task_id, status: task.status });
    return result(task);
  }
);

server.registerTool(
  "create_or_update_y outrack_task",
  {
    title: "Create or update YouTrack task legacy alias",
    description: "Compatibility alias for the misspelled MVP tool name; use create_or_update_youtrack_task in new calls.",
    annotations: { readOnlyHint: false, destructiveHint: false, openWorldHint: false },
    inputSchema: {
      task_id: z.string().optional(),
      summary: z.string().optional(),
      evidence: z.string().optional()
    }
  },
  async (input) => {
    const task = await createOrUpdateYouTrackTask(input);
    await audit("create_or_update_y outrack_task", { task_id: task.task_id, status: task.status });
    return result(task);
  }
);

server.registerTool(
  "record_receipt",
  {
    title: "Record receipt",
    description: "Create a receipt artifact through the safe artifact branch/PR route.",
    annotations: { readOnlyHint: false, destructiveHint: false, openWorldHint: true },
    inputSchema: {
      status: z.enum(["PASS", "PARTIAL", "BLOCKED"]),
      content: z.string().min(1)
    }
  },
  async ({ status, content }) => {
    try {
      validateRepository();
      const created = await createControlSpineArtifact({
        path: "reports/receipts/AH-507-chatgpt-control-app-bootstrap-receipt.md",
        content,
        branch: `agenthub/AH-507-receipt-${status.toLowerCase()}`
      });
      await audit("record_receipt", { status, path: created.path, pr: created.pr_number });
      return result({ status: "PASS", receipt_status: status, ...created });
    } catch (error) {
      await audit("record_receipt_blocked", { status, error });
      return errorResult(error);
    }
  }
);

const app = express();
app.use(express.json({ limit: "1mb" }));

app.get("/healthz", (_req, res) => {
  res.json({ status: "ok", version: APP_VERSION, run_id: RUN_ID });
});

app.post("/mcp", async (req, res) => {
  const transport = new StreamableHTTPServerTransport({
    sessionIdGenerator: undefined
  });
  res.on("close", () => {
    transport.close().catch(() => undefined);
    server.close().catch(() => undefined);
  });
  await server.connect(transport);
  await transport.handleRequest(req, res, req.body);
});

const port = Number(process.env.PORT ?? 8787);

if (process.env.NODE_ENV !== "test") {
  app.listen(port, () => {
    console.log(JSON.stringify({ status: "listening", port, run_id: RUN_ID }));
  });
}

export { app, server };
