require 'rails_helper'

include TestHelper

RSpec.feature "Visitor cart functionality" do
  context "Multiple businesses and items exist" do

    scenario "visitor adds item to cart from Business #1" do
      seed_test_data
      visit business_slug_path(Business.first.slug)
      first('.item-wrapper').click_button("Add to Cart")

      expect(page).to have_content(" has been added to your cart")
    end

    scenario "visitor adds item to cart from Business #2" do
      seed_test_data

      visit business_slug_path(Business.first.slug)

      first('.item-wrapper').click_button("Add to Cart")

      visit business_slug_path(Business.second.slug)
      
      first('.item-wrapper').click_button("Add to Cart")

      expect(page).to have_content(" has been added to your cart")
    end
  end
end
