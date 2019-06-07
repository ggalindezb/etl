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
      check_dir

      File.open("samples/#{size}.csv", 'w') do |sample_file|
        RECORD_SIZE[size].times { sample_file.write(dummy_data.join(',')) }
        sample_file.close
      end
    end

    def generate_json(size)
      check_dir

      File.open("samples/#{size}.json", 'w') do |sample_file|
        sample_file.write('[')
        RECORD_SIZE[size].pred.times { sample_file.write(json_string + ',') }
        sample_file.write(json_string + ']')
        sample_file.close
      end
    end

    private

    def check_dir
      Dir.mkdir('samples') unless Dir.exist?('samples')
    end

    def dummy_names
      %i[name last_name nationality capital_city phone_number bank iban currency industry]
    end

    def dummy_data
      [Faker::Name.first_name, Faker::Name.last_name, Faker::Nation.nationality, Faker::Nation.capital_city,
       Faker::PhoneNumber.phone_number_with_country_code, Faker::Bank.name, Faker::Bank.iban, Faker::Currency.code, Faker::IndustrySegments.industry]
    rescue Faker::UniqueGenerator::RetryLimitExceeded
      Faker::UniqueGenerator.clear
    end

    def json_string
      JSON.dump(Hash[dummy_names.zip(dummy_data)])
    end
  end
end
