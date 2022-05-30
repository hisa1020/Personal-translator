require 'rails_helper'
require 'spec_helper'

RSpec.feature "Users::Favorite_Posts", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, :with_feedback) }
  let!(:favorite) { FactoryBot.create(:favorite, user_id: user.id, post_id: post.id) }
  let!(:others_post) { FactoryBot.create(:post, :others) }

  before do
    sign_in user
    visit users_favorite_posts_path
  end

  scenario "いいね(質問)に移動" do
    within('.align-menu-bar') do
      click_link '質問'
      expect(current_path).to eq users_favorite_questions_path
    end
  end

  scenario "投稿詳細ページに移動できる" do
    find('.post-link-box').click
    expect(current_path).to eq post_path(post.id)
  end

  scenario "ユーザーがいいねした投稿を表示" do
    user.favorites.all? do |favorite|
      expect(page).to have_content favorite.post.user.name
      expect(page).to have_selector("img[src$='#{favorite.post.user.user_icon.identifier}']")
      expect(page).to have_content favorite.post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content favorite.post.title
      expect(page).to have_content favorite.post.artist
      expect(page).to have_content favorite.post.content
      expect(page).to have_content favorite.post.favorites.count
      expect(page).to have_content favorite.post.comments.count
      expect(page).to have_content favorite.post.average.round(1)
    end
  end

  scenario "いいねしてない投稿を表示しない" do
    expect(page).not_to have_content others_post.title
    expect(page).not_to have_content others_post.artist
    expect(page).not_to have_content others_post.content
  end
end
