class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_item(item)
    contents[item.id.to_s] ||= 0
    contents[item.id.to_s] += 1
  end

  def populated_contents
    contents.map do |item, quantity|
      CartItem.new(item, quantity)
    end
  end

  def total
    populated_contents.sum { |item| item.price * item.quantity }.to_f
  end

  def empty?
    contents.empty?
  end

  def total_quantity
    contents.values.sum
  end
end
