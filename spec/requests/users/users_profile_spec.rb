require 'rails_helper'

RSpec.describe "Users::Profile", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:posts) { FactoryBot.create_list(:post, rand(3), :with_feedback, user_id: user.id) }
  let!(:questions) { FactoryBot.create_list(:question, rand(3), user_id: user.id) }
  let!(:comments) { FactoryBot.create_list(:comment, rand(3), user_id: user.id) }
  let!(:q_comments) { FactoryBot.create_list(:q_comment, rand(3), user_id: user.id) }
  let!(:favorites) { FactoryBot.create_list(:favorite, rand(3), user_id: user.id) }
  let!(:q_favorites) { FactoryBot.create_list(:q_favorite, rand(3), user_id: user.id) }

  before do
    sign_in user
    get users_profile_path
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end

  it "ユーザー情報が表示される" do
    expect(response.body).to include user.name
    expect(response.body).to include user.introduction
    expect(response.body).to include user.posts_count.to_s
    expect(response.body).to include user.comments_count.to_s
    expect(response.body).to include user.favorites_count.to_s
  end
end
