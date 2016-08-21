require 'rails_helper'

describe Role, type: :model do
  it { should validate_uniqueness_of(:name) }

  it do
    should have_many(:user_roles)
  end

  it do
    should have_many(:roles).
      through(:user_roles).
      class_name('Role')
  end
end
