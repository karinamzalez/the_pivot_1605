require 'rails_helper'

describe Role, type: :model do
  it { should validate_uniqueness_of(:name) }

  it do
    should have_many(:user_roles)
  end

  it do
    should have_many(:users).
      through(:user_roles).
      class_name('User')
  end
end
