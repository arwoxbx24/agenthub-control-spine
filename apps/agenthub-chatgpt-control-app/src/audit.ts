import { mkdir, appendFile } from "node:fs/promises";
import { dirname } from "node:path";
import { redact, RUN_ID } from "./policy.js";

const auditPath = process.env.AGENTHUB_AUDIT_LOG_PATH ?? "logs/audit.jsonl";

export async function audit(event: string, payload: Record<string, unknown>): Promise<void> {
  const line = {
    at: new Date().toISOString(),
    run_id: RUN_ID,
    event,
    payload: JSON.parse(redact(payload))
  };
  await mkdir(dirname(auditPath), { recursive: true });
  await appendFile(auditPath, `${JSON.stringify(line)}\n`, { encoding: "utf8" });
}
