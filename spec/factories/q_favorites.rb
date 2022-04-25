FactoryBot.define do
  factory :q_favorite do
    association :user
    association :question
  end
end
