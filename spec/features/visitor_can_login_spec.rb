require 'rails_helper'

describe 'Visitor can login', type: :feature do
  scenario 'and is redirected to the users dashboard' do
    user = create(:user)

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
  end

  scenario 'and when the password is incorrect visitor sees the login page' do
    user = create(:user, password: 'password')

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
