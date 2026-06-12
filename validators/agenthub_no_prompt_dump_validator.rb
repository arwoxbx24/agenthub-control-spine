#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
failures = []
Array(doc['cases']).each do |c|
  i = c.fetch('input')
  actual = if i.fetch('chat_prompt_words', 0).to_i > 500 || i['printed_full_prompt']
             'PROMPT_DUMP_BLOCKED'
           elsif i['final_output_format'] != 'Fact/Action/Left'
             'FINAL_OUTPUT_FORMAT_FAILED'
           else
             'PASS'
           end
  failures << { id: c['id'], expected: c['expected'], actual: actual } unless actual == c['expected']
end
abort(JSON.pretty_generate(status: 'FAIL', failures: failures)) unless failures.empty?
puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), cases: doc['cases'].length)
