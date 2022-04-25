FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "title-#{n}" }
    sequence(:content) { |n| "This is post#{n}" }
    association :user
  end

  trait :others do
    title { 'title0' }
    content{ 'This is excluded post'}
  end
end
