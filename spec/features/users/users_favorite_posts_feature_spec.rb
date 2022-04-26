require 'rails_helper'

RSpec.feature "Users::Favorite_Posts", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  let!(:comments) { FactoryBot.create_list(:comment, rand(10), post_id: post.id) }
  let!(:favorite) { FactoryBot.create(:favorite, user_id: user.id, post_id: post.id) }
  let!(:favorites) { FactoryBot.create_list(:favorite, rand(10), post_id: post.id) }

  before do
    sign_in user
    visit users_favorite_posts_path
  end

  scenario "お気に入り(質問)に移動" do
    within('.align-menu-bar') do
      click_link '質問'
      expect(current_path).to eq users_favorite_questions_path
    end
  end

  scenario "ユーザーのお気に入りの投稿を表示" do
    user.favorites.all? do |favorite|
      expect(page).to have_content favorite.post.user.name
      expect(page).to have_selector("img[src$='#{favorite.post.user.user_icon.identifier}']")
      expect(page).to have_content favorite.post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content favorite.post.title
      expect(page).to have_content favorite.post.content
      expect(page).to have_content favorite.post.favorites.count
      expect(page).to have_content favorite.post.comments.count
    end
  end
end
