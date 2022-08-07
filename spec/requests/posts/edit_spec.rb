require 'rails_helper'

RSpec.describe "Posts::Edit", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  before do
    sign_in user
    get edit_post_path(post.id)
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end

  it "投稿情報が表示される" do
    expect(response.body).to include post.title
    expect(response.body).to include post.artist
    expect(response.body).to include post.content
  end
end
