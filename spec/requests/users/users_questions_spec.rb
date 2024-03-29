require 'rails_helper'

RSpec.describe "Users::Questions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:question) { FactoryBot.create(:question, user_id: user.id) }
  let!(:others_question) { FactoryBot.create(:question, :q_others) }

  before do
    sign_in user
    get users_questions_path
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end

  it "ユーザーと紐付いた質問が表示される" do
    user.questions.all? do |question|
      expect(response.body).to include question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(response.body).to include question.q_title
      expect(response.body).to include question.q_content
      expect(response.body).to include question.q_favorites.count.to_s
      expect(response.body).to include question.q_comments.count.to_s
    end
  end

  it "ユーザーと紐づかない質問を表示しない" do
    expect(response.body).not_to include others_question.q_title
    expect(response.body).not_to include others_question.q_content
  end
end
