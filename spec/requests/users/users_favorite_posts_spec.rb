require 'rails_helper'

RSpec.describe "Users::Favorite_Posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  let!(:comments) { FactoryBot.create_list(:comment, rand(10), post_id: post.id) }
  let!(:favorite) { FactoryBot.create(:favorite, user_id: user.id, post_id: post.id) }
  let!(:favorites) { FactoryBot.create_list(:favorite, rand(10), post_id: post.id) }

  before do
    sign_in user
    get users_favorite_posts_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end

  it "ユーザーと紐付いた投稿の表示" do
    user.favorites.all? do |favorite|
      expect(response.body).to include favorite.post.user.name
      expect(response.body).to include favorite.post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(response.body).to include favorite.post.title
      expect(response.body).to include favorite.post.content
      expect(response.body).to include favorite.post.favorites.count.to_s
      expect(response.body).to include favorite.post.comments.count.to_s
    end
  end
end
