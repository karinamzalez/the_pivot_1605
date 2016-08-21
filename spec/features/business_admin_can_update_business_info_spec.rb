# require 'rails_helper'
# require 'support/test_helper'
#
# describe 'Business admin can update business information', type: :feature do
#   scenario 'and sees the updated information on the users dashboard' do
#     seed_test_data
#     user = create(:user)
#     business = create(:business)
#
#     visit dashboard_path
#
#     click_link 'Edit Business Info'
#     fill_in 'Business name', with: 'New Business Name'
#     fill_in 'Location', with: '123 New Street'
#     click_button 'Update Information'
#
#     expect(page).to have_content('New Business Name')
#     expect(page).to have_content('123 New Street')
#   end
# end
