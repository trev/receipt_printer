module Parser
  # Parse CSV string into array of hashes
  def self.parse_csv(csv, header)
    line_items = csv.split("\n")
    line_items.shift if header
    line_items.map! { |line_item| parse_line_item(line_item) }
  end

  # Parse line item array into hash
  def self.parse_line_item(line_item)
    line_item = line_item.split(',').map(&:strip)
    { qty: line_item[0], title: line_item[1], cost: line_item[2] }
  end

  private_class_method :parse_line_item
end
