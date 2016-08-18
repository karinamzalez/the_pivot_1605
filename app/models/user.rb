class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  validates :username, presence: true
  validates :password, presence: true

  enum role: %w(default admin)
end
