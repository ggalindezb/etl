# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

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

# COLUMNS = %w[name last_name nationality origin phone bank iban currency segment].freeze
RECORD_SIZE = {
  small: 8_500,
  medium: 85_000,
  large: 825000
}.freeze

def generate_csv(size)
  Dir.mkdir('samples') unless Dir.exist?('samples')

  File.open("samples/#{size}.csv", 'w') do |sample_file|
    RECORD_SIZE[size].times { sample_file.write(dummy_info) }
    sample_file.close
  end
end

def dummy_info
  "#{Faker::Name.first_name},#{Faker::Name.last_name},#{Faker::Nation.nationality},#{Faker::Nation.capital_city},"\
    "#{Faker::PhoneNumber.phone_number_with_country_code},#{Faker::Bank.name},#{Faker::Bank.iban},#{Faker::Currency.code},"\
    "#{Faker::IndustrySegments.industry}\n"
rescue Faker::UniqueGenerator::RetryLimitExceeded
  Faker::UniqueGenerator.clear
end
