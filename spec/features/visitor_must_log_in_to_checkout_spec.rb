require 'rails_helper'

describe 'Visitor must log in to checkout', type: :feature do
  scenario 'and sees button to log in to be able to checkout' do
    visit cart_path

    expect(page).to have_content('Login or Create Account to checkout')
    expect(page).not_to have_content('Checkout')
  end

  context 'visitor already has item in cart' do
    scenario 'and is redirected to the cart view once logged in' do
      user = create(:user)
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

      expect(page).to have_content(item_one.name)
      expect(page).to have_content(item_two.price)
    end
  end

  scenario 'and when logged in does not button to log in to be able to checkout' do
    user = create(:user)
    item_one, item_two = create_list(:item, 2)
    page.set_rack_session(user_id: user.id,
                          cart: {item_one.id => 1,
                                 item_two.id => 2})

    visit cart_path

    expect(page).to have_button('Checkout')
    expect(page).not_to have_content('Login or Create Account to checkout')
  end
end
