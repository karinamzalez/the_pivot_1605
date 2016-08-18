class ChangeOrderGnomes < ActiveRecord::Migration
  def change
    remove_foreign_key :order_gnomes, :gnomes
    rename_table       :order_gnomes, :order_items
  end
end
