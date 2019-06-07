# frozen_string_literal: true

module Etl
  # Generate record information from a source
  class Generator
    VALID_STATES = {
      initialized: 0,
      bootstrapped: 1,
      transformed: 2,
      failed: 3
    }.freeze

    include Status

    attr_accessor :lazy, :data
    attr_writer :type
    attr_reader :payload

    # TODO: This needs to know the type of the receiver
    def initialize
      @lazy = false
      initialized!
    end

    def bootstrap(type, data)
      @type = type
      @data = data
      bootstrapped!
    end

    def transform
      failed! && return unless bootstrapped?

      strategy = Etl::Strategy.for(@type)
      @payload = strategy.generate(@data)
      transformed!
    end

    # TODO: This needs to feed a block with source data, to stream a structure
    # generation instead of doing it in place
    # def start
    #   yield @structure.next if @lazy && block_given?
    # end
  end
end
