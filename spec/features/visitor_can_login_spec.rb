require 'rails_helper'

describe 'Visitor can login', type: :feature do
  scenario 'and is redirected to the users dashboard' do
    user = create(:user)

    visit farmersmarket_path
    click_on "Login"
    expect(current_path).to eq login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Login"

    expect(page).to have_content("Login successful!")
    expect(page).not_to have_content("Login invalid. Try again.")
  end

  scenario 'and when the password is incorrect visitor sees the login page' do
    user = create(:user, password: 'password')

    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: 'assword'
    click_on "Login"

    expect(page).to have_content("Username")
    expect(page).to have_content("Login invalid. Try again.")
    expect(page).not_to have_content("Welcome, #{user.username}")
  end
end
