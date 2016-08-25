class RemoveStatusFromBusiness < ActiveRecord::Migration[5.0]
  def change
    remove_column :businesses, :status
  end
end
