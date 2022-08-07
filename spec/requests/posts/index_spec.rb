require 'rails_helper'

RSpec.describe "Posts::Index", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, :with_feedback) }

  before do
    sign_in user
    get posts_path
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end

  it "投稿情報が表示される" do
    expect(response.body).to include post.user.name
    expect(response.body).to include post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(response.body).to include post.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(response.body).to include post.title
    expect(response.body).to include post.artist
    expect(response.body).to include post.content
    expect(response.body).to include post.comments.count.to_s
    expect(response.body).to include post.favorites.count.to_s
    expect(response.body).to include post.average.round(1).to_s
  end
end
