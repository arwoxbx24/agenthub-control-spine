import test from "node:test";
import assert from "node:assert/strict";
import {
  assertAllowedOwner,
  normalizeArtifactPath,
  normalizeReadableControlPath
} from "../src/policy.js";

test("blocks personal owner by default", () => {
  assert.throws(() => assertAllowedOwner("arwoxb24"), /arwoxbx24/);
});

test("accepts safe artifact paths", () => {
  assert.equal(
    normalizeArtifactPath("reports/apps/AH-507-source-map.md"),
    "reports/apps/AH-507-source-map.md"
  );
});

test("blocks path traversal", () => {
  assert.throws(() => normalizeArtifactPath("../reports/apps/x.md"), /outside/);
});

test("blocks secret-like paths", () => {
  assert.throws(() => normalizeReadableControlPath(".env"), /blocked/i);
  assert.throws(() => normalizeArtifactPath("reports/apps/private-key.pem"), /blocked/i);
});

test("blocks writes outside artifact prefixes", () => {
  assert.throws(() => normalizeArtifactPath("README.md"), /limited/);
});
