module Etl
  module Strategies
    # Extract/Transform strategy for a CSV input
    class CSVStrategy
      def initialize(source)
        @source = source
      end

      def validate
        Pathname.new(@source.location).exist?
      end

      def fetch
        File.read(@source.location)
      end
    end
  end
end
