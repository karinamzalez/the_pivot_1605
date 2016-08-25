require 'rails_helper'

include TestHelper
describe "Platform admin can toggle businesses' status" do
  scenario 'offline and views that business is not currently available' do
    create_test_businesses
    create_offline_businesses
    create_new_businesses
    business = Business.find_by(status: 'online')
    platform_admin = create(:user, :as_platform_admin)
    page.set_rack_session(user_id: platform_admin.id)

    visit dashboard_path

    first('.business').click_on('Take Business Offline')

    visit business_slug_path(business.slug)

    expect(page).to have_content('This business is currently unavailable.')
  end
  scenario 'online and views that business is available' do
    create_test_businesses
    create_offline_businesses
    create_new_businesses
    business = Business.find_by(status: 'online')
    platform_admin = create(:user, :as_platform_admin)
    page.set_rack_session(user_id: platform_admin.id)

    visit dashboard_path

    first('.offline-business').click_on("Set Business Online")

    visit business_slug_path(business.slug)

    expect(page).not_to have_content('This business is currently unavailable.')
  end
end
