require 'rails_helper'
require 'spec_helper'

RSpec.feature "Users::Profile_Edit", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit users_profile_edit_path
  end

  describe "プロフィール変更" do
    scenario "変更前のユーザー情報を表示" do
      expect(page).to have_field("name", with: user.name)
      expect(page).to have_field("introduction", with: user.introduction)
    end

    context "プロフィール変更成功" do
      scenario "ユーザー名、自己紹介文、アイコン画像を変更できる" do
        fill_in "name", with: "new-name"
        fill_in "introduction", with: "よろしくお願いします。"
        attach_file "user-icon", "#{Rails.root}/spec/fixtures/new_icon.jpg"
        click_button 'プロフィールを更新'
        expect(page).to have_content("プロフィールの更新に成功しました。")
      end

      scenario "変更なしでプロフィールを更新できる" do
        click_button 'プロフィールを更新'
        expect(page).to have_content("プロフィールの更新に成功しました。")
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end

      scenario "ユーザー名のみを変更できる" do
        fill_in "name", with: "new-name"
        click_button 'プロフィールを更新'
        expect(page).to have_content("プロフィールの更新に成功しました。")
        expect(page).to have_content("new-name")
        expect(page).to have_content user.introduction
      end

      scenario "自己紹介文のみを変更できる" do
        fill_in "introduction", with: "よろしくお願いします。"
        click_button 'プロフィールを更新'
        expect(page).to have_content("プロフィールの更新に成功しました。")
        expect(page).to have_content user.name
        expect(page).to have_content("よろしくお願いします。")
      end

      scenario "アイコン画像のみを変更できる" do
        attach_file "user-icon", "#{Rails.root}/spec/fixtures/new_icon.jpg"
        click_button 'プロフィールを更新'
        expect(page).to have_content("プロフィールの更新に成功しました。")
        expect(page).to have_selector("img[src$='new_icon.jpg']")
      end
    end

    context "プロフィール変更失敗" do
      scenario "ユーザー名が空だと変更失敗" do
        fill_in "name", with: ""
        click_button 'プロフィールを更新'
        expect(page).to have_content("ユーザー名を入力してください")
        expect(page).to have_content("ユーザー名は3文字以上で入力してください")
      end

      scenario "ユーザー名が3文字未満だと変更失敗" do
        fill_in "name", with: "n"
        click_button 'プロフィールを更新'
        expect(page).not_to have_content("ユーザー名を入力してください")
        expect(page).to have_content("ユーザー名は3文字以上で入力してください")
      end
    end
  end

  scenario "プロフィールに戻る" do
    click_link '戻る'
    expect(current_path).to eq users_profile_path
  end
end
