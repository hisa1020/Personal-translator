require 'rails_helper'

RSpec.describe "Search", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    get search_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end
end
