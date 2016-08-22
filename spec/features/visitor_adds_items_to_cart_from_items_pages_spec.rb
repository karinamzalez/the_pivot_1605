require 'rails_helper'
require 'support/test_helper'

RSpec.feature "Visitor cart additions" do
  context "Multiple items are available for purchase" do
    scenario "visitor views item #1 and adds it to their cart" do

      seed_test_data
      # as a visitor
      # when I view an item's page
      visit item_path(Item.all.first)

      click_button("Add to Cart")
      # I see a message that the item was added to my cart
      expect(page).to have_content(" has been added to your cart")
      expect(page).to have_content("Cart: 1")
    end
  end
end
