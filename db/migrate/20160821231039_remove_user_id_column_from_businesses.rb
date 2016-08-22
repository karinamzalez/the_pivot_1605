class RemoveUserIdColumnFromBusinesses < ActiveRecord::Migration[5.0]
  def change
    remove_column :businesses, :user_id
  end
end
