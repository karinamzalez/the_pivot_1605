require 'rails_helper'

include TestHelper

describe "Platform admin can manage any business's admins", type: :feature do
  scenario 'visits a business admin edit page and sees a list of current business admins' do
    pending
    create_business_admins
    admin_1 = User.first
    admin_2 = User.second
    platform_admin = create_platform_admin
    page.set_rack_session(user_id: platform_admin.id)
    
    visit dashboard_path
    
    first(".business").click_on("Manage Business Admins")
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
end