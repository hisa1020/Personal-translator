require 'rails_helper'

RSpec.describe "Users::Questions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question, user_id: user.id) }

  before do
    sign_in user
    get users_questions_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end

  it "ユーザーと紐付いた質問の表示" do
    user.questions.all? do |question|
      expect(response.body).to include question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(response.body).to include question.q_title
      expect(response.body).to include question.q_content
      expect(response.body).to include question.q_favorites.count.to_s
      expect(response.body).to include question.q_comments.count.to_s
    end
  end
end
