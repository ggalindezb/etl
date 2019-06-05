# frozen_string_literal: true

module Support
  # Test files generation
  module Generation
    # COLUMNS = %w[name last_name nationality origin phone bank iban currency segment].freeze
    RECORD_SIZE = {
      small: 8_500,
      medium: 85_000,
      large: 825_000
    }.freeze

    def generate_csv(size)
      Dir.mkdir('samples') unless Dir.exist?('samples')

      File.open("samples/#{size}.csv", 'w') do |sample_file|
        RECORD_SIZE[size].times { sample_file.write(dummy_info) }
        sample_file.close
      end
    end

    def dummy_info
      "#{Faker::Name.first_name},#{Faker::Name.last_name},#{Faker::Nation.nationality},#{Faker::Nation.capital_city},"\
        "#{Faker::PhoneNumber.phone_number_with_country_code},#{Faker::Bank.name},#{Faker::Bank.iban},#{Faker::Currency.code},"\
        "#{Faker::IndustrySegments.industry}\n"
    rescue Faker::UniqueGenerator::RetryLimitExceeded
      Faker::UniqueGenerator.clear
    end
  end
end
