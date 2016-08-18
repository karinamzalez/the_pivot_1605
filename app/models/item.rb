class Item < ActiveRecord::Base
  belongs_to :category 
  has_many :business_items
  has_many :businesses, through: :business_items
end
