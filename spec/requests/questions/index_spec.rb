require 'rails_helper'

RSpec.describe "Questions::Index", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:question) { FactoryBot.create(:question) }

  before do
    sign_in user
    get questions_path
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end

  it "質問情報が表示される" do
    expect(response.body).to include question.user.name
    expect(response.body).to include question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(response.body).to include question.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(response.body).to include question.q_title
    expect(response.body).to include question.q_content
    expect(response.body).to include question.q_comments.count.to_s
    expect(response.body).to include question.q_favorites.count.to_s
  end
end
