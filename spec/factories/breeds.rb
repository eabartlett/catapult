FactoryGirl.define do
  factory :breed do
    name { Faker::Lorem.word }
    tags []
  end
end
