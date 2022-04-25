FactoryBot.define do
  factory :question do
    sequence(:q_title) { |n| "Qtitle-#{n}" }
    sequence(:q_content) { |n| "This is question#{n}" }
    association :user
  end

  trait :q_others do
    q_title { 'Qtitle0' }
    q_content{ 'This is excluded Question'}
  end
end
