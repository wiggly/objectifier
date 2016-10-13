require 'spec_helper'

describe Objectifier::SuccessResult do
  subject { described_class.new("foo") }

  describe "#success?" do
    it { is_expected.to be_success }
  end

  describe "#value?" do
    it { is_expected.not_to be_value }
  end
end

describe Objectifier::ValueResult do
  subject { described_class.new("foo", true) }

  describe "#success?" do
    it { is_expected.to be_success }
  end

  describe "#value?" do
    it { is_expected.to be_value }
  end
end

describe Objectifier::ErrorResult do
  subject { described_class.new }

  describe "#success?" do
    it { is_expected.not_to be_success }
  end

  describe "#value?" do
    it { is_expected.not_to be_value }
  end
end
