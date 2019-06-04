# frozen_string_literal: true

require 'csv'

module Etl
  # Source data from a give type and location
  class Source
    attr_accessor :type, :location, :data
    attr_reader :payload

    # TODO: Validate the source on a per strategy basis
    # ie.
    # - File based location needs a file to exist
    # - CSV has commas
    # - JSON has brackets
    # - API yields 200
    def validate
      case @type
      when :csv
        Pathname.new(@location).exist?
      else
        false
      end
    end

    # TODO: Run the given strategy
    def fetch
      @payload = File.read(@location)
    end
  end
end
