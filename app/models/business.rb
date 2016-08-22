class Business < ActiveRecord::Base
  before_create :business_slug
  has_many :users
  has_many :business_items
  has_many :items, through: :business_items

  def business_slug
    self.slug = name.parameterize
  end
end
