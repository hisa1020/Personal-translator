require 'rails_helper'
require 'spec_helper'

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
      click_link '新規登録'
      expect(current_path).to eq new_user_registration_path
    end
  end

  context "サインイン後" do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
      visit root_path
    end

    scenario "ヘッダー右側から新規投稿に移動" do
      find('.header-new-post-link').click
      expect(current_path).to eq new_post_path
    end

    scenario "ヘッダー右側からプロフィールに移動" do
      find('.users-profile-link').click
      expect(current_path).to eq users_profile_path
    end

    scenario "ヘッダー右側からサインアウトとトップページに移動" do
      find('.signout-link').click
      expect(page).to have_content("サインアウトしました。")
    end

    scenario "新規投稿に移動" do
      find('.new-post-link').click
      expect(current_path).to eq new_post_path
    end

    scenario "投稿一覧に移動" do
      find('.posts-link').click
      expect(current_path).to eq posts_path
    end

    describe "検索フォーム" do
      let!(:others_post) { FactoryBot.create(:post, :others) }
      let!(:posts) { FactoryBot.create_list(:post, rand(3), :with_feedback) }

      scenario "曲名で検索できる" do
        fill_in "word", with: "youthful days"
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "歌手名で検索できる" do
        fill_in "word", with: "Mr.Children"
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end
    end
  end
end
