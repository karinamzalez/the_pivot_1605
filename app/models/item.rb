class Item < ActiveRecord::Base
  before_create :item_slug
  belongs_to :category
  has_many :business_items
  has_many :businesses, through: :business_items

  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :image_url, presence: true

  def to_param
    slug
  end

  def set_business(current_user)
    self.businesses << Business.find(current_user.business_id)
  end

  private

  def item_slug
    self.slug = name.parameterize if name
  end
end
