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

  factory :item do
    name { Faker::Name.first_name }
    price { Faker::Commerce.price }
    desc { Faker::Lorem.sentence }
    image_url { Faker::Placeholdit.image }
    category
  end

  factory :category do
    name { Faker::Company.profession }
  end

  factory :order do
    user
    status 0
  end

  # factory :order_gnome do
  #   gnome
  #   order
  #   quantity 1
  # end
end
