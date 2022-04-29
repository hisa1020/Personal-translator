require 'rails_helper'

RSpec.feature "Users::Profile", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit users_profile_path
  end

  scenario "ロゴのクリックでトップページに移動" do
    find('.header-logo-link').click
    expect(current_path).to eq root_path
  end

  scenario "ユーザー情報の表示" do
    within('.user-view-box') do
      expect(page).to have_content user.name
      expect(page).to have_content user.introduction
      expect(page).to have_content user.email
      expect(page).to have_selector("img[src$='#{user.user_icon.filename}']")
    end
  end

  scenario "プロフィール編集に移動" do
    click_link 'プロフィールを編集'
    expect(current_path).to eq users_profile_edit_path
  end

  scenario "パスワード変更に移動" do
    click_link 'パスワードを変更'
    expect(current_path).to eq edit_user_registration_path
  end
end
