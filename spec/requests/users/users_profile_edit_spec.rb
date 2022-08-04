require 'rails_helper'

RSpec.describe "Users::Profile_Edit", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    get users_profile_edit_path
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end

  it "ユーザー情報が表示される" do
    expect(response.body).to include user.name
    expect(response.body).to include user.introduction
  end
end
