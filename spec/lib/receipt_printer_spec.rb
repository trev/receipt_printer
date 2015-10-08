require "spec_helper"
require "receipt_printer"

describe ReceiptPrinter do
  let(:input) do 
    "Quantity, Product, Price\n"\
    "1, book, 12.49\n"\
    "1, music cd, 14.99\n"\
    "1, chocolate bar, 0.85"
  end

  describe "#import_csv" do
    subject { described_class.new }

    it "requires a csv string and optional header boolean as parameters" do
      expect { subject.import_csv("String", true) }.not_to raise_error
    end

    context "with a valid csv string" do
      after { subject.import_csv(input) }

      it "initializes an instance of TaxReceipt" do
        expect(TaxReceipt).to receive(:new).and_call_original
      end

      it "gets the csv string parsed into an array" do
        expect(Parser).to receive(:parse_csv).and_call_original
      end

      it "adds the line items to the tax receipt" do
        expect_any_instance_of(TaxReceipt).to receive(:add_line_item).exactly(3).times
      end
    end
  end

  describe "#print_it" do
    before do 
      allow($stdout).to receive(:puts)
      subject.import_csv(input)
    end

    context "with example input 1" do
      it "should return a valid receipt with tax calculations" do
        expect{ subject.print_it }.to output("1, book, 12.49\n"\
                                          "1, music cd, 16.49\n"\
                                          "1, chocolate bar, 0.85\n"\
                                          "\n"\
                                          "Sales Taxes: 1.50\n"\
                                          "Total: 29.83").to_stdout
      end
    end

    context "with example input 2" do
      let(:input) { "Quantity, Product, Price\n"\
                    "1, imported box of chocolates, 10.00\n"\
                    "1, imported bottle of perfume, 47.50\n" }

      it "should return a valid receipt with tax calculations" do
        expect{ subject.print_it }.to output("1, imported box of chocolates, 10.50\n"\
                                          "1, imported bottle of perfume, 54.65\n"\
                                          "\n"\
                                          "Sales Taxes: 7.65\n"\
                                          "Total: 65.15").to_stdout
      end
    end

    context "with example input 3" do
      let(:input) { "Quantity, Product, Price\n"\
                    "1, imported bottle of perfume, 27.99\n"\
                    "1, bottle of perfume, 18.99\n"\
                    "1, packet of headache pills, 9.75\n"\
                    "1, imported box of chocolates, 11.25" }

      it "should return a valid receipt with tax calculations" do
        expect{ subject.print_it }.to output("1, imported bottle of perfume, 32.19\n"\
                                             "1, bottle of perfume, 20.89\n"\
                                             "1, packet of headache pills, 9.75\n"\
                                             "1, imported box of chocolates, 11.85\n"\
                                             "\n"\
                                             "Sales Taxes: 6.70\n"\
                                             "Total: 74.68").to_stdout
      end
    end
  end
end
