require 'rails_helper'

RSpec.feature "Users::Sign_In", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
  end

  context "サインイン成功" do
    scenario "全ての条件を満たす" do
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      click_button 'サインイン'
      expect(current_path).to eq root_path
    end
  end

  scenario "新規登録に移動" do
    click_link '新しいアカウントを作成'
    expect(current_path).to eq new_user_registration_path
  end

  scenario "トップページに移動" do
    click_link 'トップに戻る'
    expect(current_path).to eq root_path
  end
end
