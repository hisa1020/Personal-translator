require 'rails_helper'
require 'spec_helper'

RSpec.feature "Users::Sign_In", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
  end

  describe "サインイン" do
    context "サインイン成功" do
      scenario "メールアドレス、パスワードが入力されていると成功" do
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_button 'サインイン'
        expect(current_path).to eq root_path
      end
    end

    context "サインイン失敗" do
      scenario "メールアドレスが空だと失敗" do
        fill_in "email", with: ""
        fill_in "password", with: user.password
        click_button 'サインイン'
        expect(page).to have_content("メールアドレス もしくはパスワードが不正です。")
      end

      scenario "メールアドレスが正しくないと失敗" do
        fill_in "email", with: "abcdefghijklmn@sample.jp"
        fill_in "password", with: user.password
        click_button 'サインイン'
        expect(page).to have_content("メールアドレス もしくはパスワードが不正です。")
      end

      scenario "パスワードが空だと失敗" do
        fill_in "email", with: user.email
        fill_in "password", with: ""
        click_button 'サインイン'
        expect(page).to have_content("メールアドレス もしくはパスワードが不正です。")
      end

      scenario "パスワードが正しくないと失敗" do
        fill_in "email", with: user.email
        fill_in "password", with: "123abcd"
        click_button 'サインイン'
        expect(page).to have_content("メールアドレス もしくはパスワードが不正です。")
      end
    end
  end

  scenario "新規登録に移動" do
    click_link '新しいアカウントを作成'
    expect(current_path).to eq new_user_registration_path
  end

  scenario "ゲストログインができる" do
    click_link 'ゲストログイン'
    expect(page).to have_content("ゲストユーザーとしてサインインしました。")
  end

  scenario "トップページに移動" do
    click_link 'トップに戻る'
    expect(current_path).to eq root_path
  end
end
