class User < ActiveRecord::Base
  has_secure_password

  has_many :orders
  has_many :user_roles
  has_many :users, through: :user_roles

  validates :username, presence: true #, uniqueness: true
  validates :password, presence: true

  enum role: %w(default admin)
end
