require 'rails_helper'

RSpec.feature "Users::Edit", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    visit edit_user_registration_path
  end

  scenario "ユーザーのメールアドレスを表示" do
    expect(page).to have_field("email", with: @user.email)
  end

  context "パスワード変更成功" do
    scenario "全ての条件を満たす" do
      fill_in "email", with: @user.email
      fill_in "new-password", with: 'xyz6789'
      fill_in "new-password-confirmation", with: 'xyz6789'
      fill_in "current_password", with: @user.password
      click_button 'パスワードを更新'
      expect(current_path).to eq root_path
    end
  end

  scenario "プロフィールに戻る" do
    click_link '戻る'
    expect(current_path).to eq users_profile_path
  end
end
