require 'rails_helper'

RSpec.describe "Posts::Show", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }

  before do
    sign_in user
    get post_path(post.id)
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end

  it "ユーザー情報の表示" do
    expect(response.body).to include post.user.name
    expect(response.body).to include post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(response.body).to include post.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(response.body).to include post.title
    expect(response.body).to include post.content
    expect(response.body).to include post.comments.count.to_s
    expect(response.body).to include post.favorites.count.to_s
  end
end
