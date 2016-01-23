FactoryGirl.define do
  factory :post do
    user
    media { Faker::Avatar.image }
    content { Faker::Hipster.sentence }
  end
end
