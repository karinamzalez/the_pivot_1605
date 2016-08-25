class Business < ActiveRecord::Base
  before_create :business_slug
  has_many :users
  has_many :business_items
  has_many :items, through: :business_items

  validates :name, presence: true
  validates :location, presence: true

  enum status: %w(new_business online offline)
  #
  # scope :online_businesses, where(status: 'online')
  # scope :new_businesses, where(status: 'new_business')
  # scope :offline_businesses, where(status: 'offline')

  def business_slug
    self.slug = name.parameterize
  end

  def admins
    users
  end

  def self.find_online_businesses
    Business.where(status: 'online')
  end

  def self.find_new_businesses
    Business.where(status: 'new_business')
  end

  def self.find_offline_businesses
    Business.where(status: 'offline')
  end
end
