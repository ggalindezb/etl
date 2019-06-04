# frozen_string_literal: true

require 'spec_helper'

describe Etl do
  it 'has a version number' do
    expect(Etl::VERSION).not_to be nil
  end

  describe '.create_process' do
    context 'with valid params' do
      subject do
        Etl.create_process do |process|
          process.source.type = 'csv'
          # More config options
          # process.source.type = 'csv'
          # process.source.location = 'tmp/person.csv'
        end
      end

      it 'yields an initialized process object' do
        expect(subject.class).to eq Etl::Process
        expect(subject.status).to be_zero
      end
    end
  end
end
