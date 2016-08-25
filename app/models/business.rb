class Business < ActiveRecord::Base
  before_create :business_slug
  has_many :users
  has_many :business_items
  has_many :items, through: :business_items

  validates :name, presence: true
  validates :location, presence: true

  enum status: %w(new_business online offline)

  def business_slug
    self.slug = name.parameterize
  end

  def admins
    users
  end


end
