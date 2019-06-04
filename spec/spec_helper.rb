# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'bundler/setup'
require 'etl'

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
end
