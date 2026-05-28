#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

blocked = cases.select { |item| item.fetch("input").fetch("actor_role") == "T0_CONTROL" }
failures = blocked.filter_map do |item|
  action = item.fetch("input").fetch("action_class")
  expected = item.fetch("expected")
  actual = %w[
    SHELL COMMAND DOCKER DOCKER_COMPOSE PYTHON BASH NODE PHP RUBY GO YC TWC NPM
    GIT_MUTATION PRODUCT_FILE_WRITE PRODUCT_CONFIG_EDIT PRODUCT_TEST_EXECUTION
    SECRET_ENV_DUMP SECRET_READ DATABASE NPM_PROXY_MANAGER DNS_SSL FIREWALL
    APP_RUNTIME BROAD_FILESYSTEM_SCAN
  ].include?(action) ? "BLOCKED_T0_DIRECT_AUTHORSHIP" : "ALLOW_CONTROL_ONLY"
  next if actual == expected

  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate({ "status" => "PASS", "cases" => blocked.length, "validator" => File.basename(__FILE__) })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
