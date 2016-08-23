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
    user = create(:user, :as_registered_user)
    expect(user.registered_user?).to eq(true)
  end

  it 'sets platform_admin' do
    user = create(:user)
    create_roles
    user.set_platform_admin
    expect(user.roles.first.name).to eq('platform_admin')
  end

  it 'sets business admin' do
    user = create(:user)
    business = create(:business)
    create_roles
    user.set_business_admin(business)
    expect(user.roles.first.name).to eq('business_admin')
    expect(user.business.name).to eq(business.name)
  end

  it 'sets registered_user' do
    user = create(:user)
    create_roles
    user.set_registered_user
    expect(user.roles.first.name).to eq('registered_user')
  end

  # it 'removes business admin' do
  #   user = create(:user, :as_business_admin)
  #   user.remove_business_admin
  #
  #   expect(user.roles).to eq(nil)
  #   expect(user.business_id).to eq(nil)
  # end
end
