require 'rails_helper'

describe 'User can apply for a new business', type: :feature do
  scenario 'successfully' do
    user = create(:user, :as_registered_user)
    page.set_rack_session(user_id: user.id)

    visit dashboard_path

    click_on 'Apply to Add My Business'

    expect(current_path).to eq(new_business_path)

    fill_in 'Business Name', with: 'Turing Industries'
    fill_in 'Location', with: 'Denver, CO'
    click_on 'Submit Your Business for Approval'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Thank you for applying to Worldwide Farmers Market! We will let you know if you have been approved shortly.")
  end

  scenario 'but must fill out all fields' do
    user = create(:user, :as_registered_user)
    page.set_rack_session(user_id: user.id)

    visit dashboard_path

    click_on 'Apply to Add My Business'

    expect(current_path).to eq(new_business_path)

    fill_in 'Business Name', with: 'Turing Industries'
    fill_in 'Location', with: ''
    click_on 'Submit Your Business for Approval'

    expect(current_path).to eq(new_business_path)
    expect(page).to have_content("You must fill out all fields.")
  end
end
