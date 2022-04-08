FactoryBot.define do
  factory :user do
    email                           { Faker::Internet.free_email }
    password                        { 'abc1234' }
    password_confirmation           { password }
    name                            { Faker::Name.name }
    introduction                    { 'Nice to meet you!' }
    user_icon                       { 'assets/image/test.jpg' }
  end
end
