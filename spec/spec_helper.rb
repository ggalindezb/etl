# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
SimpleCov.add_filter ['Rakefile', 'lib/tasks']

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'bundler/setup'
require 'etl'
require 'pry'
require 'rake'
load 'Rakefile'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.expose_dsl_globally = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.default_formatter = 'doc' if config.files_to_run.one?
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.filter_run_when_matching :focus
  config.order = :random
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.warnings = true

  config.before(:suite) do
    unless Pathname.new('samples/small.csv').exist?
      puts 'Sample files unavailable. Creating...'
      Rake::Task['sample:csv:small'].invoke
      puts 'Done.'
    end
  end
end
