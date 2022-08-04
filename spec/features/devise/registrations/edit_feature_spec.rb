require 'rails_helper'
require 'spec_helper'

RSpec.feature "Users::Edit", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit edit_user_registration_path
  end

  scenario "ユーザーのメールアドレスを表示" do
    expect(page).to have_field("email", with: user.email)
  end

  describe "アカウント変更" do
    context "アカウントの変更成功" do
      scenario "メールアドレスとパスワードの変更成功" do
        fill_in "email", with: 'newaddress@sample.co.jp'
        fill_in "new-password", with: 'xyz6789'
        fill_in "new-password-confirmation", with: 'xyz6789'
        fill_in "current_password", with: user.password
        click_button 'パスワードを更新'
        expect(current_path).to eq root_path
        expect(page).to have_content("アカウント情報を変更しました。")
      end

      scenario "メールアドレスの変更成功" do
        fill_in "email", with: 'newaddress@sample.co.jp'
        fill_in "current_password", with: user.password
        click_button 'パスワードを更新'
        expect(current_path).to eq root_path
        expect(page).to have_content("アカウント情報を変更しました。")
      end
    end

    context "アカウント変更失敗" do
      scenario "メールアドレスが空だと失敗" do
        fill_in "email", with: ''
        fill_in "current_password", with: user.password
        click_button 'パスワードを更新'
        expect(page).to have_content("メールアドレスを入力してください")
      end

      scenario "新しいパスワードが空だと失敗" do
        fill_in "email", with: user.email
        fill_in "new-password", with: ''
        fill_in "new-password-confirmation", with: 'xyz6789'
        fill_in "current_password", with: user.password
        click_button 'パスワードを更新'
        expect(page).to have_content("パスワードを入力してください")
      end

      scenario "新しいパスワードが6文字以下だと失敗" do
        fill_in "email", with: user.email
        fill_in "new-password", with: '00000'
        fill_in "new-password-confirmation", with: 'xyz6789'
        fill_in "current_password", with: user.password
        click_button 'パスワードを更新'
        expect(page).to have_content("パスワードは6文字以上で入力してください")
      end

      scenario "確認用パスワードが空だと失敗" do
        fill_in "email", with: user.email
        fill_in "new-password", with: 'xyz6789'
        fill_in "new-password-confirmation", with: ''
        fill_in "current_password", with: user.password
        click_button 'パスワードを更新'
        expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
      end

      scenario "新しいパスワードと確認用パスワードが不一致だと失敗" do
        fill_in "email", with: user.email
        fill_in "new-password", with: 'xyz6789'
        fill_in "new-password-confirmation", with: 'abcd123'
        fill_in "current_password", with: user.password
        click_button 'パスワードを更新'
        expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
      end

      scenario "現在のパスワードが空だと失敗" do
        fill_in "email", with: user.email
        fill_in "new-password", with: 'xyz6789'
        fill_in "new-password-confirmation", with: 'xyz6789'
        fill_in "current_password", with: ''
        click_button 'パスワードを更新'
        expect(page).to have_content("現在のパスワードを入力してください")
      end

      scenario "現在のパスワードが正しくないと失敗" do
        fill_in "email", with: user.email
        fill_in "new-password", with: 'xyz6789'
        fill_in "new-password-confirmation", with: 'xyz6789'
        fill_in "current_password", with: 'wrong123'
        click_button 'パスワードを更新'
        expect(page).to have_content("現在のパスワードは不正な値です")
      end
    end
  end

  scenario "プロフィールに戻る" do
    click_link '戻る'
    expect(current_path).to eq users_profile_path
  end
end
