require 'rails_helper'

include TestHelper

RSpec.feature "Business Admin Sees All Business Items" do
  context "business admin visits dashboard" do
    scenario 'admin can view all related business items' do
      business = create(:business)
      admin = create(:user, business_id: business.id)
      create_roles
      admin.set_business_admin
      create_test_categories
      create_test_business_items
      page.set_rack_session(user_id: admin.id)

      visit dashboard_path

      within("p.name") do
        expect(page).to have_content(business.name)
      end

      click_on("View #{business.name} Items")

      expect(page).to have_content(business.items.first.name)
      expect(page).to have_content(business.items.last.name)
    end

    scenario "business admin can edit business items" do
      business = create(:business)
      admin = create(:user, business_id: business.id)
      create_roles
      admin.set_business_admin
      create_test_categories
      create_test_business_items
      page.set_rack_session(user_id: admin.id)

      visit dashboard_path

      click_on("View #{business.name} Items")

      within("tr.#{business.items.first.slug}") do
        click_on("Edit")

        expect(current_path).to eq(edit_item_path("#{business.items.first}"))

        fill_in "name", with: "apple"

        expect(business.items.first.name).to eq("apple")
      end
    end
  end
end
