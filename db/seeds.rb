class Seed
  def self.start
    seed = Seed.new
    seed.generate_categories
    seed.generate_businesses
    seed.generate_offline_businesses
    seed.generate_roles
    seed.generate_users
    seed.generate_platform_admin
    seed.generate_business_items
    seed.generate_orders
    seed.generate_new_businesses
  end

  def generate_categories
    Category.create!(name: "Fruits")
    puts "category Fruits created!"
    Category.create!(name: "Vegetables")
    puts "category Vegetables created!"
    Category.create!(name: "Drinks")
    puts "category Drinks created!"
    Category.create!(name: "Plants")
    puts "category Plants created!"
    Category.create!(name: "Jewelry")
    puts "category Jewelry created!"
    Category.create!(name: "Crafts")
    puts "category Crafts created!"
    Category.create!(name: "Dairy")
    puts "category Dairy created!"
    Category.create!(name: "Baked Goods")
    puts "category Baked Goods created!"
    Category.create!(name: "Meats")
    puts "category Meats created!"
    Category.create!(name: "Herbs")
    puts "category Herbs created!"
    Category.create!(name: "Caffeine")
    puts "category Caffeine created!"
  end

  def generate_new_businesses
    generate_businesses
    Business.all.last(20).each do |business|
      business.update_attribute(:status, 0)
    end
    puts "new businesses created successfully!"
  end

  def generate_offline_businesses
    generate_businesses
    Business.all.first(20).each do |business|
      business.update_attribute(:status, 2)
    end
    puts "offline businesses created successfully!"
  end

  def generate_businesses
    city_names = [
      "London",
      "Paris",
      "Shanghai",
      "Dubai",
      "Sydney",
      "San Francisco",
      "New York",
      "Austin"
    ]
    20.times do
      Business.create!(
        name: Faker::Company.name,
        location: city_names.sample,
        status: 1
      )
    end
    puts "businesses created successfully!"
  end

  def generate_business_items
    Business.all.each do |business|
      rand(0..8).times do
        business.items << Item.create!(
          name: [Faker::Commerce.color.capitalize, Faker::Name.home_good].join(" "),
          description: Faker::Lorem.paragraph,
          image_url: "http://loremflickr.com/400/400/market",
          category_id: Category.find_by(name: "Drinks"),
          price: Faker::Commerce.price,
          status: true
        )
        puts "#{Item.last.name} added to #{business.name}!"
      end
      rand(0..15).times do
        business.items << Item.create!(
          name: [Faker::Commerce.color.capitalize, Faker::Name.fruit].join(" "),
          description: Faker::Lorem.paragraph,
          image_url: "http://loremflickr.com/400/400/fruit",
          category_id: Category.find_by(name: "Fruits"),
          price: Faker::Commerce.price,
          status: true
        )
        puts "#{Item.last.name} added to #{business.name}!"
      end
      rand(0..15).times do
        business.items << Item.create!(
          name: [Faker::Commerce.color.capitalize, Faker::Name.vegetable].join(" "),
          description: Faker::Lorem.paragraph,
          image_url: "http://loremflickr.com/400/400/vegetable",
          category_id: Category.find_by(name: "Vegetables"),
          price: Faker::Commerce.price,
          status: true
        )
        puts "#{Item.last.name} added to #{business.name}!"
      end
    end
    puts "business items created successfully!"
  end

  def generate_users
    100.times do |i|
      user = FactoryGirl.create(:user)
      puts "User #{i}: #{user.username} - #{user.email} created!"
    end
    jorge = User.create!(username: 'jorge', email: 'jorge@turing.io', password: "password", business_id: 1)
    jorge.set_business_admin(Business.find(1))
    puts "jorge created!"

    chris = User.create!(username: 'seen_on_trail', email: 'chris@students.turing.io', password: "password")
    puts "seen_on_trail created!"
  end

  def generate_platform_admin
    platform_admin = User.create(
      username: "platform_admin",
      email: "platform_admin@turing.io",
      password: "password"
    )
    platform_admin.roles << Role.find_by(name: "platform_admin")
  end

  def generate_roles
    Role.create!(name: "registered_user")
    puts "Role, registered user created successfully!"
    Role.create!(name: "business_admin")
    puts "Role, business admin created successfully!"
    Role.create!(name: "platform_admin")
    puts "Role, platform admin created successfully!"
  end

  def generate_orders
    100.times do |i|
      user  = User.all.shuffle.pop
      order = Order.create!(user_id: user.id)
      order_input = mock_session(user)
      OrderItemsSynthesizer.generate_order_items(order_input)
      puts "Order #{i}: Order for #{user.username} created!"
    end
  end

  private

  def mock_session(user)
    session = {"cart" => {}, "user_id" => user.id}
    rand(1..10).times do
      session["cart"][Item.all.shuffle.pop.id] = rand(1..5)
    end
    session
  end

  def add_items(order)
    10.times do |i|
      item = Item.find(rand(1..500))
      order.items << item
      order.order_items.each do |order_item|
        order_item.quantity = rand(1..10)
      end
      puts "#{i}: Added item #{item.name} to order #{order.id}."
    end
  end
end

Seed.start
