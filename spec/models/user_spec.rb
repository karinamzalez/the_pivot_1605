require 'rails_helper'

include TestHelper
describe User, type: :model do
  it { should belong_to(:business) }
  it { should have_many(:orders) }
  it { should have_many(:order_items).through(:orders) }
  it { should have_many(:user_roles) }
  it { should have_many(:roles).through(:user_roles) }

  it 'checks platform admin' do
    user = create(:user)
    create_roles
    user.set_platform_admin
    expect(user.platform_admin?).to eq(true)
  end

  it 'checks business admin' do
    user = create(:user)
    business = create(:business)
    create_roles
    user.set_business_admin(business)
    expect(user.business_admin?).to eq(true)
  end

  it 'checks registered user ' do
    user = create(:user)
    create_roles
    user.set_registered_user
    expect(user.registered_user?).to eq(true)
  end

  it 'sets business admin' do
    user = create(:user)
    business = create(:business)
    create_roles
    user.set_business_admin(business)
    expect(user.roles.first.name).to eq('business_admin')
    expect(user.business.name).to eq(business.name)
  end

end
