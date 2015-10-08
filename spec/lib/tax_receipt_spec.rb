require "spec_helper"
require "tax_receipt"
require "bigdecimal"

describe TaxReceipt do
  let(:line_item1) do
    instance_double(
      LineItem,
      to_s: "Line item 1",
      sub_total: BigDecimal.new("20.00"),
      sales_tax: BigDecimal.new("1.15"),
      total: BigDecimal.new("21.15")
    )
  end
  let(:line_item2) do
    instance_double(
      LineItem,
      to_s: "Line item 2",
      sub_total: BigDecimal.new("25.00"),
      sales_tax: BigDecimal.new("2.05"),
      total: BigDecimal.new("26.05")
    )
  end

  before { subject.instance_variable_set(:@line_items, [line_item1, line_item2]) }

  describe "#to_s" do

    context "with a tax receipt containing line items" do
      it "returns a string representation of the receipt" do
        expect(subject.to_s).to be_kind_of(String)
      end

      it "contains the total sales tax for all items" do
        expect(subject.to_s).to match(/Sales Taxes: \d+\.\d{2}\b/)
      end

      it "contains the total for all items" do
        expect(subject.to_s).to match(/Total: \d+\.\d{2}\b/)
      end
    end
  end

  describe "#sales_tax" do
    it "sums the tax amount for all line items" do
      expect(subject.sales_tax).to eq(BigDecimal.new("3.20"))
    end
  end

  describe "#total" do
    it "sums the total amount for all line items" do
      expect(subject.total).to eq(BigDecimal.new("47.20"))
    end
  end
end
