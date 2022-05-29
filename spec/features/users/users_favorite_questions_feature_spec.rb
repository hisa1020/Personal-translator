require 'rails_helper'
require 'spec_helper'

RSpec.feature "Users::Favorite_Questions", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }
  let!(:q_favorite) { FactoryBot.create(:q_favorite, user_id: user.id, question_id: question.id) }
  let!(:others_question) { FactoryBot.create(:question, :q_others) }

  before do
    sign_in user
    visit users_favorite_questions_path
  end

  scenario "いいねした投稿に移動" do
    within('.align-menu-bar') do
      click_link '投稿'
      expect(current_path).to eq users_favorite_posts_path
    end
  end

  scenario "質問詳細ページに移動できる" do
    find('.post-link-box').click
    expect(current_path).to eq question_path(question.id)
  end

  scenario "ユーザーのいいねした投稿を表示" do
    user.q_favorites.all? do |favorite|
      expect(page).to have_content favorite.question.user.name
      expect(page).to have_selector("img[src$='#{favorite.question.user.user_icon.identifier}']")
      expect(page).to have_content favorite.question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content favorite.question.q_title
      expect(page).to have_content favorite.question.q_content
      expect(page).to have_content favorite.question.q_favorites.count
      expect(page).to have_content favorite.question.q_comments.count
    end
  end

  scenario "いいねしてない質問を表示しない" do
    expect(page).not_to have_content others_question.q_title
    expect(page).not_to have_content others_question.q_content
  end
end
