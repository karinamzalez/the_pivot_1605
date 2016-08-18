class CartItem < SimpleDelegator
  attr_reader :quantity, :item, :item_key

  def initialize(item_id, quantity=nil)
    @item = Item.find(item_id)
    @quantity = quantity
    @item_key = @item.id.to_s
    super(@item)
  end

  def subtotal
    price * quantity
  end

  def adjust_quantity(adjustment, cart)
    if adjustment == "increase"
      cart.contents[item_key] += 1
    else
      decrement(cart)
    end
  end

  def decrement(cart)
    if cart.contents[item_key].zero?
      cart.contents[item_key] = 0
    else
      cart.contents[item_key] -= 1
    end
  end
end
