require 'rails_helper'

RSpec.describe "Users::Show", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:posts) { FactoryBot.create_list(:post, rand(3), :with_feedback, user_id: user.id) }
  let!(:questions) { FactoryBot.create_list(:question, rand(3), user_id: user.id) }
  let!(:others_post) { FactoryBot.create(:post, :others) }

  before do
    sign_in user
    get user_path(user.id)
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end

  it "ユーザー情報の表示" do
    expect(response.body).to include user.name
    expect(response.body).to include user.introduction
    expect(response.body).to include user.posts.count.to_s
    expect(response.body).to include user.questions.count.to_s
    expect(response.body).to include user.user_score.round(1).to_s
  end

  it "ユーザーと紐付いた投稿の表示" do
    user.posts.all? do |post|
      expect(response.body).to include post.user.name
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
