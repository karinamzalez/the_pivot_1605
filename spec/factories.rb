FactoryGirl.define do
  city_names = [
    "London",
    "Paris",
    "Shanghai",
    "Dubai",
    "Sydney",
    "San Francisco",
    "New York"
  ]
  factory :business do
    name { Faker::Company.name }
    location city_names.sample
    user nil
  end

  factory :user do
    username { Faker::Internet.user_name }
    password "password"
    email { Faker::Internet.email }
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
    name { Faker::Color.color_name }
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
