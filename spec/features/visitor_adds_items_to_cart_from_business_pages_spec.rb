require 'rails_helper'

include TestHelper

RSpec.feature "Visitor cart functionality" do
  context "Multiple businesses and items exist" do

    scenario "visitor adds item to cart from Business #1" do
      seed_test_data
      # as a visitor, when I am on a business's page
      visit business_slug_path(Business.first.slug)
      # and I click on an item's add-to-cart button
      first('.item-wrapper').click_button("Add to Cart")

      # I see a message that the item was added to my cart
      expect(page).to have_content(" has been added to your cart")
      # cart is incremented by 1
      expect(page).to have_content("Cart: 1")
    end

    scenario "visitor adds item to cart from Business #2" do
      seed_test_data
      # as a visitor, when I am on a business's page
      visit business_slug_path(Business.first.slug)
      # and I click on an item's add-to-cart button
      first('.item-wrapper').click_button("Add to Cart")
      # and I visit another business's page
      visit business_slug_path(Business.second.slug)
      # and I click on another item's add-to-cart button
      first('.item-wrapper').click_button("Add to Cart")

      # I see a message that that item was also added to my cart
      expect(page).to have_content(" has been added to your cart")
      # and my cart is incremented by 1
      expect(page).to have_content("Cart: 2")
    end
  end
end
