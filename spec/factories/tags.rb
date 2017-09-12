FactoryGirl.define do
  factory :tag do
    name { Faker::Lorem.word }
    breeds []
  end
end
