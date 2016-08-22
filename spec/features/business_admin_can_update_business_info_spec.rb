require 'rails_helper'

describe 'Business admin can update business information', type: :feature do
  scenario 'and sees the updated information on the users dashboard' do
    business = create(:business)
    role = Role.create(name: 'business_admin')
    user = create(:user, businesses_id: business.id)
    user.roles << role
    updated_business_name = 'New Business Name'
    updated_business_address = '123 New Street'
    page.set_rack_session(user_id: user.id)

    visit dashboard_path

    click_link 'Update Business Info'
    fill_in 'Business Name', with: updated_business_name
    fill_in 'Location', with: updated_business_address
    click_button 'Update Business Info'

    expect(page).to have_content(updated_business_name)
    expect(page).to have_content(updated_business_address)
  end
end
