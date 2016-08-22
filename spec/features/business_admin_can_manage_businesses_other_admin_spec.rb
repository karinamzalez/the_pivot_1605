# require 'rails_helper'
#
# describe 'Business admin can manage businesses other admins', type: :feature do
#   scenario 'and sees a list of current admins' do
#     business = create(:business)
#     primary_admin, admin_two, admin_three = create_list(:user, businesses_id: business.id)
#     page.set_rack_session(primary_admin: primary_admin.id)
#
#     visit dashboard_path
#
#     click_link 'Manage Business Admins'
#
#     expect(page).to have_content(admin_two.name)
#     expect(page).to have_content(admin_three.name)
#   end
#
#   # scenario 'and when user is updated to admin they show up in the admin list'
#   #   business = create(:business)
#   #   admin = create(:user, role: 'business_admin', businesses_id: business.id)
#   #   user = create(:user)
#   #   page.set_rack_session(primary_admin: primary_admin.id)
#   #
#   #   visit dashboard_path
#   #
#   #   click_link 'Manage Business Admins'
#   #   click_link 'Add Business Admin'
#   #   fill_in 'Email Address', with: user.email
#   #   click_button 'Add Business Admin'
#   #
#   #   expect(page).to have_content(user.name)
#   # end
#   #
#   # scenario 'and when admin is demoted to user they no longer appear in the admin list'
#   #   business = create(:business)
#   #   primary_admin, admin_two = create_list(:user, 2, role: 'business_admin', businesses_id: business.id)
#   #   page.set_rack_session(primary_admin: primary_admin.id)
#   #
#   #   visit dashboard_path
#   #
#   #   click_link 'Manage Business Admins'
#   #   within('#admin_two.name') do
#   #     click_button 'Demote'
#   #   end
#   #   expect(page).not_to have_content(admin_two.name)
#   # end
# end
