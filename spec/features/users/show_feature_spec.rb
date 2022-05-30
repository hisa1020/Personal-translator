require 'rails_helper'
require 'spec_helper'

RSpec.feature "Users::Show", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, :with_feedback, user_id: user.id) }
  let!(:questions) { FactoryBot.create_list(:question, rand(3), user_id: user.id) }
  let!(:others_post) { FactoryBot.create(:post, :others) }

  before do
    sign_in user
    visit user_path(user.id)
  end

  scenario "ユーザー情報の表示" do
    expect(page).to have_selector("img[src$='#{user.user_icon.identifier}']")
    expect(page).to have_content user.name
    expect(page).to have_content user.introduction
    expect(page).to have_content user.posts.count
    expect(page).to have_content user.questions.count
    expect(page).to have_content user.favorites_count
  end

  scenario "ユーザーの投稿を表示" do
    user.posts.all? do |post|
      expect(page).to have_content post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.title
      expect(page).to have_content post.artist
      expect(page).to have_content post.content
      expect(page).to have_content post.favorites.count
      expect(page).to have_content post.comments.count
      expect(page).to have_content post.average.round(1)
    end
  end

  scenario "投稿詳細ページに移動できる" do
    find('.post-link-box').click
    expect(current_path).to eq post_path(post.id)
  end

  scenario "ユーザーと紐づかない投稿を表示しない" do
    expect(page).not_to have_content others_post.title
    expect(page).not_to have_content others_post.artist
    expect(page).not_to have_content others_post.content
  end
end
