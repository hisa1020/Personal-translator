require 'rails_helper'

RSpec.feature "Users::Sign_In", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
  end

  describe "サインイン" do
    context "サインイン成功" do
      scenario "全ての条件を満たす" do
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_button 'サインイン'
        expect(current_path).to eq root_path
      end
    end

    context "サインイン失敗" do
      scenario "メールアドレス認証失敗(空白)" do
        fill_in "email", with: ""
        fill_in "password", with: user.password
        click_button 'サインイン'
        expect(current_path).to eq new_user_session_path
      end

      scenario "メールアドレス認証失敗(不一致)" do
        fill_in "email", with: "abcdefghijklmn@sample.jp"
        fill_in "password", with: user.password
        click_button 'サインイン'
        expect(current_path).to eq new_user_session_path
      end

      scenario "パスワード認証失敗(空白)" do
        fill_in "email", with: user.email
        fill_in "password", with: ""
        click_button 'サインイン'
        expect(current_path).to eq new_user_session_path
      end

      scenario "パスワード認証失敗(不一致)" do
        fill_in "email", with: user.email
        fill_in "password", with: "123abcd"
        click_button 'サインイン'
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  scenario "新規登録に移動" do
    click_link '新しいアカウントを作成'
    expect(current_path).to eq new_user_registration_path
  end

  scenario "ゲストログイン" do
    click_link 'ゲストログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content("ゲストユーザーとしてサインインしました。")
  end

  scenario "トップページに移動" do
    click_link 'トップに戻る'
    expect(current_path).to eq root_path
  end
end
