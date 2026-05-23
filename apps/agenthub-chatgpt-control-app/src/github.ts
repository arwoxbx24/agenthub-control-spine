import { Octokit } from "@octokit/rest";
import {
  CONTROL_REPO,
  CONTROL_REPO_FULL_NAME,
  DEFAULT_OWNER,
  PolicyError,
  assertAllowedOwner,
  assertControlRepository,
  normalizeArtifactPath,
  normalizeReadableControlPath
} from "./policy.js";

function octokit(): Octokit {
  const token = process.env.GITHUB_TOKEN;
  if (!token) {
    throw new PolicyError(
      "BLOCKER_GITHUB_APP_CREDENTIAL_ROUTE_MISSING",
      "Server-side GitHub credential route is not configured."
    );
  }
  return new Octokit({ auth: token });
}

export async function listAllowedRepositories(): Promise<Array<{ full_name: string; private: boolean; default_branch: string }>> {
  const client = octokit();
  const repos = await client.paginate(client.repos.listForOrg, {
    org: DEFAULT_OWNER,
    per_page: 100,
    type: "all"
  });
  return repos.map((repo) => ({
    full_name: repo.full_name,
    private: Boolean(repo.private),
    default_branch: repo.default_branch ?? "main"
  }));
}

export async function readControlSpineFile(path: string, ref = "main"): Promise<{ path: string; content: string; sha: string }> {
  const safePath = normalizeReadableControlPath(path);
  const client = octokit();
  const response = await client.repos.getContent({
    owner: DEFAULT_OWNER,
    repo: CONTROL_REPO,
    path: safePath,
    ref
  });
  if (Array.isArray(response.data) || response.data.type !== "file" || !("content" in response.data)) {
    throw new PolicyError("NOT_A_FILE", "Requested path is not a file.");
  }
  return {
    path: safePath,
    content: Buffer.from(response.data.content, "base64").toString("utf8"),
    sha: response.data.sha
  };
}

export async function createBranchCommitPr(params: {
  branch: string;
  title: string;
  body: string;
  files: Array<{ path: string; content: string }>;
}): Promise<{ branch: string; pr_url: string; pr_number: number }> {
  const branch = assertScopedBranch(params.branch);
  const client = octokit();
  const { data: repo } = await client.repos.get({ owner: DEFAULT_OWNER, repo: CONTROL_REPO });
  const base = repo.default_branch;

  const existingPulls = await client.pulls.list({
    owner: DEFAULT_OWNER,
    repo: CONTROL_REPO,
    head: `${DEFAULT_OWNER}:${branch}`,
    state: "open"
  });
  const existingPull = existingPulls.data[0];

  const { data: baseRef } = await client.git.getRef({ owner: DEFAULT_OWNER, repo: CONTROL_REPO, ref: `heads/${base}` });
  try {
    await client.git.createRef({
      owner: DEFAULT_OWNER,
      repo: CONTROL_REPO,
      ref: `refs/heads/${branch}`,
      sha: baseRef.object.sha
    });
  } catch (error: unknown) {
    if (!String(error).includes("Reference already exists")) {
      throw error;
    }
  }

  for (const file of params.files) {
    const safePath = normalizeArtifactPath(file.path);
    let sha: string | undefined;
    try {
      const existing = await client.repos.getContent({
        owner: DEFAULT_OWNER,
        repo: CONTROL_REPO,
        branch,
        path: safePath,
        ref: branch
      });
      if (!Array.isArray(existing.data) && existing.data.type === "file") {
        sha = existing.data.sha;
      }
    } catch (error: unknown) {
      if (!String(error).includes("Not Found")) {
        throw error;
      }
    }
    await client.repos.createOrUpdateFileContents({
      owner: DEFAULT_OWNER,
      repo: CONTROL_REPO,
      branch,
      path: safePath,
      message: `AH-507: update ${safePath}`,
      content: Buffer.from(file.content, "utf8").toString("base64"),
      sha
    });
  }

  if (existingPull) {
    return { branch, pr_url: existingPull.html_url, pr_number: existingPull.number };
  }

  const { data: pr } = await client.pulls.create({
    owner: DEFAULT_OWNER,
    repo: CONTROL_REPO,
    base,
    head: branch,
    title: params.title,
    body: params.body,
    maintainer_can_modify: false
  });
  return { branch, pr_url: pr.html_url, pr_number: pr.number };
}

export async function createControlSpineArtifact(params: {
  path: string;
  content: string;
  branch?: string;
}): Promise<{ branch: string; path: string; pr_url: string; pr_number: number }> {
  const safePath = normalizeArtifactPath(params.path);
  const branch = params.branch ?? `agenthub/AH-507-artifact-${Date.now()}`;
  const result = await createBranchCommitPr({
    branch,
    title: `AH-507: create ${safePath}`,
    body: `Controlled artifact creation for ${CONTROL_REPO_FULL_NAME}.`,
    files: [{ path: safePath, content: params.content }]
  });
  return { ...result, path: safePath };
}

export async function githubWriteProof(): Promise<{ branch: string; path: string; pr_url: string; pr_number: number }> {
  const path = `reports/write-proof/AH-507-chatgpt-control-app-write-proof.md`;
  const content = [
    "---",
    "artifact_id: AH-507-chatgpt-control-app-write-proof",
    "artifact_type: write-proof",
    "source_task: AH-507",
    "status: created-by-app-tool",
    "---",
    "",
    "# Write Proof",
    "",
    "This harmless file is created only by the controlled ChatGPT MCP app write-proof tool.",
    "It must not be created by the ordinary ChatGPT GitHub connector when used as final acceptance proof.",
    ""
  ].join("\n");
  return createControlSpineArtifact({
    path,
    content,
    branch: "agenthub/AH-507-chatgpt-control-app-write-proof"
  });
}

export async function mergePullRequestControlled(prNumber: number): Promise<{ merged: boolean; message: string }> {
  if (!Number.isInteger(prNumber) || prNumber <= 0) {
    throw new PolicyError("INVALID_PR_NUMBER", "Pull request number must be a positive integer.");
  }
  throw new PolicyError(
    "MERGE_GATE_BLOCKED",
    "Controlled merge requires status checks and approval evidence; this prototype intentionally blocks automatic merge."
  );
}

export async function updateControlSpineArtifact(params: {
  path: string;
  content: string;
  sha: string;
  branch: string;
}): Promise<{ path: string; commit_sha: string }> {
  const safePath = normalizeArtifactPath(params.path);
  const branch = assertScopedBranch(params.branch);
  const client = octokit();
  const response = await client.repos.createOrUpdateFileContents({
    owner: DEFAULT_OWNER,
    repo: CONTROL_REPO,
    path: safePath,
    branch,
    message: `AH-507: update ${safePath}`,
    content: Buffer.from(params.content, "utf8").toString("base64"),
    sha: params.sha
  });
  return { path: safePath, commit_sha: response.data.commit.sha ?? "UNKNOWN" };
}

export function validateRepository(owner = DEFAULT_OWNER, repo = CONTROL_REPO): { owner: string; repo: string } {
  assertControlRepository(owner, repo);
  return { owner, repo };
}

function assertScopedBranch(branch: string): string {
  if (!/^agenthub\/AH-507-[A-Za-z0-9._-]+$/.test(branch)) {
    throw new PolicyError("BRANCH_SCOPE_BLOCKED", "Branch must stay under agenthub/AH-507-*.");
  }
  return branch;
}
