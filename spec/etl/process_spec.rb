# frozen_string_literal: true

require 'spec_helper'

describe Etl::Process do
  let(:file_name) { 'samples/small.csv' }

  describe 'Process creation' do
    context 'with valid params' do
      subject do
        Etl.create_process do |process|
          process.source.type = :csv
          process.source.location = file_name
        end
      end

      it 'can bootstrap a new process' do
        expect(subject.status).to be_zero
        expect(subject.source.payload).to be_empty
        subject.bootstrap
        expect(subject.source.payload).not_to be_empty
      end

      it 'can run a bootstrapped process' do
        expect(subject.status).to be_zero
        subject.bootstrap
        subject.run
        expect(subject).to be_finished
      end
    end

    context 'with invalid params' do
      subject do
        Etl.create_process do |process|
          process.source.type = :unsupported
          process.source.location = file_name
        end
      end

      it 'fails to bootstrap' do
        expect(subject).to be_initialized
        subject.bootstrap
        expect(subject).to be_failed
      end
    end
  end
end
