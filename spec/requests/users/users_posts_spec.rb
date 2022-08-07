require 'rails_helper'

RSpec.describe "Users::Posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, :with_feedback, user_id: user.id) }
  let!(:others_post) { FactoryBot.create(:post, :others) }

  before do
    sign_in user
    get users_posts_path
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end

  it "ユーザーと紐付いた投稿が表示される" do
    user.posts.all? do |post|
      expect(response.body).to include post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(response.body).to include post.title
      expect(response.body).to include post.artist
      expect(response.body).to include post.content
      expect(response.body).to include post.favorites.count.to_s
      expect(response.body).to include post.comments.count.to_s
      expect(response.body).to include post.average.round(1).to_s
    end
  end

  it "ユーザーと紐づかない投稿を表示しない" do
    expect(response.body).not_to include others_post.title
    expect(response.body).not_to include others_post.content
  end
end
