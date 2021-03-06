require 'rails_helper'

include TestHelper

RSpec.feature "Business Admin Sees All Business Items" do
  context "business admin visits dashboard" do

    before :each do
      @business = create(:business)
      @admin = create(:user, business_id: @business.id)
      create_roles
      @admin.set_business_admin(@business)
      create_test_categories
      create_test_business_items
    end

    scenario 'admin can view all related business items' do
      page.set_rack_session(user_id: @admin.id)
      visit dashboard_path

      within("p.name") do
        expect(page).to have_content(@business.name)
      end
      click_on("View #{@business.name} Items")

      expect(page).to have_content(@business.items.first.name)
      expect(page).to have_content(@business.items.last.name)
    end

    scenario "business admin can edit business items" do
      page.set_rack_session(user_id: @admin.id)

      visit dashboard_path

      click_on("View #{@business.name} Items")
      within("tr.#{@business.items.first.slug}") do
        click_on("Edit")
      end

      expect(current_path).to eq("/admin/items/#{@business.items.first.slug}/edit")

      fill_in "Name",  with: 'apple'
      click_on("Update Item")

      expect(@business.items.first.name).to eq("apple")
    end

    scenario "business admin can delete business items" do
      page.set_rack_session(user_id: @admin.id)

      visit dashboard_path

      click_on("View #{@business.name} Items")
      within("tr.#{@business.items.first.slug}") do
        click_on("Remove")
      end

      expect(page).not_to have_content(@business.items.first.name)
    end

    scenario "business admin can create new business item" do
      page.set_rack_session(user_id: @admin.id)

      visit dashboard_path

      click_on("View #{@business.name} Items")
      click_on("New Item")

      expect(current_path).to eq("/admin/items/new")

      fill_in "Name",  with: 'orange'
      fill_in "Price",  with: 42
      fill_in "Description",  with: "I mean, it's an orange."
      fill_in "Image url",  with: 'hi'
      click_on "Create Item"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("orange")
    end

    scenario "business admin can't create new business item without a name" do
      page.set_rack_session(user_id: @admin.id)

      visit dashboard_path

      click_on("View #{@business.name} Items")
      click_on("New Item")

      expect(current_path).to eq("/admin/items/new")

      fill_in "Price",  with: 42
      fill_in "Description",  with: "I mean, it's an orange."
      fill_in "Image url",  with: 'hi'
      click_on "Create Item"

      expect(page).to have_content("Name can't be blank")
    end
    scenario "business admin can't edit business items without correct formatting" do
      page.set_rack_session(user_id: @admin.id)

      visit dashboard_path

      click_on("View #{@business.name} Items")
      within("tr.#{@business.items.first.slug}") do
        click_on("Edit")
      end

      expect(current_path).to eq("/admin/items/#{@business.items.first.slug}/edit")

      fill_in "Price",  with: 'apple'
      click_on("Update Item")

      expect(page).to have_content("Price is not a number")
    end
  end
end
