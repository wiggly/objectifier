require 'spec_helper'

describe Objectifier::MapValue do
  let(:name) { "foo" }

  describe "::new" do
    subject {
      described_class.new(name) do
      end
    }

    it { is_expected.to be_a described_class }
    it { is_expected.not_to be_required }

    context "with nil name" do
      let(:name) { nil }

      it "defaults to the empty string" do
        expect(subject.name).to eq ""
      end
    end

    context "with a child value" do
      context "that is required" do
        subject {
          described_class.new(name) do
            item :foo, type: :string, required: true
          end
        }

        it { is_expected.to be_required }
      end

      context "that is not required" do
        subject {
          described_class.new(name) do
            item :foo, type: :string, required: false
          end
        }

        it { is_expected.not_to be_required }
      end
    end
  end

  describe "#call" do
    # with no children

    # with a child that is not required

    # and the child is present

    # and the child is absent

    # with a child that is required

    # and the child is present

    # and the child is absent

    context "with no children"

    context "when the value is required" do
      subject {
        described_class.new(name) do
          item :bar, type: :string, required: true
        end.call(parameters)
      }

      context "when the value is present" do
        let(:parameters) {
          {
            "foo" => { "bar" => "baz" },
            "baz" => { "bar" => "foo" },
          }
        }

        it { is_expected.to be_success }
        it { is_expected.to be_value}
        it "contains the correct value" do
          expect(subject.value).to eq({ "bar" => "baz" })
        end
      end

      context "when the value is not present" do
        let(:parameters) {
          {
            "baz" => { "bar" => "foo" },
          }
        }

        it { is_expected.not_to be_success }
        it { is_expected.not_to be_value}
      end
    end

    context "when the value is not required" do
      subject {
        described_class.new(name) do
          item :bar, type: :string, required: false
        end.call(parameters)
      }

      context "when the value is present" do
        let(:parameters) {
          {
            "foo" => { "bar" => "baz" },
            "baz" => { "bar" => "foo" },
          }
        }

        it { is_expected.to be_success }
        it { is_expected.to be_value}
        it "contains the correct value" do
          expect(subject.value).to eq({ "bar" => "baz" })
        end
      end

      context "when the value is not present" do
        let(:parameters) {
          {
            "baz" => { "bar" => "foo" },
          }
        }

        it { is_expected.to be_success }
        it { is_expected.not_to be_value}
      end
    end
  end
end
