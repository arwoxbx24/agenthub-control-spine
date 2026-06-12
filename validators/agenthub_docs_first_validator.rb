#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
failures = []
Array(doc['cases']).each do |c|
  i = c.fetch('input')
  actual = if i['official_docs_url'].to_s.empty? || Array(i['claims_supported']).empty?
             'DOCS_SOURCE_PACKET_MISSING'
           elsif i['stage_after'] == 'Preview' && i['docs_packet'] != 'PASS'
             'DOCS_SOURCE_PACKET_BLOCKS_PREVIEW'
           else
             'PASS'
           end
  failures << { id: c['id'], expected: c['expected'], actual: actual } unless actual == c['expected']
end
abort(JSON.pretty_generate(status: 'FAIL', failures: failures)) unless failures.empty?
puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), cases: doc['cases'].length)
