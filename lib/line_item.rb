require "helpers/tax"
require "helpers/formatter"

class LineItem
  include Formatter

  def initialize(qty: 1, title: "Untitled", cost: BigDecimal.new("0"))
    @qty = BigDecimal.new(qty.to_s)
    @title = title
    @cost = BigDecimal.new(cost.to_s)
  end

  def to_s
    "#{@qty.to_i}, #{@title}, #{format_currency(total)}"
  end

  def sub_total
    @qty * @cost
  end

  def sales_tax
    Tax.amount_calculator(@title, sub_total)
  end

  def total
    sub_total + sales_tax
  end
end
