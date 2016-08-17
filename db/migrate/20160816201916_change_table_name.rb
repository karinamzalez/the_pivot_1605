class ChangeTableName < ActiveRecord::Migration
  def change
    rename_column :gnomes, :desc, :description
    remove_column :gnomes, :role
    add_column    :gnomes, :status, :boolean
    rename_table  :gnomes, :items
  end
end
