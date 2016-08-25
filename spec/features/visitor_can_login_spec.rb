require 'rails_helper'

include TestHelper
describe 'Visitor can login', type: :feature do
  scenario 'and is redirected to the users dashboard' do
    user = create(:user, :as_registered_user)
    create_test_categories
    create_test_businesses
    create_test_business_items

    visit businesses_path
    within('.navbar') do
      click_on 'Login'
    end
    expect(current_path).to eq login_path

    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    within('.login-form') do
      click_on "Login"
    end

    expect(page).to have_content('Successfully logged in!')
    expect(page).not_to have_content('Login.')
    expect(page).not_to have_content('Invalid login!')

    click_on "Logout"

    expect(page).to have_content('Successfully logged out!')
    expect(current_path).to eq root_path
  end

  scenario 'and when the password is incorrect visitor sees the login page' do
    user = create(:user, password: 'password')
    create_test_categories
    create_test_businesses
    create_test_business_items

    visit login_path

    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'assword'
    within('.login-form') do
      click_on "Login"
    end

    expect(page).to have_content('Login')
    expect(page).to have_content('Invalid login!')
    expect(page).not_to have_content("Welcome, #{user.username}")
  end
end
