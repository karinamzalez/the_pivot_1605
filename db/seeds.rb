class Seed
  def self.start
    generate_categories
    generate_businesses
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

  def generate_users
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
