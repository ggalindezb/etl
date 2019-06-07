# frozen_string_literal: true

module Support
  # Generates dummy files for testing with the same quantity of data, different
  # file sizes, which depend on the output's format
  module Generation
    RECORD_SIZE = {
      small: 8_500,
      medium: 85_000,
      large: 825_000
    }.freeze

    def generate_csv(size)
      dummy_file(size, :csv) { |sample_file| RECORD_SIZE[size].times { sample_file.write(csv_string) } }
    end

    def generate_json(size)
      dummy_file(size, :json) do |sample_file|
        sample_file.write('[')
        RECORD_SIZE[size].pred.times { sample_file.write(json_string + ',') }
        sample_file.write(json_string + ']')
      end
    end

    private

    def check_dir
      Dir.mkdir('samples') unless Dir.exist?('samples')
    end

    def dummy_file(size, type)
      check_dir

      File.open("samples/#{size}.#{type}", 'w') do |sample_file|
        yield sample_file
        sample_file.close
      end
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

    def csv_string
      dummy_data.join(',') + "\n"
    end

    def json_string
      JSON.dump(Hash[dummy_names.zip(dummy_data)])
    end
  end
end
