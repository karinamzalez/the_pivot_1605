class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  enum status: %w(ordered paid completed cancelled)

  def updated?
    true unless ordered?
  end

  def total
    order_items.to_a.sum { |order_item| order_item.subtotal.to_f }.round(2)
  end
end
