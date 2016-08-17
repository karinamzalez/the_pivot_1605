class Seed
  def self.start
    generate_categories
    generate_businesses
    generate_users
  end

  def self.generate_categories
    3.times do
      FactoryGirl.create(:category)
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
    User.create(
    username: "hollagonzalla",
    password: "password"
    )
    2.times do
      FactoryGirl.create(:user)
    end
    puts "users created successfully!"
  end
end

Seed.start
