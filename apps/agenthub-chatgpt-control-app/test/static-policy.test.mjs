import { readFileSync, readdirSync, statSync } from "node:fs";
import { join } from "node:path";
import assert from "node:assert/strict";

const root = new URL("../src", import.meta.url).pathname;
const files = [];

function walk(dir) {
  for (const entry of readdirSync(dir)) {
    const path = join(dir, entry);
    if (entry === "node_modules" || entry === "dist" || entry === ".git" || entry === "test") continue;
    if (statSync(path).isDirectory()) walk(path);
    else files.push(path);
  }
}

walk(root);

const combined = files.map((path) => readFileSync(path, "utf8")).join("\n");

assert.equal(/delete[_-]?repo|deleteRepository|repos\.delete/i.test(combined), false, "repository deletion surface must not exist");
assert.equal(/gh[pousr]_[A-Za-z0-9_]+/.test(combined), false, "GitHub tokens must not be committed");
assert.equal(/sk-[A-Za-z0-9_-]{20,}/.test(combined), false, "OpenAI API keys must not be committed");

console.log(JSON.stringify({ status: "PASS", files_scanned: files.length }));
