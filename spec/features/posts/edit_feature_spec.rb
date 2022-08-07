require 'rails_helper'
require 'spec_helper'

RSpec.feature "Posts::Edit", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  before do
    sign_in user
    visit edit_post_path(post.id)
  end

  describe "投稿内容の変更" do
    scenario "変更前の投稿内容が表示されている" do
      expect(page).to have_field("title", with: post.title)
      expect(page).to have_field("artist", with: post.artist)
      expect(page).to have_field("content", with: post.content)
    end

    context "投稿内容の変更成功" do
      scenario "タイトル、歌手名、内容を変更できる" do
        fill_in "title", with: "New-Test-Title"
        fill_in "artist", with: "New-Test-Artist"
        fill_in "content", with: "New-Test-Content"
        click_button '投稿内容を更新'
        expect(page).to have_content("投稿内容を更新しました。")
      end

      scenario "変更なしで投稿を更新できる" do
        click_button '投稿内容を更新'
        expect(page).to have_content("投稿内容を更新しました。")
      end

      scenario "曲名のみを更新できる" do
        fill_in "title", with: "New-Test-Title"
        click_button '投稿内容を更新'
        expect(page).to have_content("投稿内容を更新しました。")
        expect(page).to have_content("New-Test-Title")
      end

      scenario "歌手名のみを更新できる" do
        fill_in "artist", with: "New-Test-Artist"
        click_button '投稿内容を更新'
        expect(page).to have_content("投稿内容を更新しました。")
        expect(page).to have_content("New-Test-Artist")
      end

      scenario "内容のみを更新できる" do
        fill_in "content", with: "New-Test-Content"
        click_button '投稿内容を更新'
        expect(page).to have_content("投稿内容を更新しました。")
        expect(page).to have_content("New-Test-Content")
      end
    end

    context "投稿内容の変更失敗" do
      scenario "曲名が空だと更新失敗" do
        fill_in "title", with: ""
        click_button '投稿内容を更新'
        expect(page).to have_content("曲名を入力してください")
      end

      scenario "歌手名が空だと更新失敗" do
        fill_in "artist", with: ""
        click_button '投稿内容を更新'
        expect(page).to have_content("歌手名を入力してください")
      end

      scenario "内容が空だと更新失敗" do
        fill_in "content", with: ""
        click_button '投稿内容を更新'
        expect(page).to have_content("内容を入力してください")
      end
    end
  end
end
