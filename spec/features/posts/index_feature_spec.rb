require 'rails_helper'
require 'spec_helper'

RSpec.feature "Posts::Index", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post) }
  let!(:postB) { FactoryBot.create(:post, :with_feedback) }

  before do
    sign_in user
    visit posts_path
  end

  describe "post_navのリンク" do
    scenario "新規投稿に移動" do
      within('.post-nav') do
        click_link '新規作成'
        expect(current_path).to eq new_post_path
      end
    end

    scenario "質問一覧に移動" do
      within('.post-nav') do
        click_link '質問一覧'
        expect(current_path).to eq questions_path
      end
    end

    scenario "検索ページに移動" do
      within('.post-nav') do
        click_link 'さがす'
        expect(current_path).to eq search_path
      end
    end
  end

  scenario "投稿詳細ページに移動" do
    page.all('.post-link-box')[1].click
    expect(current_path).to eq post_path(post.id)
  end

  context "投稿に対するコメントがないとき" do
    scenario "投稿情報を表示" do
      expect(page).to have_content post.user.name
      expect(page).to have_selector("img[src$='#{post.user.user_icon.identifier}']")
      expect(page).to have_content post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.title
      expect(page).to have_content post.artist
      expect(page).to have_content post.content
      expect(page).to have_content post.favorites.count
      expect(page).to have_content post.comments.count
      expect(page).to have_content("未評価")
    end
  end

  context "投稿に対するコメントがあるとき" do
    scenario "平均評価を含む投稿情報を表示" do
      expect(page).to have_content postB.user.name
      expect(page).to have_selector("img[src$='#{postB.user.user_icon.identifier}']")
      expect(page).to have_content postB.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content postB.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content postB.title
      expect(page).to have_content postB.artist
      expect(page).to have_content postB.content
      expect(page).to have_content postB.favorites.count
      expect(page).to have_content postB.comments.count
      expect(page).to have_content postB.average.round(1)
    end
  end
end
