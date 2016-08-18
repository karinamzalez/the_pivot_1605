require 'rails_helper'

describe 'Visitor can view category pages', type: :feature do
  scenario 'visitor clicks link to category page from homepage' do
    category_1, category_2 = create_list(:category, 2)
    # As a visitor
    # when I visit the home page
    visit root_path
    # and I click on the categories dropdown
    # I see a list of categories
    expect(page).to have_select('categories', options: [category_1.name, category_2.name])
    # when I select a category
    select "#{category_1.name}", from: 'categories'
    # I am taken to the category page
    expect(current_path).to eq category_path(category_1)
    expect(page).to have_content("#{category_1.name}")

    select "#{category_2.name}", from: 'categories'

    expect(current_path).to eq category_path(category_2)
    expect(page).to have_content("#{category_2.name}")
  end
end
