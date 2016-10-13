require 'spec_helper'

describe Objectifier do
  it 'has a version number' do
    expect(Objectifier::VERSION).not_to be nil
  end

  pending "define"

  pending "factories"
end

# describe Objectifier::ScalarValue do
#   let(:name) { "foo" }
#   let(:args) {
#     {
#       type: type,
#       required: required,
#     }
#   }
#   let(:type) { String }
#   let(:required) { false }

#   describe "::new" do
#     subject { described_class.new(name, args) }

#     it { is_expected.to be_a described_class }
#     it { is_expected.not_to be_required }

#     context "when value is required" do
#       let(:required) { true }
#       it { is_expected.to be_required }
#     end

#     context "with nil name" do
#       let(:name) { nil }
#       it "raises an error" do
#         expect { subject }.to raise_error(ArgumentError, "name required")
#       end
#     end

#     context "without type" do
#       let(:args) {
#         {
#           required: required
#         }
#       }

#       it "raises an error" do
#         expect { subject }.to raise_error(ArgumentError, "type required")
#       end
#     end
#   end

#   describe "#call" do
#     subject { described_class.new(name, args).call(parameters) }

#     context "when the value is required" do
#       let(:required) { true }

#       context "when the value is present" do
#         let(:parameters) {
#           {
#             "foo" => "bar",
#             "bar" => "baz",
#             "baz" => "foo",
#           }
#         }

#         it { is_expected.to be_success }
#         it { is_expected.to be_value}
#         it "contains the correct value" do
#           expect(subject.value).to eq "bar"
#         end
#       end

#       context "when the value is not present" do
#         let(:parameters) {
#           {
#             "bar" => "baz",
#             "baz" => "foo",
#           }
#         }

#         it { is_expected.not_to be_success }
#         it { is_expected.not_to be_value}
#       end
#     end

#     context "when the value is not required" do
#       let(:required) { false }

#       context "when the value is present" do
#         let(:parameters) {
#           {
#             "foo" => "bar",
#             "bar" => "baz",
#             "baz" => "foo",
#           }
#         }

#         it { is_expected.to be_success }
#         it { is_expected.to be_value}
#         it "contains the correct value" do
#           expect(subject.value).to eq "bar"
#         end
#       end

#       context "when the value is not present" do
#         let(:parameters) {
#           {
#             "bar" => "baz",
#             "baz" => "foo",
#           }
#         }

#         it { is_expected.to be_success }
#         it { is_expected.not_to be_value}
#       end
#     end
#   end
# end

# describe Objectifier::ArrayValue do
#   let(:name) { "foo" }
#   let(:args) {
#     {
#       type: type,
#       required: required,
#     }
#   }
#   let(:type) { String }
#   let(:required) { false }

#   describe "::new" do
#     subject { described_class.new(name, args) }

#     it { is_expected.to be_a described_class }
#     it { is_expected.not_to be_required }

#     context "when value is required" do
#       let(:required) { true }
#       it { is_expected.to be_required }
#     end

#     context "with nil name" do
#       let(:name) { nil }
#       it "raises an error" do
#         expect { subject }.to raise_error(ArgumentError, "name required")
#       end
#     end

#     context "without type" do
#       let(:args) {
#         {
#           required: required
#         }
#       }

#       it "raises an error" do
#         expect { subject }.to raise_error(ArgumentError, "type required")
#       end
#     end
#   end

#   describe "#call" do
#     subject { described_class.new(name, args).call(parameters) }

#     context "when the value is required" do
#       let(:required) { true }

#       context "when the value is present" do
#         let(:parameters) {
#           {
#             "foo" => ["bar"],
#             "bar" => ["baz"],
#             "baz" => ["foo"],
#           }
#         }

#         it { is_expected.to be_success }
#         it { is_expected.to be_value}
#         it "contains the correct value" do
#           expect(subject.value).to eq ["bar"]
#         end
#       end

#       context "when the value is not present" do
#         let(:parameters) {
#           {
#             "bar" => ["baz"],
#             "baz" => ["foo"],
#           }
#         }

#         it { is_expected.not_to be_success }
#         it { is_expected.not_to be_value}
#       end
#     end

#     context "when the value is not required" do
#       let(:required) { false }

#       context "when the value is present" do
#         let(:parameters) {
#           {
#             "foo" => ["bar"],
#             "bar" => ["baz"],
#             "baz" => ["foo"],
#           }
#         }

#         it { is_expected.to be_success }
#         it { is_expected.to be_value}
#         it "contains the correct value" do
#           expect(subject.value).to eq ["bar"]
#         end
#       end

#       context "when the value is not present" do
#         let(:parameters) {
#           {
#             "bar" => ["baz"],
#             "baz" => ["foo"],
#           }
#         }

#         it { is_expected.to be_success }
#         it { is_expected.not_to be_value}
#       end
#     end
#   end
# end

# describe Objectifier::MapValue do
#   let(:name) { "foo" }

#   describe "::new" do
#     subject {
#       described_class.new(name) do
#       end
#     }

#     it { is_expected.to be_a described_class }
#     it { is_expected.not_to be_required }

#     context "with nil name" do
#       let(:name) { nil }

#       it "defaults to the empty string" do
#         expect(subject.name).to eq ""
#       end
#     end

#     context "with a child value" do
#       context "that is required" do
#         subject {
#           described_class.new(name) do
#             item :foo, type: String, required: true
#           end
#         }

#         it { is_expected.to be_required }
#       end

#       context "that is not required" do
#         subject {
#           described_class.new(name) do
#             item :foo, type: String, required: false
#           end
#         }

#         it { is_expected.not_to be_required }
#       end
#     end
#   end

#   describe "#call" do
#     # with no children

#     # with a child that is not required

#     # and the child is present

#     # and the child is absent

#     # with a child that is required

#     # and the child is present

#     # and the child is absent

#     context "with no children"

#     context "when the value is required" do
#       subject {
#         described_class.new(name) do
#           item :bar, type: String, required: true
#         end.call(parameters)
#       }

#       context "when the value is present" do
#         let(:parameters) {
#           {
#             "foo" => { "bar" => "baz" },
#             "baz" => { "bar" => "foo" },
#           }
#         }

#         it { is_expected.to be_success }
#         it { is_expected.to be_value}
#         it "contains the correct value" do
#           expect(subject.value).to eq({ "bar" => "baz" })
#         end
#       end

#       context "when the value is not present" do
#         let(:parameters) {
#           {
#             "baz" => { "bar" => "foo" },
#           }
#         }

#         it { is_expected.not_to be_success }
#         it { is_expected.not_to be_value}
#       end
#     end

#     context "when the value is not required" do
#       subject {
#         described_class.new(name) do
#           item :bar, type: String, required: false
#         end.call(parameters)
#       }

#       context "when the value is present" do
#         let(:parameters) {
#           {
#             "foo" => { "bar" => "baz" },
#             "baz" => { "bar" => "foo" },
#           }
#         }

#         it { is_expected.to be_success }
#         it { is_expected.to be_value}
#         it "contains the correct value" do
#           expect(subject.value).to eq({ "bar" => "baz" })
#         end
#       end

#       context "when the value is not present" do
#         let(:parameters) {
#           {
#             "baz" => { "bar" => "foo" },
#           }
#         }

#         it { is_expected.to be_success }
#         it { is_expected.not_to be_value}
#       end
#     end
#   end
# end
