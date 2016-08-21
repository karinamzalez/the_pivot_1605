class ChangeRoleToUser < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :name, :role
  end
end
