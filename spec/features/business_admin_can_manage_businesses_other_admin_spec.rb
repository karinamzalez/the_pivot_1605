require 'rails_helper'
require 'support/test_helper'

include TestHelper

describe 'Business admin can manage businesses other admins', type: :feature do
  scenario 'and sees a list of current admins' do
    create_business_admins
    page.set_rack_session(user_id: User.first.id)

    visit dashboard_path
    click_link 'Update Business Info'

    expect(page).to have_content(admin_two.name)
    expect(page).to have_content(admin_three.name)
  end

  scenario 'and when user is updated to admin they show up in the admin list' do
    pending
    create_business_admins
    admin = User.first
    user = User.create(
      username: "new_admin",
      email: "newkidontheblock@turing.io",
      password: "password"
    )
    user.roles << Role.find_by(name: "registered user")
    page.set_rack_session(user_id: admin.id)

    visit dashboard_path

    click_link 'Update Business Info'
    click_link 'Add Business Admin'
    fill_in 'Email Address', with: user.email
    click_button 'Add Business Admin'

    expect(page).to have_content(user.username)
  end

  scenario 'and when admin is demoted to user they no longer appear in the admin list' do
    pending
    create_business_admins
    admin_to_remove = User.first
    page.set_rack_session(user_id: User.first.id)

    visit dashboard_path

    click_link 'Update Business Info'
    within('#business_admin_1') do
      click_button 'Demote'
    end
    expect(page).not_to have_content(admin_to_remove.name)
  end
end
