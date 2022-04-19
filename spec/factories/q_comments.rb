FactoryBot.define do
  factory :q_comment do
    q_content { "Test-Question-comment" }
    association :user
    association :question
  end
end
