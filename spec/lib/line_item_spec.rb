require "spec_helper"
require "line_item"

describe LineItem do
  subject { described_class.new(line_item) }
  let(:line_item) { { qty: 2, title: "Bear Dog", cost: 1999.94 } }

  describe "#new" do
    it "accepts a hash with qty, title & cost keyword arguments" do
      expect { subject }.to_not raise_error
    end
  end

  describe "#to_s" do
    it "returns a string representation of the processed line item" do
      expect(subject.to_s).to eq("2, Bear Dog, 4399.88")
    end
  end

  describe "#sub_total" do
    it "returns the item cost multiplied by its quantity" do
      expect(subject.sub_total).to eq(BigDecimal.new("3999.88"))
    end
  end

  describe "#sales_tax" do
    it "returns the item's sales tax amount" do
      expect(subject.sales_tax).to eq(BigDecimal.new("400"))
    end
  end

  describe "#total" do
    it "returns the sum of the sub total and sales tax" do
      expect(subject.total).to eq(BigDecimal.new("4399.88"))
    end
  end
end
