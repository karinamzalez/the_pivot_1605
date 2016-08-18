class Seed
  def self.start
    generate_categories
    generate_businesses
    generate_business_items
    generate_users
  end

  def self.generate_categories
    3.times do
      Category.create(name: Faker::Commerce.color.capitalize)
    end
    puts "categories created successfully!"
  end

  def self.generate_businesses
    20.times do
      business = Business.create(
        name: Faker::Company.name,
        location: Faker::Address.city
      )
    end
    puts "businesses created successfully!"
  end
  
  def self.generate_business_items
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
    puts "business items created successfully!"
  end

  def self.generate_users
    2.times do
      User.create(
        username: "hollagonzalla",
        password: "password"
      )
    end
    puts "users created successfully!"
  end
end

Seed.start
