require 'rails_helper'

include TestHelper

RSpec.feature "Business Admin Sees All Business Items" do
  business = create(:business)
  admin = create(:user, business_id: business.id)
  create_roles
  admin.set_business_admin
  create_test_categories
  create_test_business_items
  page.set_rack_session(user_id: admin.id)

  scenario 'admin visits dashboard and can view all related business items' do

    visit dashboard_path

    within("p.name") do
      expect(page).to have_content(business.name)
    end

    click_on("View #{business.name} Items")

    expect(page).to have_content(business.items.first.name)
    expect(page).to have_content(business.items.last.name)
  end

  scenario "business admin can edit business items from dashboard" do
    
  end
end
