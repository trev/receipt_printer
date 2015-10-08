require "tax_receipt"
require "line_item"
require "helpers/parser"

class ReceiptPrinter
  def import_csv(csv, header = true)
    @tax_receipt = TaxReceipt.new
    line_items = Parser.parse_csv(csv, header)
    line_items.each do |line_item|
      @tax_receipt.add_line_item LineItem.new(line_item)
    end
  end

  def print_it
    print @tax_receipt.to_s
  end
end
