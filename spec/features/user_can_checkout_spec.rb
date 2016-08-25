require 'rails_helper'

describe 'User can checkout', type: :feature do
  context 'user already has items in cart' do
    scenario 'and can view order summary' do
      user = create(:user, :as_registered_user)
      item_one, item_two, item_three = create_list(:item, 3)
      page.set_rack_session(user_id: user.id,
                            cart: {item_one.id => 1,
                                   item_two.id => 7,
                                   item_three.id => 1,})
      visit cart_path

      click_on 'Increase quantity', match: :first
      click_on 'Decrease quantity', match: :first
      click_on 'Remove from cart', match: :first

      click_button 'Checkout'

      expect(page).to have_content('Order was successfully placed.')
      expect(page).to have_content(item_two.name)
      expect(page).to have_content(item_three.name)

      within('table') do
        expect(page).to have_content(item_three.price)
      end
    end
  end
end
