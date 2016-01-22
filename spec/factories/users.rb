FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    picture_url { Faker::Avatar.image }
    username { Faker::Internet.user_name }
  end
end
