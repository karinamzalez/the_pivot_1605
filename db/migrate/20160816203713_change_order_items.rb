class ChangeOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :gnome_id
  end
end
