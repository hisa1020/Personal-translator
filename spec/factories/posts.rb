FactoryBot.define do
  factory :post do
    title { "Test-Post-Title" }
    content { "Test-Post-Content" }
    association :user
  end
end
