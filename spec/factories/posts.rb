FactoryBot.define do
  factory :post do
    title { 'title' }
    artist { 'artist' }
    content { 'This is post without comments and favorites' }
    association :user
  end

  trait :with_feedback do
    sequence(:title) { |n| "title-#{n}" }
    sequence(:artist) { |n| "artist-#{n}" }
    sequence(:content) { |n| "This is post#{n}" }
    association :user

    after(:create) do |post|
      create_list(:comment, rand(1..3), post_id: post.id)
      create_list(:favorite, rand(1..3), post_id: post.id)
    end
  end

  trait :others do
    title { 'youthful days' }
    artist { 'Mr.Children' }
    content { 'This is post for search and unrelation' }
    association :user
  end
end
