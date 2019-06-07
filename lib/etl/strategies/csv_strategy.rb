require 'csv'

module Etl
  module Strategies
    # Extract/Transform strategy for a CSV input
    class CSVStrategy
      # TODO: These should probably be class methods with a source receiver,
      # so no objects need to be passed

      def initialize(source)
        @source = source
        raise ArgumentError # No objects should be instanced
      end

      class << self
        def validate(source)
          Pathname.new(source.location).exist?
        end

        def fetch(source)
          File.read(source.location)
        end

        def generate(data)
          CSV.parse(data)
        end
      end
    end
  end
end
