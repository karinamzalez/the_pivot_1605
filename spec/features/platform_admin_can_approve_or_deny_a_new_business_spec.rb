require 'rails_helper'

include TestHelper
describe 'Platform admin can approve or deny a new business', type: :feature do
  context 'platform admin is logged in and businesses exists' do
    scenario 'and sees the approved business in a list of current businesses' do
      platform_admin = create(:user, :as_platform_admin)
      user = create(:user)
      create_new_businesses
      create_roles
      user.update_attribute(:business_id, Business.first.id)
      page.set_rack_session(user_id: platform_admin.id)
      visit dashboard_path

      first('.new-business').click_on("Approve New Business")
      within ('.online-businesses') do
        expect(page).to have_content(Business.first.name)
      end
      expect(User.find_by(business_id: user.business_id).roles.first.name).to eq("business_admin")

    end
    scenario 'and no longer sees the declined business in a list of current businesses' do
      platform_admin = create(:user, :as_platform_admin)
      create_new_businesses
      create_test_businesses
      business = Business.find_by(status: 'new_business')
      page.set_rack_session(user_id: platform_admin.id)

      visit dashboard_path

      first('.new-business').click_on("Decline New Business")
      expect(page).not_to have_content(business)
    end
  end
end
