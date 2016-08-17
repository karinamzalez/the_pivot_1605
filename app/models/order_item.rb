class OrderItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :order
  after_create :set_subtotal

  def set_subtotal
    unless quantity.zero?
      update_attribute(:subtotal, item.price * quantity)
    end
  end
end
