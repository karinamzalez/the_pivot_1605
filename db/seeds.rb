class Seed
  def self.start
    seed = Seed.new
    seed.generate_users
    seed.generate_categories
    seed.generate_businesses
    seed.generate_business_items
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

  def generate_business_items
    Business.all.each do |business|
      rand(25..40).times do
        business.items << Item.create!(
          name: Faker::Commerce.product_name,
          description: Faker::Lorem.paragraph,
          image_url: "http://robohash.org/#{rand(500)}.png?set=set2&bgset=bg1&size=200x200",
          category_id: rand(1..Category.all.count),
          price: Faker::Commerce.price
        )
        puts "Item #{Item.last.id}: #{Item.last.name} created!"
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

  # def add_items(order)
  #   10.times do |i|
  #     item = Item.find(rand(1..500))
  #     order.items << item
  #     puts "#{i}: Added item #{item.name} to order #{order.id}."
  #   end
  # end
end

Seed.start
