FactoryBot.define do
  factory :comment do
    content { "Test-Comment" }
    association :user
    association :post
  end
end
