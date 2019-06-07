# frozen_string_literal: true

require 'spec_helper'

describe Etl::Source do
  let(:source) { described_class.new(type: :csv, location: file_name) }

  describe '#new' do
    context 'with valid params' do
      subject { described_class.new(type: :csv, location: 'samples/small.csv') }

      it 'instances a source object' do
        expect(subject.instance_variables).to include(:@type, :@location)
        expect(subject.payload).to be_empty
        expect(subject).to be_initialized
      end
    end

    context 'with invalid params' do
      subject { described_class.new(type: :csv, invalid: 1, other: 2) }

      it 'rejects invalid params' do
        expect(subject.instance_variables).to include(:@type)
        expect(subject.instance_variables).not_to include(:@invalid, :@other)
        expect(subject.payload).to be_empty
        expect(subject).to be_initialized
      end
    end
  end

  describe '#validate' do
    subject { source.validate }

    context 'with a valid csv' do
      let(:file_name) { 'samples/small.csv' }
      let(:type) { :csv }
      it { is_expected.to be true }
    end

    context 'with an invalid csv' do
      let(:file_name) { 'samples/invalid.csv' }
      let(:type) { :csv }
      it { is_expected.to be false }
    end

    context 'with an invalid type' do
      let(:file_name) { 'samples/invalid.csv' }
      let(:type) { :invalid }
      it { is_expected.to be false }
    end
  end

  describe '#fetch' do
    before do
      source.validate
      source.fetch
    end

    subject { source }

    context 'with a valid csv' do
      let(:file_name) { 'samples/small.csv' }
      let(:type) { :csv }

      it 'fetches a payload' do
        expect(subject.payload).not_to be_empty
        expect(subject).to be_sourced
      end
    end

    context 'with an invalid csv' do
      let(:file_name) { 'samples/invalid.csv' }
      let(:type) { :csv }

      it 'fetches empty' do
        expect(subject.payload).to be_empty
        expect(subject).to be_failed
      end
    end
  end
end
