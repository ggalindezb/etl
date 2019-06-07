# frozen_string_literal: true

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
      strategy = Etl::Strategy.for(@type)
      return false && failed! if strategy.nil?

      strategy.validate(self).tap { |x| x ? validated! : failed! }
    end

    def fetch
      strategy = Etl::Strategy.for(@type)

      if strategy && validated?
        @payload = strategy.fetch(self)
        sourced!
      else
        failed!
      end
    end
  end
end
