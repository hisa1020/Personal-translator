require 'rails_helper'

RSpec.describe "Users::Profile_Edit", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    get users_profile_edit_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end

  it "ユーザー情報の表示" do
    expect(response.body).to include user.name
    expect(response.body).to include user.introduction
  end
end
