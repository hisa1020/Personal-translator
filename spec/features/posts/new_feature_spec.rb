require 'rails_helper'
require 'spec_helper'

RSpec.feature "Posts::New", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.build(:post) }

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
        fill_in "artist", with: post.artist
        fill_in "content", with: post.content
        click_button '投稿する'
        expect(page).to have_content("投稿が完了しました。")
      end
    end

    context "新規投稿失敗" do
      scenario "曲名が未記入" do
        fill_in "title", with: ""
        fill_in "artist", with: post.artist
        fill_in "content", with: post.content
        click_button '投稿する'
        expect(page).to have_content("曲名を入力してください")
        expect(page).to have_field("artist", with: post.artist)
        expect(page).to have_field("content", with: post.content)
      end

      scenario "歌手名が未記入" do
        fill_in "title", with: post.title
        fill_in "artist", with: ""
        fill_in "content", with: post.content
        click_button '投稿する'
        expect(page).to have_content("歌手名を入力してください")
        expect(page).to have_field("title", with: post.title)
        expect(page).to have_field("content", with: post.content)
      end

      scenario "内容が未記入" do
        fill_in "title", with: post.title
        fill_in "artist", with: post.artist
        fill_in "content", with: ""
        click_button '投稿する'
        expect(page).to have_content("内容を入力してください")
        expect(page).to have_field("title", with: post.title)
        expect(page).to have_field("artist", with: post.artist)
      end
    end
  end
end
