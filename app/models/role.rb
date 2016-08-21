class Role < ApplicationRecord
  has_many :users_roles
  has_many :roles, through: :user_roles 
end
