require 'rails_helper'

RSpec.feature "user sees past orders" do
  scenario "user see list of previous orders from dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    order_1 = create(:order, user_id: user.id)
    item_1  = create(:item)
    order_item_1 = create(:order_item, order_id: order_1.id, item_id: item_1.id)

    visit dashboard_path

    click_on "Past Orders"

    within("h4.order-info") do
      expect(page).to have_content("Order ##{order_1.id}")
    end

    within("h5.order-info") do
      expect(page).to have_content("View Order")
    end

    click_on "View Order"

    within("h5.date") do
      expect(page).to have_content("Ordered at:")
    end
  end
end
