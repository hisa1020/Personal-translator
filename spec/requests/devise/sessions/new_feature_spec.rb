require 'rails_helper'

RSpec.describe "Users::Sign_In", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    get new_user_session_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end
end
