class User < ActiveRecord::Base
  has_secure_password
  belongs_to :business
  has_many :orders
  has_many :order_items, through: :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  validates :username, presence: true
  validates :password, presence: true

  def platform_admin?
    roles.exists?(name: 'platform_admin')
  end

  def business_admin?
    roles.exists?(name: 'business_admin')
  end

  def registered_user?
    roles.exists?(name: 'registered_user')
  end

  def set_business_admin
    self.roles << Role.find_by(name: 'business_admin')
  end
end
