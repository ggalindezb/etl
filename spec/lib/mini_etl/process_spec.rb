# frozen_string_literal: true

require 'spec_helper'

describe MiniEtl::Process do
  describe '#initialize' do
    subject { described_class.new }
    it { is_expected.to be_initialized }
  end

  describe '#bootstrap' do
    subject do
      MiniEtl.create_process do |process|
        process.source.type = type
        process.source.location = location
      end
    end

    context 'with valid params' do
      let(:type) { :csv }
      let(:location) { 'samples/small.csv' }

      it 'can bootstrap a new process' do
        expect(subject).to be_initialized
        subject.bootstrap
        expect(subject).to be_bootstrapped
      end
    end

    context 'with invalid params' do
      let(:type) { :invalid }
      let(:location) { 'samples/invalid.csv' }

      it 'fails to bootstrap' do
        expect(subject).to be_initialized
        subject.bootstrap
        expect(subject).to be_failed
      end
    end
  end

  describe '#generate' do
    subject do
      MiniEtl.create_process do |process|
        process.source.type = type
        process.source.location = location
      end
    end

    context 'with valid params' do
      let(:type) { :csv }
      let(:location) { 'samples/small.csv' }

      it 'can bootstrap a new process' do
        expect(subject).to be_initialized
        subject.bootstrap
        subject.generate
        expect(subject).to be_generated
      end
    end

    context 'with invalid params' do
      let(:type) { :invalid }
      let(:location) { 'samples/invalid.csv' }

      it 'fails to bootstrap' do
        expect(subject).to be_initialized
        subject.bootstrap
        subject.generate
        expect(subject).to be_failed
      end
    end
  end
end
