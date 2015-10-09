require "bigdecimal"

class BigDecimal
  def round_up_to_nearest(n)
    if self % n == 0
      self
    else
      self + n - (self % n)
    end
  end
end
