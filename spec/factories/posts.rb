FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "title-#{n}" }
    sequence(:content) { |n| "This is post#{n}" }
    association :user

    after(:create) do |post|
      create_list(:comment, rand(3), post_id: post.id)
      create_list(:favorite, rand(3), post_id: post.id)
    end
  end

  trait :others do
    title { 'title0' }
    content { 'This is excluded post' }
  end
end
