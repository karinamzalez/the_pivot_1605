require 'rails_helper'

include TestHelper
describe 'Platform admin can approve or deny a new business', type: :feature do
  context 'platform admin is logged in and businesses exist' do
    xscenario 'and sees the approved business in a list of current businesses' do
      platform_admin = create(:user, :as_platform_admin)
      create_new_business_applications
      create_test_businesses
      page.set_rack_session(user_id: platform_admin.id)

      visit dashboard_path

      first('.new_business').click_on("Approve New Business")
      within('.business') do
        expect(page).to have_content(Business.first.name)
      end
    end
  end
end
