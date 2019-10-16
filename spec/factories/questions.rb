FactoryBot.define do
  factory :question do
    user
    title { Faker::Lorem.question }
    body  { Faker::Lorem.paragraph }

    factory :question_invalid do
      title { nil }
      body  { nil }
    end
  end
end
