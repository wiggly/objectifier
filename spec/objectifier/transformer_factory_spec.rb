require 'spec_helper'

describe Objectifier::TransformerFactory do
  describe "#for_type" do
    let(:factory) { described_class.new }

    let(:transformer) { factory.for_type(type) }

    subject { transformer }

    context "Symbol" do
      let(:type) { Symbol }

      it "has a transformer" do
        expect(subject).to be_a Proc
      end

      describe "transformation" do
        subject { transformer.call("x", input) }

        context "given a symbol" do
          let(:input) { :symbol }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to be :symbol
          end
        end

        context "given a string" do
          let(:input) { "symbol" }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to be :symbol
          end
        end
      end
    end

    context "String" do
      let(:type) { String }

      it "has a transformer" do
        expect(subject).to be_a Proc
      end

      describe "transformation" do
        subject { transformer.call("x", input) }

        context "given a string" do
          let(:input) { "string" }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq "string"
          end
        end

        context "given a symbol" do
          let(:input) { :string }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq "string"
          end
        end
      end
    end

    context "Integer" do
      let(:type) { Integer }

      it "has a transformer" do
        expect(subject).to be_a Proc
      end

      describe "transformation" do
        subject { transformer.call("x", input) }

        context "given 0" do
          let(:input) { 0 }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (0)
          end
        end

        context "given -1" do
          let(:input) { -1 }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (-1)
          end
        end

        context "given 1" do
          let(:input) { 1 }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (1)
          end
        end

        context "given 1.0" do
          let(:input) { 1.0 }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (1)
          end
        end

        context "given 1.1" do
          let(:input) { 1.1 }

          it { is_expected.to be_success }

          it "truncates the value to an integer" do
            expect(subject.value).to eq (1)
          end
        end

        context "given '0'" do
          let(:input) { '0' }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (0)
          end
        end

        context "given '-1'" do
          let(:input) { '-1' }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (-1)
          end
        end

        context "given '1'" do
          let(:input) { '1' }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (1)
          end
        end

        context "given '1.0'" do
          let(:input) { '1.0' }

          it { is_expected.not_to be_success }
        end

        context "given '1.1'" do
          let(:input) { '1.1' }

          it { is_expected.not_to be_success }
        end

        context "given 'NaN'" do
          let(:input) { 'NaN' }

          it { is_expected.not_to be_success }
        end

      end
    end

    context "Fixnum" do
      let(:type) { Fixnum }

      it "has a transformer" do
        expect(subject).to be_a Proc
      end

      it "is the same as Integer" do
        expect(subject).to be factory.for_type(Integer)
      end
    end

    context "Bignum" do
      let(:type) { Bignum }

      it "has a transformer" do
        expect(subject).to be_a Proc
      end

      it "is the same as Integer" do
        expect(subject).to be factory.for_type(Integer)
      end
    end

    context "Float" do
      let(:type) { Float }

      it "has a transformer" do
        expect(subject).to be_a Proc
      end

      describe "transformation" do
        subject { transformer.call("x", input) }

        context "given 0" do
          let(:input) { 0 }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (0.0)
          end
        end

        context "given -1" do
          let(:input) { -1 }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (-1.0)
          end
        end

        context "given 1" do
          let(:input) { 1 }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (1.0)
          end
        end

        context "given 1.0" do
          let(:input) { 1.0 }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (1.0)
          end
        end

        context "given 1.1" do
          let(:input) { 1.1 }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (1.1)
          end
        end

        context "given '0'" do
          let(:input) { '0' }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (0.0)
          end
        end

        context "given '-1'" do
          let(:input) { '-1' }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (-1.0)
          end
        end

        context "given '1'" do
          let(:input) { '1' }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (1.0)
          end
        end

        context "given '1.0'" do
          let(:input) { '1.0' }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (1.0)
          end
        end

        context "given '1.1'" do
          let(:input) { '1.1' }

          it { is_expected.to be_success }

          it "has the correct value" do
            expect(subject.value).to eq (1.1)
          end
        end

        context "given 'NaN'" do
          let(:input) { 'NaN' }

          it { is_expected.not_to be_success }
        end
      end
    end
  end
end
