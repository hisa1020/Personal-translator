require 'rails_helper'
require 'spec_helper'

RSpec.feature "Questions::Show", type: :feature, js: true do
  context "ログインユーザーと質問者が同じとき" do
    let(:user) { FactoryBot.create(:user) }
    let(:question) { FactoryBot.create(:question, user_id: user.id) }
    let(:new_Qcomment) { FactoryBot.build(:q_comment, question_id: question.id) }

    before do
      sign_in user
      visit question_path(question.id)
    end

    scenario "質問編集ページに移動" do
      find('.question-edit-link').click
      expect(current_path).to eq edit_question_path(question.id)
    end

    scenario "投稿を削除できる" do
      find('.question-delete-link').click
      expect  do
        expect(page.accept_confirm).to eq "本当に削除してよろしいですか?"
        expect(page).to have_content "質問を削除しました。"
      end. to change(user.questions, :count).by(-1)
    end

    scenario "質問情報を表示" do
      expect(page).to have_content question.user.name
      expect(page).to have_selector("img[src$='#{question.user.user_icon.identifier}']")
      expect(page).to have_content question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.q_title
      expect(page).to have_content question.q_content
      expect(page).to have_content question.q_favorites.count
      expect(page).to have_content question.q_comments.count
    end

    scenario "質問に対するコメントを表示" do
      question.q_comments.all? do |q_comment|
        expect(page).to have_content q_comment.user.name
        expect(page).to have_selector("img[src$='#{q_comment.user.user_icon.identifier}']")
        expect(page).to have_content q_comment.created_at.strftime("%Y年 %m月%d日 %H時%M分")
        expect(page).to have_content q_comment.q_content
      end
    end

    describe '質問に対するコメントの作成' do
      context 'コメント成功' do
        it '内容が入力されていると成功' do
          fill_in "q_content", with: new_Qcomment.q_content
          click_button '回答する'
          expect(page).to have_content("コメントを投稿しました。")
        end
      end

      context 'コメント失敗' do
        it '内容が空だと失敗' do
          fill_in "q_content", with: ''
          click_button '回答する'
          expect(page).to have_content("コメントの投稿に失敗しました。")
        end
      end
    end
  end

  context "ログインユーザーと質問者が違うとき" do
    let(:user) { FactoryBot.create(:user) }
    let(:question) { FactoryBot.create(:question) }

    before do
      sign_in user
      visit question_path(question.id)
    end

    describe 'favoriteに登録解除' do
      scenario 'favoriteに登録できる' do
        f = question.q_favorites.count
        find('.favorite-button').click
        expect(question.q_favorites.count).to eq(f + 1)
      end

      scenario 'favoriteをできる' do
        find('.favorite-button').click
        f = question.q_favorites.count
        find('.favorite-button').click
        expect(question.q_favorites.count).to eq(f - 1)
      end
    end
  end
end
