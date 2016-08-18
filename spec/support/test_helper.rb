def seed_test_data
  create_test_businesses
  create_test_categories
  create_test_business_items
end

def create_test_categories
  5.times do
    FactoryGirl.create(:category)
  end
end

def create_test_businesses
  5.times do
    FactoryGirl.create(:business)
  end
end

def create_test_business_items
  Business.all.each do |business|
    rand(1..10).times do
      business.items << Item.create(
        name: Faker::Commerce.product_name,
        price: Faker::Number.decimal(2),
        description: Faker::Hipster.paragraph,
        category_id: Category.all.shuffle.pop.id,
        image_url: "http://kingofwallpapers.com/apple/apple-015.jpg"
      )
    end
  end
end