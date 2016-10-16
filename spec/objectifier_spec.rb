require 'spec_helper'

describe Objectifier do
  it 'has a version number' do
    expect(Objectifier::VERSION).not_to be nil
  end

  describe "::define" do
    subject do
      described_class.define do
      end
    end

    it { is_expected.to be_a Objectifier::MapValue }
  end

  describe "::factories" do
    subject { described_class.factories }

    it { is_expected.to be_a Objectifier::TransformerFactory }
  end
end
