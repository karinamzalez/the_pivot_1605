require 'rails_helper'

include TestHelper

describe 'Business admin can manage businesses other admins', type: :feature do
  scenario 'and sees a list of current admins' do
    create_business_admins
    admin_1 = User.first
    admin_2 = User.second
      page.set_rack_session(user_id: admin_1.id)

    visit dashboard_path

    click_link 'Manage Business Admins'

    expect(page).to have_content(admin_1.username)
    expect(page).to have_content(admin_2.username)
  end
end
