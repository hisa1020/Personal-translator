require 'rails_helper'

RSpec.feature "Users::Favorite_Questions", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }
  let(:q_comment) { FactoryBot.build(:q_comment, question_id: question.id) }
  let(:q_favorite) { FactoryBot.create(:q_favorite, user_id: user.id, question_id: question.id) }

  before do
    sign_in user
    visit users_favorite_questions_path
  end

  scenario "お気に入り(質問)に移動" do
    within('.align-menu-bar') do
      click_link '投稿'
      expect(current_path).to eq users_favorite_posts_path
    end
  end

  scenario "ユーザーのお気に入りの投稿を表示" do
    user.q_favorites.all? do |favorite|
      expect(page).to have_content favorite.post.user.name
      expect(page).to have_selector("img[src$='#{favorite.post.user.user_icon.identifier}']")
      expect(page).to have_content favorite.post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content favorite.post.q_title
      expect(page).to have_content favorite.post.q_content
      expect(page).to have_content favorite.post.q_favorites.count
      expect(page).to have_content favorite.post.q_comments.count
    end
  end
end
