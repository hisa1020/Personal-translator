require 'rails_helper'
require 'spec_helper'

RSpec.feature "Posts::Show", type: :feature, js: true do
  context "ログインユーザーと投稿者が同じとき" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user_id: user.id) }
    let(:comment) { FactoryBot.create(:comment, :no_content, post_id: post.id) }

    before do
      sign_in user
      visit post_path(post.id)
    end

    scenario "ユーザーページに移動" do
      find('.post-user-link').click
      expect(current_path).to eq user_path(post.user_id)
    end

    scenario "編集ページに移動" do
      find('.post-edit-link').click
      expect(current_path).to eq edit_post_path(post.id)
    end

    scenario "投稿を削除" do
      find('.post-delete-link').click
      expect  do
        expect(page.accept_confirm).to eq "本当に削除してよろしいですか?"
        expect(page).to have_content "投稿を削除しました。"
      end. to change(user.posts, :count).by(-1)
    end

    scenario "コメントなしの投稿情報を表示" do
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

    scenario "評価のみのコメントを表示" do
      post.comments.all? do |comment|
        expect(page).to have_content comment.user.name
        expect(page).to have_selector("img[src$='#{comment.user.user_icon.identifier}']")
        expect(page).to have_content comment.created_at.strftime("%Y年 %m月%d日 %H時%M分")
        expect(page).to have_content comment.rate
      end
    end
  end

  context "ログインユーザーと投稿者が違うとき" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, :with_feedback) }
    let(:new_comment) { FactoryBot.build(:comment, post_id: post.id) }

    before do
      sign_in user
      visit post_path(post.id)
    end

    describe 'favoriteに登録解除' do
      scenario 'favoriteに登録できる' do
        f = post.favorites.count
        find('.favorite-button').click
        expect(post.favorites.count).to eq(f + 1)
      end

      scenario 'favoriteを解除できる' do
        find('.favorite-button').click
        f = post.favorites.count
        find('.favorite-button').click
        expect(post.favorites.count).to eq(f - 1)
      end
    end

    scenario "コメントありの投稿情報を表示" do
      expect(page).to have_content post.user.name
      expect(page).to have_selector("img[src$='#{post.user.user_icon.identifier}']")
      expect(page).to have_content post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.title
      expect(page).to have_content post.artist
      expect(page).to have_content post.content
      expect(page).to have_content post.favorites.count
      expect(page).to have_content post.comments.count
      expect(page).to have_content post.average.round(1)
    end

    scenario 'コメント内容ありのコメントの表示' do
      post.comments.all? do |comment|
        expect(page).to have_content comment.user.name
        expect(page).to have_selector("img[src$='#{comment.user.user_icon.identifier}']")
        expect(page).to have_content comment.created_at.strftime("%Y年 %m月%d日 %H時%M分")
        expect(page).to have_content comment.rate
        expect(page).to have_content comment.content
      end
    end

    describe '投稿に対するコメントの作成' do
      context 'コメント成功' do
        scenario '全ての条件を満たすと成功' do
          fill_in "rate", with: new_comment.rate
          fill_in "content", with: new_comment.content
          click_button 'コメントする'
          expect(page).to have_content("コメントを投稿しました。")
        end

        scenario '評価のみでコメントできる' do
          fill_in "rate", with: new_comment.rate
          fill_in "content", with: ''
          click_button 'コメントする'
          expect(page).to have_content("コメントを投稿しました。")
        end
      end

      context 'コメント失敗' do
        scenario '評価が空だと失敗' do
          fill_in "rate", with: ''
          fill_in "content", with: new_comment.content
          click_button 'コメントする'
          expect(page).to have_content("コメントの投稿に失敗しました。")
        end
      end
    end
  end
end
