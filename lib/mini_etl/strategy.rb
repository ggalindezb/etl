# frozen_string_literal: true

module MiniEtl
  # Fetches a Strategy kind class for a given type of data
  # extraction/transformation
  class Strategy
    class << self
      def for(type)
        strategy_constant = "#{type.to_s.upcase}Strategy"
        Strategies.const_get(strategy_constant) if Strategies.const_defined?(strategy_constant)
      end
    end
  end
end
