# frozen_string_literal: true

require 'mini_etl/version'

require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'mini_etl/util/status'
require 'mini_etl/strategy'
require 'mini_etl/strategies/csv_strategy'
require 'mini_etl/source'
require 'mini_etl/generator'
require 'mini_etl/process'

# Place exception here
module MiniEtl
  class << self
    def create_process(&block)
      return nil unless block_given?

      process = Process.new
      block.call(process)
      process
    end
  end
end
