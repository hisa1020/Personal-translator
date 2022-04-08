require 'rails_helper'

RSpec.describe "Top::Index", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    get root_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end

  it "ユーザー名の表示" do
    expect(response.body).to include @user.name
  end
end
