require 'rails_helper'

RSpec.describe "Posts::New", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    get new_post_path
  end

  it "statusが200である" do
    expect(response.status).to eq(200)
  end
end
