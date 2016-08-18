require 'rails_helper'
require 'support/test_helper'

RSpec.feature "Visitor cart functionality" do
  context "Multiple businesses and items exist" do
    seed_test_data
    
    scenario "visitor adds item to cart from Business #1" do
      # as a visitor, when I am on a business's page 
      visit business_path(Business.all.first)
      # and I click on an item's add-to-cart button
      first('.item-wrapper').click_button("Add to Cart")
      
      # I see a message that the item was added to my cart
      expect(page).to have_content(" has been added to your cart")
      # cart is incremented by 1
      expect(page).to have_content("Cart: 1")
    end
    
    scenario "visitor adds item to cart from Business #2" do
      # as a visitor, when I am on a business's page 
      visit business_path(Business.all.first)
      # and I click on an item's add-to-cart button
      first('.item-wrapper').click_button("Add to Cart")
      # and I visit another business's page
      visit business_path(Business.all.second)
      # and I click on another item's add-to-cart button
      first('.item-wrapper').click_button("Add to Cart")

      # I see a message that that item was also added to my cart
      expect(page).to have_content(" has been added to your cart")
      # and my cart is incremented by 1
      expect(page).to have_content("Cart: 2")
    end
  end
end