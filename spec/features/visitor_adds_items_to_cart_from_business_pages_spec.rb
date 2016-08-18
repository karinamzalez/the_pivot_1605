require 'rails_helper'
require 'support/test_helper'

RSpec.feature "Visitor cart functionality" do
  context "Multiple businesses and items exist" do
    seed_test_data

    scenario "visitor adds item to cart from Business #1" do

      visit business_path(Business.first.slug)

      first('.item-wrapper').click_button("Add to Cart")

      expect(page).to have_content(" has been added to your cart")
      expect(page).to have_content("Cart: 1")
    end

    scenario "visitor adds item to cart from Business #2" do

      visit business_path(Business.first.slug)

      first('.item-wrapper').click_button("Add to Cart")

      visit business_path(Business.second.slug)

      first('.item-wrapper').click_button("Add to Cart")

      expect(page).to have_content(" has been added to your cart")
      expect(page).to have_content("Cart: 2")
    end
  end
end
