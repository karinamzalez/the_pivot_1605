class Role < ApplicationRecord
  validates :name, uniqueness: true

  has_many :user_roles
  has_many :roles, through: :user_roles
end
