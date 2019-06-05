# frozen_string_literal: true

require 'etl/version'

require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'etl/util/status'
require 'etl/strategies/csv_strategy'
require 'etl/process'
require 'etl/source'

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
