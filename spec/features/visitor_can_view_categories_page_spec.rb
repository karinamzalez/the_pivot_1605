require 'rails_helper'

include TestHelper
describe 'Visitor can view category pages', type: :feature do
  scenario 'visitor clicks link to category page from homepage' do
    category_1, category_2 = create_list(:category, 2)
    create_test_businesses
    create_test_business_items

    visit root_path

    within("div.dropdown-content") do
      click_on category_1.name
    end

    expect(current_path).to eq category_path(category_1)
    expect(page).to have_content("#{category_1.name}")

    within("div.dropdown-content") do
      click_on category_2.name
    end

    expect(current_path).to eq category_path(category_2)
    expect(page).to have_content("#{category_2.name}")
  end

  scenario 'visitor cannot go to category that does not exist' do
    visit category_path("Enron Inc.")
    expect(page).to have_css('.user-greeting')
  end
end
