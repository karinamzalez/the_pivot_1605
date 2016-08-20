class Item < ActiveRecord::Base
  before_create :item_slug
  belongs_to :category
  has_many :business_items
  has_many :businesses, through: :business_items

  def item_slug
    self.slug = name.parameterize
  end
end
