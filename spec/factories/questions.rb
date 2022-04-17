FactoryBot.define do
  factory :question do
    q_title { "Test-Question-title" }
    q_content { "Test-Question-Content" }
    association :user
  end
end
