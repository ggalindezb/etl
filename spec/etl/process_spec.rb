# frozen_string_literal: true

require 'spec_helper'
require 'rake'
load 'Rakefile'

describe Etl::Process do
  let(:file_name) { 'samples/small.csv' }

  before do
    unless Pathname.new(file_name).exist?
      puts 'Sample files unavailable. Creating...'
      Rake::Task['sample:csv:small'].invoke
    end
  end

  describe 'Process creation' do
    context 'with valid params' do
      subject do
        Etl.create_process do |process|
          process.source.type = :csv
          process.source.location = file_name
        end
      end

      it 'bootstraps a source' do
        expect(subject.status).to be_zero
        expect(subject.source.payload).to be_nil
        subject.bootstrap
        expect(subject.source.payload).not_to be_nil
      end
    end
  end
end
