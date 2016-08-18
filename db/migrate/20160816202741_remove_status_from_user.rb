class RemoveStatusFromUser < ActiveRecord::Migration
  def change
    remove_column :items, :status
    add_column    :items, :status, :boolean, default: false
  end
end
