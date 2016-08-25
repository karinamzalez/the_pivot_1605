require 'rails_helper'

include TestHelper
describe 'Platform admin can view businesses items' do
  scenario 'and each item has an edit button on the admin items show' do
    create_test_categories
    create_platform_admin
    create_test_business_items
    item_1 = Item.first.name
    item_2 = Item.second.name
    admin = User.first
    page.set_rack_session(user_id: admin.id)

    visit dashboard_path

    first('.business').click_on('View Business Items')
    expect(page).to have_content(item_1)
    expect(page).to have_content(item_2)
  end
end
