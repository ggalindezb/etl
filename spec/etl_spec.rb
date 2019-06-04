# frozen_string_literal: true

require 'spec_helper'
require 'rake'
load 'Rakefile'

describe Etl do
  it 'has a version number' do
    expect(Etl::VERSION).not_to be nil
  end

  describe '.create_process' do
    let(:file_name) { 'samples/small.csv' }

    before do
      unless Pathname.new(file_name).exist?
        puts 'Sample files unavailable. Creating...'
        Rake::Task['sample:csv:small'].invoke
      end
    end

    context 'with valid params' do
      subject do
        Etl.create_process do |process|
          process.source.type = 'csv'
          process.source.location = file_name
        end
      end

      it 'yields an initialized process object' do
        expect(subject.class).to eq Etl::Process
        expect(subject.status).to be_zero
      end
    end
  end
end
