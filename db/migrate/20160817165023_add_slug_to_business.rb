class AddSlugToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column  :businesses, :slug, :text
  end
end
