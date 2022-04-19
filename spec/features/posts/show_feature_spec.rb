require 'rails_helper'

RSpec.feature "Posts::Show", type: :feature do
  context "ログインユーザーと投稿者が同じ場合" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user_id: user.id) }
    let!(:comment) { FactoryBot.create(:comment, post_id: post.id) }
    let(:new_comment) { FactoryBot.build(:comment, post_id: post.id) }

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

    scenario "投稿に対するコメントを表示" do
      expect(page).to have_content comment.user.name
      expect(page).to have_selector("img[src$='#{comment.user.user_icon.identifier}']")
      expect(page).to have_content comment.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content comment.content
    end

    describe '投稿に対するコメントの作成' do
      context '新規コメント成功' do
        it '内容に問題ない場合' do
          fill_in "content", with: new_comment.content
          click_button 'コメントする'
          expect(page).to have_content("コメントを投稿しました。")
        end
      end

      context '新規コメント失敗' do
        it '内容が空' do
          fill_in "content", with: ''
          click_button 'コメントする'
          expect(page).to have_content("コメントの投稿に失敗しました。")
        end
      end
    end
  end

  context "ログインユーザーと投稿者が違う場合" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    let!(:comment) { FactoryBot.create(:comment, post_id: post.id) }

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

    scenario "投稿に対するコメントを表示" do
      expect(page).to have_content comment.user.name
      expect(page).to have_selector("img[src$='#{comment.user.user_icon.identifier}']")
      expect(page).to have_content comment.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content comment.content
    end
  end
end
