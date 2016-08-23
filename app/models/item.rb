class Item < ActiveRecord::Base
  before_create :item_slug
  belongs_to :category
  has_many :business_items
  has_many :businesses, through: :business_items

  def to_param
    slug
  end

  def deactivate_item
    deactivate 
  end

  private

  def deactivate
    self.status = false
  end

  def item_slug
    self.slug = name.parameterize if name
  end
end
