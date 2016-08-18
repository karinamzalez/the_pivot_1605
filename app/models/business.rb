class Business < ActiveRecord::Base
  before_create :create_slug
  belongs_to :user
  has_many :business_items
  has_many :items, through: :business_items

  def create_slug
    self.slug = self.name.parameterize
  end
end
