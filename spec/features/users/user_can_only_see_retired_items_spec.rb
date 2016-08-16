require 'rails_helper'

describe 'User cannot check out a retired gnome' do
  scenario "they instead see 'Item retired' in it's place" do
    gnome = create(:gnome, :role => 1)

    visit gnome_path(gnome)

    expect(page).not_to have_button('Add to bucket')
    expect(page).to have_content('Item retired')
  end
end
