FactoryGirl.define do
  factory :goal do
    title { Faker::Lorem.words(3).join(" ") }
  end
end
