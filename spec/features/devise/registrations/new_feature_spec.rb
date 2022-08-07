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

  describe "新規登録" do
    context "新規登録成功" do
      scenario "ユーザー名、メールアドレス、パスワード、確認用パスワードが入力されていると成功" do
        fill_in "name", with: user.name
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(current_path).to eq root_path
      end
    end

    context "新規登録失敗" do
      scenario "ユーザー名が空だと失敗" do
        fill_in "name", with: ''
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("ユーザー名を入力してください")
      end

      scenario "ユーザー名が3文字以下だと失敗" do
        fill_in "name", with: 'aa'
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("ユーザー名は3文字以上で入力してください")
      end

      scenario "ユーザー名が12文字以上だと失敗" do
        fill_in "name", with: 'a' * 13
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("ユーザー名は12文字以内で入力してください")
      end

      scenario "メールアドレスが空だと失敗" do
        fill_in "name", with: user.name
        fill_in "email", with: ''
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("メールアドレスを入力してください")
      end

      scenario "メールアドレスが重複して存在すると失敗" do
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

      scenario "パスワードが空だと失敗" do
        fill_in "name", with: user.name
        fill_in "email", with: user.email
        fill_in "password", with: ''
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("パスワードを入力してください")
      end

      scenario "パスワードが6文字以下だと失敗" do
        fill_in "name", with: user.name
        fill_in "email", with: user.email
        fill_in "password", with: 'aaaaa'
        fill_in "password_confirmation", with: user.password_confirmation
        click_button '新しいアカウントを作成'
        expect(page).to have_content("パスワードは6文字以上で入力してください")
      end

      scenario "確認用パスワードが空だと失敗" do
        fill_in "name", with: user.name
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        fill_in "password_confirmation", with: ''
        click_button '新しいアカウントを作成'
        expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
      end

      scenario "パスワードと確認用パスワードが不一致だと失敗" do
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
