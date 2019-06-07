# frozen_string_literal: true

module MiniEtl
  # Track a status
  module Status
    DEFAULT_STATES = {
      initialized: 0,
      finished: 1,
      failed: 2
    }.freeze

    def self.included(base)
      attr_reader :status

      states = base.const_defined?(:VALID_STATES) ? base.const_get(:VALID_STATES) : DEFAULT_STATES
      states.each do |verb, value|
        define_method "#{verb}?".to_sym do
          @status == value
        end

        define_method "#{verb}!".to_sym do
          @status = value
        end
      end
    end
  end
end
