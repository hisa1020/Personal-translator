require 'rails_helper'

RSpec.describe "Posts::New", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  before do
    sign_in user
    get new_post_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end
end
