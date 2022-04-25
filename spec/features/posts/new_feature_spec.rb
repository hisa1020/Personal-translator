require 'rails_helper'

RSpec.feature "Posts::New", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  before do
    sign_in user
    visit new_post_path
  end

  scenario "新規投稿(質問)に移動" do
    within('.align-menu-bar') do
      click_link '質問'
      expect(current_path).to eq new_question_path
    end
  end

  describe "新規投稿" do
    context "新規投稿成功" do
      scenario "タイトルと内容を記入" do
        fill_in "title", with: post.title
        fill_in "content", with: post.content
        click_button '投稿する'
        expect(page).to have_content("投稿が完了しました。")
        expect(page).to have_content post.title
        expect(page).to have_content post.content
      end
    end

    context "新規投稿失敗" do
      scenario "タイトルが未記入" do
        fill_in "title", with: ""
        fill_in "content", with: post.content
        click_button '投稿する'
        expect(page).to have_content("タイトルを入力してください")
        expect(page).not_to have_content("内容を入力してください")
      end

      scenario "内容が未記入" do
        fill_in "title", with: post.title
        fill_in "content", with: ""
        click_button '投稿する'
        expect(page).not_to have_content("タイトルを入力してください")
        expect(page).to have_content("内容を入力してください")
      end
    end
  end
end
