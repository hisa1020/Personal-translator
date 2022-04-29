require 'rails_helper'

RSpec.feature "Users::Sign_Up", type: :feature do
  before do
    @user = FactoryBot.build(:user)
    visit new_user_registration_path
  end

  scenario "ロゴのクリックでトップページに移動" do
    find('.header-logo-link').click
    expect(current_path).to eq root_path
  end

  context "新規登録成功" do
    scenario "全ての条件を満たす" do
      fill_in "name", with: @user.name
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      fill_in "password_confirmation", with: @user.password_confirmation
      click_button '新しいアカウントを作成'
      expect(current_path).to eq root_path
    end
  end

  scenario "サインインに移動" do
    click_link 'サインイン'
    expect(current_path).to eq new_user_session_path
  end

  scenario "トップページに移動" do
    click_link 'トップに戻る'
    expect(current_path).to eq root_path
  end
end
