require "helpers/bigdecimal_extras"

module Tax
  GST = {
    rate: BigDecimal.new("0.10"),
    exclude: /book|chocolate|pills/i
  }

  DUTY = {
    rate: BigDecimal.new("0.05"),
    include: /imported/i
  }

  def self.amount_calculator(item, figure)
    (figure * rate_calculator(item)).round(2).round_up_to_nearest(0.05)
  end

  def self.rate_calculator(item)
    rate = BigDecimal.new("0")
    rate += GST[:rate] unless GST[:exclude] =~ item
    rate += DUTY[:rate] if DUTY[:include] =~ item
    rate
  end
end
