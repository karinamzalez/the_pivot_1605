class Role < ApplicationRecord
  validates :name, uniqueness: true
  
  has_many :users_roles
  has_many :roles, through: :user_roles
end
