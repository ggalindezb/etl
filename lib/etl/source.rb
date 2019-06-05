# frozen_string_literal: true

require 'csv'

module Etl
  # Source data from a give type and location
  class Source
    VALID_STATES = {
      initialized: 0,
      validated: 1,
      sourced: 2,
      failed: 3
    }.freeze

    include Status

    attr_accessor :type, :location, :data
    attr_reader :payload
    ACCEPTED_PARAMS = %i[type location data].freeze

    def initialize(params = {})
      ACCEPTED_PARAMS.each do |param|
        instance_variable_set "@#{param}".to_sym, params[param]
      end
      @payload = []
      initialized!
    end

    def validate
      strategy = source_strategy
      return false if strategy.nil?

      strategy.validate.tap { |x| x ? validated! : failed! }
    end

    def fetch
      strategy = source_strategy

      if strategy && validated?
        @payload = strategy.fetch
        sourced!
      else
        failed!
      end
    end

    private

    def source_strategy
      strategy_constant = "#{@type.to_s.upcase}Strategy"

      if Etl::Strategies.const_defined?(strategy_constant)
        @source_strategy ||= Etl::Strategies.const_get(strategy_constant).new(self)
      else
        failed!
        nil
      end
    end
  end
end
