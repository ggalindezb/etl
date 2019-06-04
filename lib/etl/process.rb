# frozen_string_literal: true

module Etl
  # ETL Process wrapper
  # Should this go all the way?
  # Probably
  class Process
    attr_accessor :source
    attr_reader :status
    # Status: Maybe add an event machine here?
    # 0 = Initialized
    # 1 = Loaded
    # 2 = Finished
    # 3 = Error

    def initialize
      @status = 0
      @source = Source.new
    end
  end
end
