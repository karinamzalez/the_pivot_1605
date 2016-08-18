class Seed
  def self.start
    generate_categories
    generate_businesses
    generate_users
    generate_items
    generate_orders
  end

  def self.generate_categories
    10.times do
      category = FactoryGirl.create(:category)
      add_items(category)
    end
    puts "categories created successfully!"
  end

  def self.generate_businesses
    20.times do
      FactoryGirl.create(:business)
    end
    puts "businesses created successfully!"
  end

  def self.generate_users
    2.times do
      FactoryGirl.create(:user)
    end
    puts "users created successfully!"
  end
end

Seed.start

class Seed
  def initialize
    generate_users
    generate_items
    generate_orders
  end

  def generate_users
    100.times do |i|
      user = User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email
        )
      puts "User #{i}: #{user.name} - #{user.email} created!"
    end

    User.create!(name: 'Jorge', email: 'jorge@turing.io', password: "password")
    puts "Jorge created!"
  end

  def generate_items
    500.times do |i|
      item = Item.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        image_url: "http://robohash.org/#{i}.png?set=set2&bgset=bg1&size=200x200"
        )
      puts "Item #{i}: #{item.name} created!"
    end
  end

  def generate_orders
    100.times do |i|
      user  = User.find(i)
      order = Order.create!(user_id: user.id)
      add_items(order)
      puts "Order #{i}: Order for #{user.name} created!"
    end
  end

  private

  def add_ten_items(class_type)
    10.times do |i|
      item = Item.find(Random.new.rand(1..500))
      class_type.items << item
      puts "#{i}: Added item #{item.name} to order #{order.id}."
    end
  end

  def add_fifty_items(class_type)
    50.times do |i|
      item = Item.find(Random.new.rand(1..500))
      class_type.items << item
      puts "#{i}: Added item #{item.name} to order #{order.id}."
    end
  end
end

Seed.new
