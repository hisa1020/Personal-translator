require 'rails_helper'

RSpec.feature "Top::Index", type: :feature do
  context "新規登録/サインイン前" do
    before do
      visit root_path
    end

    scenario "ログインページに移動" do
      find('.signin-link').click
      expect(current_path).to eq new_user_session_path
    end

    scenario "新規登録に移動" do
      click_link '会員登録'
      expect(current_path).to eq new_user_registration_path
    end
  end

  context "サインイン後" do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
      visit root_path
    end

    scenario "プロフィールに移動" do
      find('.users-profile-link').click
      expect(current_path).to eq users_profile_path
    end

    scenario "ユーザー名の表示" do
      within('.form-users-profile-link') do
        expect(page).to have_content @user.name
      end
    end

    scenario "ログアウト状態でトップページに移動" do
      find('.signout-link').click
      expect(current_path).to eq root_path
      expect(page).to have_link '会員登録' 
    end

    scenario "プロフィールに移動" do
      find('.form-users-profile-link').click
      expect(current_path).to eq users_profile_path
    end
  end
end
