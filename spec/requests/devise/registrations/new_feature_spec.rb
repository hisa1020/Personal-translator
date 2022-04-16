require 'rails_helper'

RSpec.describe "Users::Sign_Up", type: :request do
  let(:user) { FactoryBot.build(:user) }

  before do
    get new_user_registration_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end
end
