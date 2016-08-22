class User < ActiveRecord::Base
  has_secure_password

  has_many :orders
  belongs_to :business

  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :username, presence: true #, uniqueness: true
  validates :password, presence: true

  def platform_admin?
    roles.exists?(name: 'platform admin')
  end

  def business_admin?
    roles.exists?(name: 'business admin')
  end

  def registered_user?
    roles.exists?(name: 'registered user')
  end
end
