require 'rails_helper'
require 'spec_helper'

RSpec.feature "Posts::Edit", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  before do
    sign_in user
    visit edit_post_path(post.id)
  end

  describe "投稿内容を変更できる" do
    scenario "変更前の投稿内容が表示されている" do
      expect(page).to have_field("title", with: post.title)
      expect(page).to have_field("artist", with: post.artist)
      expect(page).to have_field("content", with: post.content)
    end

    scenario "投稿内容を変更できる" do
      fill_in "title", with: "New-Test-Title"
      fill_in "artist", with: "New-Test-Artist"
      fill_in "content", with: "New-Test-Content"
      click_button '投稿内容を更新'
      expect(page).to have_content("投稿内容を更新しました。")
    end

    context "変更なしで投稿を更新する場合" do
      scenario "元の投稿を表示" do
        click_button '投稿内容を更新'
        expect(page).to have_content("投稿内容を更新しました。")
      end
    end

    context "曲名を更新する場合" do
      scenario "新しい曲名を表示" do
        fill_in "title", with: "New-Test-Title"
        click_button '投稿内容を更新'
        expect(page).to have_content("投稿内容を更新しました。")
        expect(page).to have_content("New-Test-Title")
      end

      scenario "曲名を更新できず(空白)" do
        fill_in "title", with: ""
        click_button '投稿内容を更新'
        expect(page).to have_content("曲名を入力してください")
      end
    end

    context "歌手名を更新する場合" do
      scenario "新しい歌手名を表示" do
        fill_in "artist", with: "New-Test-Artist"
        click_button '投稿内容を更新'
        expect(page).to have_content("投稿内容を更新しました。")
        expect(page).to have_content("New-Test-Artist")
      end

      scenario "歌手名を更新できず(空白)" do
        fill_in "artist", with: ""
        click_button '投稿内容を更新'
        expect(page).to have_content("歌手名を入力してください")
      end
    end

    context "内容を更新する場合" do
      scenario "新しい内容を表示" do
        fill_in "content", with: "New-Test-Content"
        click_button '投稿内容を更新'
        expect(page).to have_content("投稿内容を更新しました。")
        expect(page).to have_content("New-Test-Content")
      end

      scenario "内容を更新できず(空白)" do
        fill_in "content", with: ""
        click_button '投稿内容を更新'
        expect(page).to have_content("内容を入力してください")
      end
    end
  end
end
