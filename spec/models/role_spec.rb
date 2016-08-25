require 'rails_helper'

describe Role, type: :model do
  it { should validate_uniqueness_of(:name) }

  it { should have_many(:user_roles) }

  it { should have_many(:users).through(:user_roles) }
end
