class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :image_file_name
    remove_column :users, :image_content_type
    remove_column :users, :image_file_size
    remove_column :users, :image_updated_at
    remove_column :users, :country_code
    remove_column :users, :phone_number
    remove_column :users, :authy_id
    remove_column :users, :verified
  end
end
