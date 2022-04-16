require 'rails_helper'

RSpec.describe "Posts::Edit", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  before do
    sign_in user
    get edit_post_path(post.id)
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end

  it "ユーザー情報の表示" do
    expect(response.body).to include post.title
    expect(response.body).to include post.content
  end
end
