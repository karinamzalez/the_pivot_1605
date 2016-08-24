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

  def set_business(current_user)
    self.businesses << Business.find(current_user.business_id)
  end

  private

  def deactivate
    self.status = false
    self.save
  end

  def item_slug
    self.slug = name.parameterize if name
  end
end
