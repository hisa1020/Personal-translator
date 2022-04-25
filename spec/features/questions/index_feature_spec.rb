require 'rails_helper'

RSpec.feature "Questions::Index", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:question) { FactoryBot.create(:question) }
  let(:q_comment) { FactoryBot.build(:q_comment, question_id: question.id) }
  let(:q_favorite) { FactoryBot.create(:q_favorite, question_id: question.id) }

  before do
    sign_in user
    visit questions_path
  end

  describe "post_nav内のリンクが正常に作動する" do
    context ".post-nav-pc内のリンク" do
      scenario "投稿一覧に移動" do
        within('.post-nav-pc') do
          click_link '投稿一覧'
          expect(current_path).to eq posts_path
        end
      end
    end

    context ".post-nav-mobile内のリンク" do
      scenario "投稿一覧に移動" do
        within('.post-nav-mobile') do
          click_link '投稿一覧'
          expect(current_path).to eq posts_path
        end
      end
    end
  end

  scenario "質問情報を表示" do
    expect(page).to have_content question.user.name
    expect(page).to have_selector("img[src$='#{question.user.user_icon.identifier}']")
    expect(page).to have_content question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(page).to have_content question.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(page).to have_content question.q_title
    expect(page).to have_content question.q_content
    expect(page).to have_content question.q_favorites.count
    expect(page).to have_content question.q_comments.count
  end
end
