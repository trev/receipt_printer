require "helpers/formatter"

class TaxReceipt
  include Formatter

  def initialize
    @line_items = []
  end

  def to_s
    @line_items.map(&:to_s).join("\n") +
    "\n\n" +
    "Sales Taxes: #{format_currency(sales_tax)}\n" +
    "Total: #{format_currency(total)}"
  end

  def add_line_item(line_item)
    @line_items << line_item
  end

  %w(sales_tax total).each do |figure|
    define_method(figure) do
      @line_items.map(&figure.to_sym).inject(0, :+)
    end
  end
end
