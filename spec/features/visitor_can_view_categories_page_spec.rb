require 'rails_helper'

describe 'Visitor can view category pages', type: :feature do
  scenario 'visitor clicks link to category page from homepage' do
    category_1, category_2 = create_list(:category, 2)

    visit root_path

    expect(page).to have_select('categories', options: [category_1.name, category_2.name])

    select "#{category_1.name}", from: 'categories'

    expect(current_path).to eq category_path(category_1)
    expect(page).to have_content("#{category_1.name}")

    select "#{category_2.name}", from: 'categories'

    expect(current_path).to eq category_path(category_2)
    expect(page).to have_content("#{category_2.name}")
  end
end
