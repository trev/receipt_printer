require "spec_helper"
require "helpers/tax"

describe Tax do

  describe ".amount_calculator" do
  end

  describe ".rate_calculator" do
    subject { described_class.rate_calculator(item) }
    let(:item) { "Car" }

    it "returns a BigDecimal" do
      is_expected.to be_kind_of(BigDecimal)
    end

    context "for non-imported products" do

      context "when given a food product" do
        let(:item) { "chocolate" }

        it { is_expected.to eq(BigDecimal("0")) }
      end

      context "when given a book product" do
        let(:item) { "book" }

        it { is_expected.to eq(BigDecimal("0")) }
      end

      context "when given a medicine product" do
        let(:item) { "pills" }

        it { is_expected.to eq(BigDecimal("0")) }
      end

      context "when given a product which isn't food, a book or medicine" do
        let(:item) { "a box of kittens" }

        it { is_expected.to eq(BigDecimal("0.1")) }
      end
    end

    context "for imported products" do

      context "when given a food product" do
        let(:item) { "imported chocolate" }

        it { is_expected.to eq(BigDecimal("0.05")) }
      end

      context "when given a book product" do
        let(:item) { "imported book" }

        it { is_expected.to eq(BigDecimal("0.05")) }
      end

      context "when given a medicine product" do
        let(:item) { "imported pills" }

        it { is_expected.to eq(BigDecimal("0.05")) }
      end

      context "when given a product which isn't food, a book or medicine" do
        let(:item) { "a box of imported kittens" }

        it { is_expected.to eq(BigDecimal("0.15")) }
      end
    end
  end
end
