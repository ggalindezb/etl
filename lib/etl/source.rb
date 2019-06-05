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

    # TODO: Validate the source on a per strategy basis
    # ie.
    # - File based location needs a file to exist
    # - CSV has commas
    # - JSON has brackets
    # - API yields 200
    def validate
      validate_strategy.tap { |x| x ? validated! : failed! }
    end

    # TODO: Run the given strategy
    def fetch
      validated? ? fetch_strategy : failed!
    end

    private

    # Placeholder methods. This will be replaced by a strategy
    def validate_strategy
      # @strategy.validate.tap
      case @type&.to_sym
      when :csv
        Pathname.new(@location).exist?
      else
        false
      end
    end

    def fetch_strategy
      case @type&.to_sym
      when :csv
        @payload = File.read(@location)
        sourced!
      end
    end
  end
end
