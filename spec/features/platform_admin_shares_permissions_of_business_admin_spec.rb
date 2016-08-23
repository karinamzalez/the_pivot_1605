require 'rails_helper'

include TestHelper

describe "Platform admin can manage any business's admins", type: :feature do
  scenario 'visits a business admin edit page and sees a list of current business admins' do
    create_business_admins
    admin_1 = User.first
    admin_2 = User.second
    platform_admin = create_platform_admin
    page.set_rack_session(user_id: platform_admin.id)
    
    visit dashboard_path
    first(".business").click_on("Manage Business Admins")
    save_and_open_page
    expect(page).to have_content(admin_1.username)
    expect(page).to have_content(admin_2.username)
  end
  
  scenario 'and when user is updated to admin they show up in the admin list' do
    pending
    platform_admin = create_platform_admin
    user = User.create(
      username: "new_admin",
      email: "newkidontheblock@turing.io",
      password: "password"
    )
    user.roles << Role.find_by(name: "registered_user")
    page.set_rack_session(user_id: platform_admin.id)
    
    visit dashboard_path
    
    first(".business").click_on("Manage Business Admins")
    click_on 'Add Business Admin'
    fill_in 'New Admin Email', with: user.email
    click_button 'Submit New Business Admin'

    expect(page).to have_content(user.username)
  end
  
  scenario 'and when admin is demoted to user they no longer appear in the admin list' do
    pending
    create_business_admins
    admin_to_remove = User.first
    platform_admin = create_platform_admin
    page.set_rack_session(user_id: platform_admin.id)

    visit dashboard_path

    first(".business").click_on("Manage Business Admins")
    first('.admin').click_link('Demote Admin')
    expect(page).not_to have_content(admin_to_remove.username)
  end
end

describe "Platform admin can update any business's information", type: :feature do
  scenario "and sees the updated information on the dashboard" do
    pending
    create_test_businesses
    business_to_update = Business.first
    platform_admin = create_platform_admin
    updated_business_name = 'New Business Name'
    updated_business_address = '123 New Street'
    
    visit dashboard_path

    first(".business").click_on('Update Business Info')
    fill_in 'Business Name', with: updated_business_name
    fill_in 'Location', with: updated_business_address
    click_button 'Update Business Info'

    expect(page).to have_content(updated_business_name)
    expect(page).to have_content(updated_business_address)
  end
  
  scenario 'platform admin cannot update info with blank fields' do
    pending
    create_test_businesses
    platform_admin = create_platform_admin
    page.set_rack_session(user_id: platform_admin.id)

    visit dashboard_path

    first(".business").click_on('Update Business Info')
    fill_in 'Business Name', with: 'blah incorporated'
        fill_in 'Location', with: ''
    click_button 'Update Business Info'
    expect(page).to have_content('Business information not updated successfully.')
    expect(current_path).to eq (edit_business_path(business))
  end
end
