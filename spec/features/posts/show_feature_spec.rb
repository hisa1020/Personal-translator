require 'rails_helper'

RSpec.feature "Posts::Show", type: :feature do
  context "ログインユーザーと投稿者が同じ場合" do
    let(:user) { FactoryBot.create(:user) }
    let!(:post) { FactoryBot.create(:post, user_id: user.id) }

    before do
      sign_in user
      visit post_path(post.id)
    end

    scenario "編集ページに移動できる" do
      find('.post-edit-link').click
      expect(current_path).to eq edit_post_path(post.id)
    end

    scenario "投稿を削除できる" do
      find('.post-delete-link').click
    end

    scenario "投稿情報を表示" do
      expect(page).to have_content post.user.name
      expect(page).to have_selector("img[src$='#{post.user.user_icon.identifier}']")
      expect(page).to have_content post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.title
      expect(page).to have_content post.content
    end
  end

  context "ログインユーザーと投稿者が違う場合" do
    let(:user) { FactoryBot.create(:user) }
    let!(:post) { FactoryBot.create(:post) }

    before do
      sign_in user
      visit post_path(post.id)
    end

    scenario "投稿情報を表示" do
      expect(page).to have_content post.user.name
      expect(page).to have_selector("img[src$='#{post.user.user_icon.identifier}']")
      expect(page).to have_content post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.title
      expect(page).to have_content post.content
    end
  end
end
