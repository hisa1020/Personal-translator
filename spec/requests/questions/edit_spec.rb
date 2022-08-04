require 'rails_helper'

RSpec.describe "Questions::Edit", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }

  before do
    sign_in user
    get edit_question_path(question.id)
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end

  it "質問情報が表示される" do
    expect(response.body).to include question.q_title
    expect(response.body).to include question.q_content
  end
end
