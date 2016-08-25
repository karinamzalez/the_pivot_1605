require 'rails_helper'
require 'support/test_helper'

include TestHelper

describe 'Visitor must log in to checkout', type: :feature do
  scenario 'and sees button to log in to be able to checkout' do
    visit cart_path

    expect(page).to have_content('Login or Create Account to checkout')
    expect(page).not_to have_content('Checkout')
  end

  context 'visitor already has item in cart' do
    scenario 'and is redirected to the cart view once logged in' do
      user = create(:user, :as_registered_user)
      item_one, item_two = create_list(:item, 2)
      page.set_rack_session(cart: {item_one.id => 1,
                                   item_two.id => 2})

      visit cart_path

      expect(page).to have_content(item_one.name)
      expect(page).to have_content(item_two.price)

      within('#checkout_button') do
        click_on 'Login'
      end
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      within('.login-form') do
        click_on 'Login'
      end

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(item_one.name)
      expect(page).to have_content(item_two.price)
    end

    scenario 'and is redirected to the cart view once account is created' do
      item_one, item_two = create_list(:item, 2)
      page.set_rack_session(cart: {item_one.id => 1,
                                   item_two.id => 2})

      visit cart_path

      expect(page).to have_content(item_one.name)
      expect(page).to have_content(item_two.price)
      
      create_roles
      
      within('#checkout_button') do
        click_on 'Create Account'
      end
      fill_in 'Username', with: 'Skip'
      fill_in 'Password', with: 'password'
      fill_in 'Email Address', with: 'email@email.com'
      click_on 'Create Account'

      expect(current_path).to eq(cart_path)
      expect(page).to have_content(item_one.name)
      expect(page).to have_content(item_two.price)
    end
  end

  scenario 'and when logged in does not button to log in to be able to checkout' do
    user = create(:user, :as_registered_user)
    item_one, item_two = create_list(:item, 2)
    page.set_rack_session(user_id: user.id,
                          cart: {item_one.id => 1,
                                 item_two.id => 2})

    visit cart_path

    expect(page).to have_button('Checkout')
    expect(page).not_to have_content('Login or Create Account to checkout')
  end
end
