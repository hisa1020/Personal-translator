FactoryBot.define do
  factory :question do
    sequence(:q_title) { |n| "Qtitle-#{n}" }
    sequence(:q_content) { |n| "This is question#{n}" }
    association :user

    after(:create) do |question|
      create_list(:q_comment, rand(3), question_id: question.id)
      create_list(:q_favorite, rand(3), question_id: question.id)
    end
  end

  trait :q_others do
    q_title { 'Qtitle0' }
    q_content { 'This is excluded Question' }
  end
end
