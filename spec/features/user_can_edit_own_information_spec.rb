require 'rails_helper'

describe 'User can edit own information', type: :feature do
  context 'user is logged in' do
    scenario 'and when they edit username they view their dashboard and updated information' do
      user = User.create(username: 'Tim', password: 'password', email: 'tim@email.com')
      page.set_rack_session(user_id: user.id)

      visit dashboard_path

      click_link 'Edit Account Info'

      fill_in 'Username', with: 'Alan'
      fill_in 'Password', with: 'password'
      fill_in 'Email', with: 'new_email@email.com'

      click_on 'Update Account Info'
      expect(page).to have_content('Alan')
    end
  end
end
