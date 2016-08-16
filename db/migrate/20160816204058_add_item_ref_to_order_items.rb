class AddItemRefToOrderItems < ActiveRecord::Migration
  def change
    add_reference :order_items, :item, index: true, foreign_key: true
  end
end
