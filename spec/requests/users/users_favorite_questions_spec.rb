require 'rails_helper'

RSpec.describe "Users::Favorite_Questions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }
  let!(:q_favorite) { FactoryBot.create(:q_favorite, user_id: user.id, question_id: question.id) }
  let!(:others_question) { FactoryBot.create(:question, :q_others) }

  before do
    sign_in user
    get users_favorite_questions_path
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end

  it "お気に入りに登録された質問が表示される" do
    user.q_favorites.all? do |favorite|
      expect(response.body).to include favorite.question.user.name
      expect(response.body).to include favorite.question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(response.body).to include favorite.question.q_title
      expect(response.body).to include favorite.question.q_content
      expect(response.body).to include favorite.question.q_favorites.count.to_s
      expect(response.body).to include favorite.question.q_comments.count.to_s
    end
  end

  scenario "お気に入りに登録されていない質問を表示しない" do
    expect(response.body).not_to include others_question.q_title
    expect(response.body).not_to include others_question.q_content
  end
end
