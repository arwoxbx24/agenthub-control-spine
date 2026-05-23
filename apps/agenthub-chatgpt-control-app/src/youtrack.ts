import { PolicyError, RUN_ID } from "./policy.js";

export async function createOrUpdateYouTrackTask(input: {
  task_id?: string;
  summary?: string;
  evidence?: string;
}): Promise<{ status: string; task_id: string | null; blocker?: string }> {
  const baseUrl = process.env.YOUTRACK_BASE_URL;
  const token = process.env.YOUTRACK_TOKEN;
  if (!baseUrl || !token) {
    return {
      status: "BLOCKED",
      task_id: input.task_id ?? null,
      blocker: "BLOCKER_YOUTRACK_UNAVAILABLE"
    };
  }
  throw new PolicyError(
    "YOUTRACK_WRITE_NOT_IMPLEMENTED_IN_PROTOTYPE",
    `RUN_ID ${RUN_ID} has a task card created by control plane; server-side YouTrack write route needs final API binding.`
  );
}
