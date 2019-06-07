require 'csv'

module MiniEtl
  module Strategies
    # Extract/Transform strategy for a CSV input
    class CSVStrategy
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
