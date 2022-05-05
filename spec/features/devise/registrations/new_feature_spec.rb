require 'rails_helper'
require 'spec_helper'

RSpec.feature "Users::Sign_Up", type: :feature do
  let(:user) { FactoryBot.build(:user) }

  before do
    visit new_user_registration_path
  end

  scenario "ロゴのクリックでトップページに移動" do
    find('.header-logo-link').click
    expect(current_path).to eq root_path
  end

  describe "パスワード変更" do
    context "新規登録成功" do
      scenario "全ての条件を満たす" do
        fill_in "name", with: user.name
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(current_path).to eq root_path
      end
    end

    context "新規登録失敗" do
      scenario "nameが空" do
        fill_in "name", with: ''
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("ユーザー名を入力してください")
      end

      scenario "nameが3文字以下" do
        fill_in "name", with: 'aa'
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("ユーザー名は3文字以上で入力してください")
      end

      scenario "nameが12文字以上" do
        fill_in "name", with: 'a' * 13
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("ユーザー名は12文字以内で入力してください")
      end

      scenario "emailが空" do
        fill_in "name", with: user.name
        fill_in "email", with: ''
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("メールアドレスを入力してください")
      end

      scenario "emailが重複" do
        user.save
        another_user = FactoryBot.build(:user)
        another_user.email = user.email
        fill_in "name", with: another_user.name
        fill_in "email", with: another_user.email
        fill_in "password", with: another_user.password
        fill_in "password_confirmation", with: another_user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("メールアドレスはすでに存在します")
      end

      scenario "passwordが空" do
        fill_in "name", with: user.name
        fill_in "email", with: user.email
        fill_in "password", with: ''
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("パスワードを入力してください")
      end

      scenario "passwordが6文字以下" do
        fill_in "name", with: user.name
        fill_in "email", with: user.email
        fill_in "password", with: 'aaaaa'
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("パスワードは6文字以上で入力してください")
      end

      scenario "password_confirmationが空" do
        fill_in "name", with: user.name
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: ''
        click_button '新しいアカウントを作成'
        expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
      end

      scenario "passwordとpassword_confirmationが不一致" do
        fill_in "name", with: user.name
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: 'aaa000'
        click_button '新しいアカウントを作成'
        expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
      end
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
