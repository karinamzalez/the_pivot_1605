class User < ActiveRecord::Base
  has_secure_password
  belongs_to :business
  has_many :orders
  has_many :order_items, through: :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  validates :username, presence: true
  validates :password, length: { minimum: 5 }, allow_nil: true

  def platform_admin?
    roles.exists?(name: 'platform_admin')
  end

  def business_admin?
    roles.exists?(name: 'business_admin')
  end

  def registered_user?
    roles.exists?(name: 'registered_user')
  end

  def set_platform_admin
    self.roles << Role.find_by(name: 'platform_admin')
    self.save
  end

  def set_business_admin(business)
    self.roles << Role.find_by(name: 'business_admin')
    self.business_id = business.id
    self.save
  end

  def set_registered_user
    self.roles << Role.find_by(name: 'registered_user')
    self.save
  end

  def remove_business_admin
    role = self.roles.find_by(name: 'business_admin')
    UserRole.where(user_id: self.id, role_id: role.id).destroy_all
    self.business_id = nil
    self.save
  end
end
