require 'rails_helper'

RSpec.feature "Visitor Sees All Businesses" do
  context "a visitor visits the root page" do
    scenario "they are able to view the index" do
      business_1, business_2, business_3 = create_list(:business, 3)

      visit root_path

      click_on "All Businesses"

      expect(current_path).to eq(root_path)

      within("p.#{business_1.slug}") do
        expect(page).to have_link(business_1.name)
      end

      within("p.#{business_2.slug}") do
        expect(page).to have_link(business_2.name)
      end

      within("p.#{business_3.slug}") do
        expect(page).to have_link(business_3.name)
      end
    end
  end
end