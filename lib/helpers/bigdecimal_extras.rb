require "bigdecimal"

class BigDecimal
  # Rounds up to nearest n
  def round_up_to_nearest(n)
    if self % n == 0
      self
    else
      self + n - (self % n)
    end
  end
end
