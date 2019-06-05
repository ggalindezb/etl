# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require_relative 'lib/tasks/support/generation'

require 'rubygems'
require 'bundler'
Bundler.require(:default, :development)

RSpec::Core::RakeTask.new(:spec)

task default: :spec_n_cop

task :spec_n_cop do
  Rake::Task['spec'].invoke
  require 'rubocop'
  cli = RuboCop::CLI.new
  cli.run
end

namespace :sample do
  include Support::Generation

  namespace :csv do
    desc 'Generate CSV samples'
    task :all do
      generate_csv(:small)
      generate_csv(:medium)
      generate_csv(:large)
    end

    desc 'Generate a CSV sample, ~1 MB'
    task :small do
      generate_csv(:small)
    end

    desc 'Generate a CSV sample, ~10 MB'
    task :medium do
      generate_csv(:medium)
    end

    desc 'Generate a CSV sample, ~100 MB'
    task :large do
      generate_csv(:large)
    end
  end
end
