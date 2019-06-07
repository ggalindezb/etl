# frozen_string_literal: true

module Etl
  # ETL Process wrapper
  # Should this go all the way?
  # Probably
  class Process
    VALID_STATES = {
      initialized: 0,
      bootstrapped: 1,
      generated: 2,
      finished: 3,
      failed: 4
    }.freeze

    include Status
    attr_reader :source, :generator

    def initialize
      @source = Source.new
      @generator = Generator.new

      initialized!
    end

    def bootstrap
      if initialized? && @source.validate
        @source.fetch
        @generator.bootstrap(@source.type, @source.payload)
        bootstrapped!
      else
        failed!
      end
    end

    def generate
      # TODO: Parse it, bear in mind this will be in memory and may need to be split
      # TODO: Transform it into useful bits
      # This may be done in rails. Provide a useful interface in that case
      # TODO: Load the thing wherever it needs to go
      if bootstrapped?
        @generator.transform
        generated!
      else
        failed!
      end
    end
  end
end
