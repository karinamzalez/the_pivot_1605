class AddRolesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string, :default => :registered_user
  end
end
