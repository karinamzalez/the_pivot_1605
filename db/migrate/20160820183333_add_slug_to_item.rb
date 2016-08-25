class AddSlugToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :slug, :text
  end
end
