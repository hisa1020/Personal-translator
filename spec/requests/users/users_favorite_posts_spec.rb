require 'rails_helper'

RSpec.describe "Users::Favorite_Posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, :with_feedback) }
  let!(:favorite) { FactoryBot.create(:favorite, user_id: user.id, post_id: post.id) }
  let!(:others_post) { FactoryBot.create(:post, :others) }

  before do
    sign_in user
    get users_favorite_posts_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end

  it "お気に入りに登録済みの投稿の表示" do
    user.favorites.all? do |favorite|
      expect(response.body).to include favorite.post.user.name
      expect(response.body).to include favorite.post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(response.body).to include favorite.post.title
      expect(response.body).to include favorite.post.artist
      expect(response.body).to include favorite.post.content
      expect(response.body).to include favorite.post.favorites.count.to_s
      expect(response.body).to include favorite.post.comments.count.to_s
      expect(response.body).to include favorite.post.average.round(1).to_s
    end
  end

  it "お気に入りに登録されていない投稿を表示しない" do
    expect(response.body).not_to include others_post.title
    expect(response.body).not_to include others_post.content
  end
end
