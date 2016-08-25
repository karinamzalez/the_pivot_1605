require 'rails_helper'
require 'support/test_helper'

RSpec.feature "Visitor cart additions" do
  context "Multiple items are available for purchase" do
    scenario "visitor views item #1 and adds it to their cart" do

      seed_test_data

      visit item_path(Item.all.first)

      click_button("Add to Cart")
      expect(page).to have_content(" has been added to your cart")
    end
  end
end
