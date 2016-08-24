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

# # # as an authenticated platform admin
# # # when I view my user dashboard
# # # and I click on "New Businesses"
# # # I should see a list of new businesses
# # # and when I click on a business
# # # I should see that business's info
# # # and when I click on Approve Business
# # # I should see the list of current businesses containing the one I just approved
# # #
# # # if instead I click on Decline Business
# # # I should see the list of new businesses without the business I just declined
