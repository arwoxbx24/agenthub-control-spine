#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
failures = []
Array(doc['cases']).each do |c|
  i = c.fetch('input')
  actual = if i['raw_secret_exposed']
             'RAW_SECRET_OUTPUT_BLOCKED'
           elsif i['requires_db_write'] && !i['lane7_approved']
             'OWNER_ONLY_IRREVERSIBLE_DB_CHANGE_APPROVAL_REQUIRED'
           elsif i['final_blocker'] == 'OWNER_ONLY_SECRET_HANDLE_CREATION_REQUIRED' && (!i['registry_checked'] || !i['docs_checked'] || i['auth_probe'] == 'not_attempted')
             'SECRET_HANDLE_EXHAUSTION_REQUIRED'
           elsif i['auth_probe'] == 'no_handle' && i['guide_created']
             'OWNER_ONLY_SECRET_HANDLE_CREATION_REQUIRED'
           elsif i['auth_probe'] == 'pass'
             'CONTINUE_REPAIR'
           else
             'PACKFIX_SECRET_HANDLE_RESOLUTION_REQUIRED'
           end
  failures << { id: c['id'], expected: c['expected'], actual: actual } unless actual == c['expected']
end
abort(JSON.pretty_generate(status: 'FAIL', failures: failures)) unless failures.empty?
puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), cases: doc['cases'].length)
