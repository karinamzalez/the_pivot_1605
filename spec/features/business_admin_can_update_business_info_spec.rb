require 'rails_helper'

describe 'Business admin can update business information', type: :feature do
  scenario 'and sees the updated information on the users dashboard' do
    user = create(:user)
    role = Role.create(name: 'business_admin')
    user.roles << role
    business = create(:business)
    updated_business_name = 'New Business Name'
    updated_business_address = '123 New Street'
    page.set_rack_session(user_id: user.id)

    visit dashboard_path

    click_link 'Edit Business Info'
    fill_in 'Business name', with: updated_business_name
    fill_in 'Location', with: updated_business_address
    click_button 'Update Information'

    expect(page).to have_content(updated_business_name)
    expect(page).to have_content(updated_business_address)
  end
end
