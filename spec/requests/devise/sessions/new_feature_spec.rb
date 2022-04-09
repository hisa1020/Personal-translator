require 'rails_helper'

RSpec.describe "Users::Sign_In", type: :request do
  before do
    @user = FactoryBot.create(:user)
    get new_user_session_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end
end
