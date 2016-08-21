require 'rails_helper'
require 'support/test_helper'

describe 'Visitor can view category pages', type: :feature do
  scenario 'visitor clicks link to category page from homepage' do
    seed_test_data
    category_1, category_2 = create_list(:category, 2)
    # As a visitor
    # when I visit the home page
    visit root_path
    # and I click on the categories dropdown
    # I see a list of categories
    click_on 'Categories'
    # when I select a category
    within(:css, "div#more") do
      click_on category_1.name
    end
    # I am taken to the category page
    expect(current_path).to eq category_path(category_1)
    expect(page).to have_content("#{category_1.name}")

    click_on 'Categories'
    within(:css, "div#more") do
      click_on category_2.name
    end

    expect(current_path).to eq category_path(category_2)
    expect(page).to have_content("#{category_2.name}")
  end
end
