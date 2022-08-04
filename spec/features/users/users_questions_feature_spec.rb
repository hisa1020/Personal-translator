require 'rails_helper'
require 'spec_helper'

RSpec.feature "Users::Questions", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:question) { FactoryBot.create(:question, user_id: user.id) }
  let!(:others_question) { FactoryBot.create(:question, :q_others) }

  before do
    sign_in user
    visit users_questions_path
  end

  scenario "質問詳細ページに移動" do
    find('.post-link-box').click
    expect(current_path).to eq question_path(question.id)
  end

  scenario "ユーザーの質問を表示" do
    user.questions.all? do |question|
      expect(page).to have_content question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.q_title
      expect(page).to have_content question.q_content
      expect(page).to have_content question.q_favorites.count
      expect(page).to have_content question.q_comments.count
    end
  end

  scenario "ユーザーと紐づかない質問を表示しない" do
    expect(page).not_to have_content others_question.q_title
    expect(page).not_to have_content others_question.q_content
  end
end
