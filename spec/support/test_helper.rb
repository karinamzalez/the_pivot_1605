module TestHelper
  def seed_test_data
    create_test_businesses
    create_test_categories
    create_test_business_items
    create_roles
    create_business_admins
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

  def create_roles
    Role.create(name: "business_admin")
    Role.create(name: "platform_admin")
    Role.create(name: "registered_user")
  end

  def create_business_admins
    create_test_businesses
    create_roles
    admin_1 = User.create(
      username: "business_admin_1",
      email: "businessadmin1@turing.io",
      password: "password",
      business_id: Business.first.id
    )
    admin_2 = User.create(
      username: "business_admin_2",
      email: "businessadmin2@turing.io",
      password: "password",
      business_id: Business.first.id
    )
    admin_3 = User.create(
      username: "business_admin_3",
      email: "businessadmin3@turing.io",
      password: "password",
      business_id: Business.first.id
    )
    admin_1.roles << Role.find_by(name: "business_admin")
    admin_2.roles << Role.find_by(name: "business_admin")
    admin_3.roles << Role.find_by(name: "business_admin")
  end
  
  def create_platform_admin
    create_test_businesses
    create_roles
    platform_admin = User.create(
      username: "platform_admin",
      email: "platform_admin@turing.io",
      password: "password"
    )
    platform_admin.roles << Role.find_by(name: "platform_admin")
    platform_admin
  end
end
