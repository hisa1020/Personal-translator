require 'rails_helper'

RSpec.feature "Questions::Show", type: :feature do
  context "ログインユーザーと質問者が同じ場合" do
    let(:user) { FactoryBot.create(:user) }
    let!(:question) { FactoryBot.create(:question, user_id: user.id) }

    before do
      sign_in user
      visit question_path(question.id)
    end

    scenario "質問編集ページに移動できる" do
      find('.question-edit-link').click
      expect(current_path).to eq edit_question_path(question.id)
    end

    scenario "質問を削除できる" do
      find('.question-delete-link').click
    end

    scenario "質問情報を表示" do
      expect(page).to have_content question.user.name
      expect(page).to have_selector("img[src$='#{question.user.user_icon.identifier}']")
      expect(page).to have_content question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.q_title
      expect(page).to have_content question.q_content
    end
  end

  context "ログインユーザーと質問者が違う場合" do
    let(:user) { FactoryBot.create(:user) }
    let!(:question) { FactoryBot.create(:question) }

    before do
      sign_in user
      visit question_path(question.id)
    end

    scenario "質問情報を表示" do
      expect(page).to have_content question.user.name
      expect(page).to have_selector("img[src$='#{question.user.user_icon.identifier}']")
      expect(page).to have_content question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.q_title
      expect(page).to have_content question.q_content
    end
  end
end
