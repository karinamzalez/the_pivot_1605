class BusinessItems < ActiveRecord::Migration
  def change
    create_table :business_items do |t|
      t.references :business, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
    end
  end
end
