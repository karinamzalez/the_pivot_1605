require 'rails_helper'

describe 'User can checkout', type: :feature do
  context 'user already has items in cart' do
    scenario 'and can view order summary' do
      user = create(:user)
      item_one, item_two = create_list(:item, 2)
      page.set_rack_session(user_id: user.id,
                            cart: {item_one.id => 1,
                                   item_two.id => 7})
      visit cart_path

      click_button 'Checkout'

      expect(page).to have_content('Order was successfully placed.')
      expect(page).to have_content(item_one.name)
      expect(page).to have_content(item_two.name)

      within('table') do
        expect(page).to have_content(item_one.price)
      end
    end
  end
end
