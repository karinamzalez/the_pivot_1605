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

<<<<<<< HEAD
  def set_business_admin
    self.roles << Role.find_by(name: 'business_admin')
=======
  def set_business_admin(business)
    roles << Role.find_by(name: 'business_admin')
    self.business_id = business.id
    self.save
  end
  
  def remove_business_admin
    role = self.roles.find_by(name: 'business_admin')
    UserRole.where(user_id: self.id, role_id: role.id).destroy_all
    self.business_id = nil
    self.save
>>>>>>> 9c929462a52c2bbf69d75d3d27d5a659cbb4c603
  end
end
