# frozen_string_literal: true

module Etl
  # ETL Process wrapper
  # Should this go all the way?
  # Probably
  class Process
    include Status
    attr_accessor :source

    def initialize
      @status = 0
      @source = Source.new
      initialized!
    end

    def bootstrap
      if initialized? && @source.validate
        @source.fetch
        bootstrapped!
      else
        failed!
      end
    end

    def run
      # TODO: Parse it, bear in mind this will be in memory and may need to be split
      # TODO: Transform it into useful bits
      # This may be done in rails. Provide a useful interface in that case
      # TODO: Load the thing wherever it needs to go
      if bootstrapped?
      else
        failed!
      end
    end
  end
end
