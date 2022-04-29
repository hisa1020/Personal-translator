require 'rails_helper'

RSpec.describe "Questions::New", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }

  before do
    sign_in user
    get new_question_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end
end
