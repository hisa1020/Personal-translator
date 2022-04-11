FactoryBot.define do
  factory :user do
    email                           { Faker::Internet.free_email }
    password                        { 'abc1234' }
    password_confirmation           { password }
    name                            { Faker::Name.name }
    introduction                    { 'Nice to meet you!' }
    user_icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test.jpg')) }
  end
end
