FactoryGirl.define do

  factory :role do
    factory :platform_admin_role do
      name 'platform_admin'
    end
    factory :business_admin_role do
      name 'business_admin'
    end
    factory :registered_user_role do
      name 'registered_user'
    end
  end

  factory :user do
    username { Faker::Internet.user_name }
    password "password"
    email { Faker::Internet.email }

    trait :as_platform_admin do
      after(:create) do |user|
        user.roles << create(:platform_admin_role)
      end
    end

    trait :as_business_admin do
      after(:create) do |user|
        user.roles << create(:business_admin_role)
      end
    end

    trait :as_registered_user do
      after(:create) do |user|
        user.roles << create(:registered_user_role)
      end
    end
  end

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

  factory :business do
    name { Faker::Company.name }
    location city_names.sample
    status 1
  end

  items = [
    'apples',
    'pears',
    'bananas',
    'asparagus',
    'spinach',
    'bok choy',
    'pineapple',
    'guava',
    'dragon fruit'
  ]

  factory :item do
    name items.sample
    price { Faker::Commerce.price }
    description { Faker::Hipster.paragraph }
    image_url { Faker::Placeholdit.image }
    category
    status true
  end

  factory :category do
    name { Faker::Color.color_name + "#{rand(100)}" }
  end

  factory :order do
    user
    status 0
  end

  factory :order_item do
    item
    order
    quantity 1
  end
end
