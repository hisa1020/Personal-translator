FactoryBot.define do
  factory :comment do
    rate { Faker::Number.between(from: 1, to: 5) }
    sequence(:content) { |n| "This is test-comment#{n}" }
    association :user
    association :post
  end

  trait :no_content do
    rate { Faker::Number.between(from: 1, to: 5) }
    association :user
    association :post
  end
end
