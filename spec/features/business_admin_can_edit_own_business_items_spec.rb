require 'rails_helper'

include TestHelper

describe 'Businesss admin can edit own business items', type: :feature do
  scenario 'and views updated items in dashboard' do
    admin = create(:user)
    create_roles
    admin.set_business_admin
    business = create(:business)
    require "pry"; binding.pry
    admin.business_id = business.id
    create_test_business_items
    page.set_rack_session(user_id: admin.id)

    visit dashboard_path

    expect(page).to have_content(business.name)
  end
end
