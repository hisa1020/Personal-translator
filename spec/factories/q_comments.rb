FactoryBot.define do
  factory :q_comment do
    sequence(:q_content) { |n| "This is test-Qcomment#{n}" }
    association :user
    association :question
  end
end
