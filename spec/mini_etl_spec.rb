# frozen_string_literal: true

require 'spec_helper'

describe MiniEtl do
  it 'has a version number' do
    expect(MiniEtl::VERSION).not_to be nil
  end

  describe '.create_process' do
    let(:file_name) { 'samples/small.csv' }

    context 'with valid params' do
      subject do
        MiniEtl.create_process do |process|
          process.source.type = :csv
          process.source.location = file_name
        end
      end

      it 'instances a configured process' do
        expect(subject.status).to be_zero
        expect(subject).to be_initialized
        expect(subject.class).to eq MiniEtl::Process
      end
    end
  end
end
