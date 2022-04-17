require 'rails_helper'

RSpec.feature "Questions::Index", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:question) { FactoryBot.create(:question) }

  before do
    sign_in user
    visit questions_path
  end

  scenario "質問情報を表示" do
    expect(page).to have_content question.user.name
    expect(page).to have_selector("img[src$='#{question.user.user_icon.identifier}']")
    expect(page).to have_content question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(page).to have_content question.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(page).to have_content question.q_title
    expect(page).to have_content question.q_content
  end
end
