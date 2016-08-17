class OrderItemsSynthesizer
  class << self
    def generate_order_items(session_contents)
      current_user = current_user(session_contents["user_id"])
      session_contents['cart'].each do |item_id, quantity|
        most_recent_order(current_user).order_items.create(
          item_id: item_id.to_i,
          quantity: quantity
        )
      end
    end

    def current_user(user_id)
      User.find(user_id)
    end

    def most_recent_order(user)
      user.orders.last
    end
  end
end
