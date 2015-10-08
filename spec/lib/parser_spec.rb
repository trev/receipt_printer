require "spec_helper"
require "helpers/parser"

describe Parser do
  describe ".parse_csv" do
    let(:csv) do
      "Quantity, Product, Price\n"\
      "1, book, 12.49\n"\
      "1, music cd, 14.99\n"\
      "1, chocolate bar, 0.85"
    end

    it "requires a csv string and a header boolean as parameters" do
      expect { subject.parse_csv("String", true) }.not_to raise_error
    end

    it "parses a csv into an array" do
      expect(subject.parse_csv(csv, true)).to be_kind_of(Array)
    end

    context "with header set to false" do

      it "returns an unmodified array" do
        expect(subject.parse_csv(csv, false).count).to eq(4)
      end
    end

    context "with header set to true" do

      it "returns an array with the first item removed" do
        expect(subject.parse_csv(csv, true).count).to eq(3)
      end
    end
  end
end
