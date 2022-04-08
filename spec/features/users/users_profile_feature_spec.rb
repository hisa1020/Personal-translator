require 'rails_helper'

RSpec.feature "Users::Profile", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    visit users_profile_path
  end

  scenario "ロゴのクリックでトップページに移動" do
    find('.header-logo-link').click
    expect(current_path).to eq root_path
  end

  describe "user_nav内のリンクのテスト" do
    context ".user-nav-pc内のリンクのテスト" do
      scenario "プロフィール編集に移動" do
        within('.user-nav-pc') do
          click_link 'プロフィール編集'
          expect(current_path).to eq users_profile_edit_path
        end
      end
    end

    context ".user-nav-mobile内のリンクのテスト" do
      scenario "プロフィール編集に移動" do
        within('.user-nav-mobile') do
          click_link 'プロフィール編集'
          expect(current_path).to eq users_profile_edit_path
        end
      end
    end
  end

  scenario "ユーザー情報の表示" do
    within('.user-view-box') do
      expect(page).to have_content @user.name
      expect(page).to have_content @user.introduction
      expect(page).to have_content @user.email
    end
  end

  scenario "プロフィール編集に移動" do
    within('.user-view-box') do
      click_link 'プロフィールを編集'
      expect(current_path).to eq users_profile_edit_path
    end
  end

  scenario "パスワード変更に移動" do
    within('.user-view-box') do
      click_link 'パスワードを変更'
      expect(current_path).to eq edit_user_registration_path
    end
  end
end
