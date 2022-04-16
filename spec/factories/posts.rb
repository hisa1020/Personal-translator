FactoryBot.define do
  factory :post do
    title { "Test-Title" }
    content { "Test-Content" }
    association :user
  end
end
