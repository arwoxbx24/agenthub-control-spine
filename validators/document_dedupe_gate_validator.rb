#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "json"

FAIL_LIFECYCLES = %w[
  active_policy current_policy active_control active_schema current_context_pack
  current_baseline active_source active_template active_runbook
].freeze

SOFT_LIFECYCLES = %w[
  audit_only operational_receipt historical_receipt consumed_prompt superseded
  quarantine quarantined deleted_policy_violation
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def normalize(value)
  value.to_s.downcase.gsub(/[`*_#|]/, " ").gsub(/[^a-z0-9]+/, " ").strip
end

def normalized_family(path)
  base = File.basename(path.to_s, ".*")
  return nil if %w[fixtures README SKILL index register].include?(base)

  family = normalize(base.gsub(/\b(20\d{6}|20\d{4}|19\d{4}|v\d+|final|copy|draft|audit|receipt|validation|report)\b/i, " "))
  "#{File.dirname(path.to_s)}:#{family}"
end

def content_digest(content)
  Digest::SHA256.hexdigest(normalize(content))
end

def first_heading(content, path = nil)
  return nil unless path.to_s.end_with?(".md", ".txt")

  content.to_s.each_line.find { |line| line.match?(/^#+\s+/) }.to_s.sub(/^#+\s*/, "").strip
end

def signature(record)
  heading = first_heading(record["content"].to_s, record["path"])
  return nil if blank?(record["title"]) && blank?(record["artifact_id"]) && blank?(heading)

  [
    normalize(record["title"] || heading || File.basename(record["path"].to_s, ".*")),
    normalize(heading)
  ].join(":")
end

def severity_for(records)
  lifecycles = records.map { |record| record["lifecycle"].to_s }
  return "FAIL" if (lifecycles & FAIL_LIFECYCLES).any?
  return "WARN" if (lifecycles & SOFT_LIFECYCLES).any?

  "FAIL"
end

def add_group_findings(findings, records, key, code)
  records.group_by { |record| key.call(record) }
         .each do |value, group|
    next if blank?(value) || group.length < 2

    findings << {
      "severity" => severity_for(group),
      "code" => code,
      "value" => value,
      "paths" => group.map { |record| record["path"] }
    }
  end
end

def evaluate_records(records, path_rows: [], register_rows: [])
  findings = []

  add_group_findings(findings, path_rows.map { |path| { "path" => path, "lifecycle" => "active_control" } }, ->(r) { r["path"] }, "DUPLICATE_INDEX_PATH")
  add_group_findings(findings, register_rows.map { |path| { "path" => path, "lifecycle" => "active_control" } }, ->(r) { r["path"] }, "DUPLICATE_REGISTER_PATH")
  add_group_findings(findings, records, ->(r) { r["artifact_id"] }, "DUPLICATE_ARTIFACT_ID")

  active_records = records.select { |record| FAIL_LIFECYCLES.include?(record["lifecycle"].to_s) }
  soft_records = records.select { |record| SOFT_LIFECYCLES.include?(record["lifecycle"].to_s) }
  add_group_findings(findings, active_records, ->(r) { normalized_family(r["path"]) }, "ACTIVE_DUPLICATE_PATH_FAMILY")
  add_group_findings(findings, active_records, ->(r) { [r["source_task"], r["scope_signature"]].join(":") if !blank?(r["scope_signature"]) }, "DUPLICATE_SOURCE_TASK_SCOPE")
  add_group_findings(findings, active_records, ->(r) { content_digest(r["content"]) unless blank?(r["content"]) }, "ACTIVE_DUPLICATE_CONTENT_DIGEST")
  add_group_findings(findings, active_records, ->(r) { signature(r) }, "ACTIVE_NEAR_DUPLICATE_SIGNATURE")
  add_group_findings(findings, soft_records, ->(r) { signature(r) }, "SOFT_NEAR_DUPLICATE_SIGNATURE")

  records.each do |record|
    lifecycle = record["lifecycle"].to_s
    default_load = record["default_load"] == true || record["default_load"].to_s == "true"
    safe_to_replay = record["safe_to_replay"] == true || record["safe_to_replay"].to_s == "true"
    used_as_instruction = record["used_as_instruction"] == true

    if lifecycle == "consumed_prompt" && (default_load || safe_to_replay || used_as_instruction)
      findings << { "severity" => "FAIL", "code" => "CONSUMED_PROMPT_REPLAYED_AS_ACTIVE", "paths" => [record["path"]] }
    end

    if lifecycle == "audit_only" && (default_load || used_as_instruction)
      findings << { "severity" => "FAIL", "code" => "AUDIT_ONLY_USED_AS_INSTRUCTION", "paths" => [record["path"]] }
    end
  end

  findings
end

def table_paths(path)
  return [] unless File.exist?(path)

  File.readlines(path).filter_map do |line|
    match = line.match(/^\|\s*`([^`]+)`\s*\|/)
    match && match[1]
  end
end

def register_records(path)
  return [] unless File.exist?(path)

  File.readlines(path).filter_map do |line|
    match = line.match(/^\|\s*`([^`]+)`\s*\|\s*`?([^`|]+)`?\s*\|\s*([^|]+)\|\s*([^|]+)\|\s*([^|]+)\|/)
    next unless match

    {
      "path" => match[1].strip,
      "lifecycle" => match[2].strip,
      "default_load" => match[3].strip == "true",
      "safe_to_replay" => match[4].strip == "true",
      "source_task" => match[5].strip
    }
  end
end

def frontmatter_value(content, key)
  content.to_s.lines.each do |line|
    match = line.match(/^#{Regexp.escape(key)}:\s*(.+?)\s*$/)
    return match[1].strip if match
  end
  nil
end

def enrich_from_files(records, repo_root)
  records.map do |record|
    file = File.join(repo_root, record["path"].to_s)
    next record unless File.file?(file)

    content = File.read(file)
    record.merge(
      "artifact_id" => frontmatter_value(content, "artifact_id"),
      "scope_signature" => frontmatter_value(content, "scope_signature"),
      "content" => content
    )
  end
end

def run_fixture(path)
  doc = JSON.parse(File.read(path))
  cases = doc.fetch("cases")
  failures = cases.filter_map do |item|
    input = item.fetch("input")
    findings = evaluate_records(
      input.fetch("records", []),
      path_rows: input.fetch("index_paths", []),
      register_rows: input.fetch("register_paths", [])
    )
    actual = findings.any? { |finding| finding["severity"] == "FAIL" } ? "FAIL" : findings.any? { |finding| finding["severity"] == "WARN" } ? "WARN" : "PASS"
    expected = item.fetch("expected")
    next if actual == expected

    { "id" => item.fetch("id"), "expected" => expected, "actual" => actual, "findings" => findings }
  end

  if failures.empty?
    puts JSON.pretty_generate({ "status" => "PASS", "cases" => cases.length, "validator" => File.basename(__FILE__) })
  else
    warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
    exit 1
  end
end

def run_repo_scan(repo_root)
  index_paths = table_paths(File.join(repo_root, "INDEX.md"))
  register_path_rows = table_paths(File.join(repo_root, "ARTIFACT_REGISTER.md"))
  records = enrich_from_files(register_records(File.join(repo_root, "ARTIFACT_REGISTER.md")), repo_root)
  findings = evaluate_records(records, path_rows: index_paths, register_rows: register_path_rows)
  failures = findings.select { |finding| finding["severity"] == "FAIL" }

  payload = { "status" => failures.empty? ? "PASS" : "FAIL", "findings" => findings, "validator" => File.basename(__FILE__) }
  if failures.empty?
    puts JSON.pretty_generate(payload)
  else
    warn JSON.pretty_generate(payload)
    exit 1
  end
end

if ARGV[0]&.end_with?(".json")
  run_fixture(ARGV[0])
else
  run_repo_scan(Dir.pwd)
end
