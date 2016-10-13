require 'spec_helper'

describe Objectifier::ArrayValue do
  let(:name) { "foo" }
  let(:args) {
    {
      type: type,
      required: required,
    }
  }
  let(:type) { String }
  let(:required) { false }

  describe "::new" do
    subject { described_class.new(name, args) }

    it { is_expected.to be_a described_class }
    it { is_expected.not_to be_required }

    context "when value is required" do
      let(:required) { true }
      it { is_expected.to be_required }
    end

    context "with nil name" do
      let(:name) { nil }
      it "raises an error" do
        expect { subject }.to raise_error(ArgumentError, "name required")
      end
    end

    context "without type" do
      let(:args) {
        {
          required: required
        }
      }

      it "raises an error" do
        expect { subject }.to raise_error(ArgumentError, "type required")
      end
    end
  end

  describe "#call" do
    subject { described_class.new(name, args).call(parameters) }

    context "when the value is required" do
      let(:required) { true }

      context "when the value is present" do
        let(:parameters) {
          {
            "foo" => ["bar"],
            "bar" => ["baz"],
            "baz" => ["foo"],
          }
        }

        it { is_expected.to be_success }
        it { is_expected.to be_value}
        it "contains the correct value" do
          expect(subject.value).to eq ["bar"]
        end
      end

      context "when the value is not present" do
        let(:parameters) {
          {
            "bar" => ["baz"],
            "baz" => ["foo"],
          }
        }

        it { is_expected.not_to be_success }
        it { is_expected.not_to be_value}
      end
    end

    context "when the value is not required" do
      let(:required) { false }

      context "when the value is present" do
        let(:parameters) {
          {
            "foo" => ["bar"],
            "bar" => ["baz"],
            "baz" => ["foo"],
          }
        }

        it { is_expected.to be_success }
        it { is_expected.to be_value}
        it "contains the correct value" do
          expect(subject.value).to eq ["bar"]
        end
      end

      context "when the value is not present" do
        let(:parameters) {
          {
            "bar" => ["baz"],
            "baz" => ["foo"],
          }
        }

        it { is_expected.to be_success }
        it { is_expected.not_to be_value}
      end
    end
  end
end
