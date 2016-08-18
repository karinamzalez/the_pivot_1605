class Seed
  def self.start
    seed = Seed.new
    seed.generate_categories
    seed.generate_businesses
    seed.generate_users
    seed.generate_items
    seed.generate_orders
  end

  def generate_categories
    10.times do
      FactoryGirl.create(:category)
    end
    puts "categories created successfully!"
  end

  def generate_businesses
    20.times do
      FactoryGirl.create(:business)
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

  def generate_users
    100.times do |i|
      user = FactoryGirl.create(:user)
      puts "User #{i}: #{user.username} - #{user.email} created!"
    end

    User.create!(username: 'Jorge', email: 'jorge@turing.io', password: "password")
    puts "Jorge created!"
  end

  def generate_items
    500.times do |i|
      item = Item.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        image_url: "http://robohash.org/#{i}.png?set=set2&bgset=bg1&size=200x200",
        category_id: rand(1..10),
        price: Faker::Commerce.price
      )
      puts "Item #{i}: #{item.name} created!"
    end
  end

  def generate_orders
    100.times do |i|
      user  = User.find(rand(1..100))
      order = Order.create!(user_id: user.id)
      add_items(order)
      puts "Order #{i}: Order for #{user.username} created!"
    end
  end

  private

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
