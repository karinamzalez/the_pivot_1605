require 'rails_helper'

RSpec.feature "Visitor cart functionality" do
  context "Multiple businesses and items exist" do
    scenario "visitor adds item to cart from Business #1" do
      # as a visitor, when I am on a business's page 
      visit business_path(1)
      # and I click on an item's add-to-cart button
      click_button("Add to Cart")
      
      # I see a message that the item was added to my cart
      expect(page).to have_content(" has been added to your cart")
      # cart is incremented by 1
      expect(page).to have_content("Cart: 1")
    end
    
    scenario "visitor adds item to cart from Business #2" do
      # and I visit another business's page
      visit business_path(2)
      # and I click on another item's add-to-cart button
      click_button("Add to Cart")
      
      # I see a message that that item was also added to my cart
      expect(page).to have_content(" has been added to your cart")
      # and my cart is incremented by 1
      expect(page).to have_content("Cart: 2")
    end
  end
end