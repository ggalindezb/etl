# frozen_string_literal: true

require 'etl/version'

require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'etl/util/status'
require 'etl/strategy'
require 'etl/strategies/csv_strategy'
require 'etl/source'
require 'etl/generator'
require 'etl/process'

# Place exception here
module Etl
  class << self
    def create_process(&block)
      return nil unless block_given?

      process = Process.new
      block.call(process)
      process
    end
  end
end
