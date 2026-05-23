export const RUN_ID = "AH-CHATGPT-APP-BOOTSTRAP-20260523";
export const APP_VERSION = "0.1.0";
export const DEFAULT_OWNER = "arwoxbx24";
export const CONTROL_REPO = "agenthub-control-spine";
export const CONTROL_REPO_FULL_NAME = `${DEFAULT_OWNER}/${CONTROL_REPO}`;

const allowedPrefixes = [
  "prompts/apps/",
  "reports/apps/",
  "reports/receipts/",
  "reports/write-proof/"
];

const blockedPathPatterns = [
  /(^|\/)\.env($|\.)/i,
  /(^|\/)\.ssh($|\/)/i,
  /(^|\/)secrets?($|\/)/i,
  /(^|\/)private[-_]?key/i,
  /(^|\/).*\.pem$/i,
  /(^|\/).*\.key$/i,
  /(^|\/).*transcript/i,
  /(^|\/).*history/i
];

export function assertAllowedOwner(owner: string): void {
  if (owner !== DEFAULT_OWNER) {
    throw new PolicyError("OWNER_NOT_ALLOWED", "Only arwoxbx24 repositories are allowed by default.");
  }
}

export function assertControlRepository(owner: string, repo: string): void {
  assertAllowedOwner(owner);
  if (repo !== CONTROL_REPO) {
    throw new PolicyError("REPOSITORY_NOT_ALLOWED", "Only the canonical control spine repository is allowed for writes.");
  }
}

export function normalizeArtifactPath(path: string): string {
  const normalized = path.replace(/\\/g, "/").replace(/^\/+/, "");
  if (!normalized || normalized.includes("..") || normalized.startsWith(".git/")) {
    throw new PolicyError("PATH_TRAVERSAL_BLOCKED", "Path is outside the allowed artifact surface.");
  }
  if (blockedPathPatterns.some((pattern) => pattern.test(normalized))) {
    throw new PolicyError("SECRET_PATH_BLOCKED", "Secret-bearing or transcript-like paths are blocked.");
  }
  if (!allowedPrefixes.some((prefix) => normalized.startsWith(prefix))) {
    throw new PolicyError("PATH_PREFIX_BLOCKED", "Writes are limited to prompt, report, receipt, and write-proof artifacts.");
  }
  return normalized;
}

export function normalizeReadableControlPath(path: string): string {
  const normalized = path.replace(/\\/g, "/").replace(/^\/+/, "");
  if (!normalized || normalized.includes("..") || normalized.startsWith(".git/")) {
    throw new PolicyError("PATH_TRAVERSAL_BLOCKED", "Path is outside the readable repository surface.");
  }
  if (blockedPathPatterns.some((pattern) => pattern.test(normalized))) {
    throw new PolicyError("SECRET_PATH_BLOCKED", "Secret-bearing or transcript-like paths are blocked.");
  }
  return normalized;
}

export function redact(input: unknown): string {
  return JSON.stringify(input)
    .replace(/gh[pousr]_[A-Za-z0-9_]+/g, "gh*_REDACTED")
    .replace(/sk-[A-Za-z0-9_-]+/g, "sk-REDACTED")
    .replace(/Bearer\s+[A-Za-z0-9._-]+/gi, "Bearer REDACTED")
    .replace(/"token"\s*:\s*"[^"]+"/gi, "\"token\":\"REDACTED\"")
    .replace(/"authorization"\s*:\s*"[^"]+"/gi, "\"authorization\":\"REDACTED\"");
}

export class PolicyError extends Error {
  constructor(public code: string, message: string) {
    super(message);
    this.name = "PolicyError";
  }
}
