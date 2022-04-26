FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "This is test-comment#{n}" }
    association :user
    association :post
  end
end
