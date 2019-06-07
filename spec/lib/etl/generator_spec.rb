# frozen_string_literal: true

require 'spec_helper'

describe Etl::Generator do
  describe '#initialize' do
    subject { described_class.new }

    it 'instances a default new object' do
      expect(subject.lazy).to be false
      expect(subject.payload).to be_empty
      expect(subject).to be_initialized
    end
  end

  describe '#bootstrap' do
    context 'with valid params' do
      subject { described_class.new }

      it 'bootstrap a valid generator' do
        subject.bootstrap(:csv, [])
        expect(subject).to be_bootstrapped
      end
    end

    context 'with invalid params' do
      subject { described_class.new }

      it 'rejects nil params' do
        expect { subject.bootstrap(nil, nil) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#transform' do
    context 'with a bootstrapped generator' do
      subject { described_class.new }

      it 'transforms a source payload' do
        subject.bootstrap(:csv, 'a,b,c')
        subject.transform

        expect(subject).to be_transformed
        expect(subject.payload).not_to be_empty
        expect(subject.payload).to eq [%w[a b c]]
      end
    end

    context 'with an invalid generator' do
      subject { described_class.new }

      it 'rejects as failed' do
        subject.transform

        expect(subject).to be_failed
        expect(subject.payload).to be_empty
      end
    end
  end
end
