require 'rails_helper'

RSpec.feature "Questions::Show", type: :feature do
  context "ログインユーザーと質問者が同じ場合" do
    let(:user) { FactoryBot.create(:user) }
    let(:question) { FactoryBot.create(:question, user_id: user.id) }
    let!(:q_comment) { FactoryBot.create(:q_comment, question_id: question.id) }
    let(:new_q_comment) { FactoryBot.build(:q_comment, question_id: question.id) }

    before do
      sign_in user
      visit question_path(question.id)
    end

    scenario "質問編集ページに移動できる" do
      find('.question-edit-link').click
      expect(current_path).to eq edit_question_path(question.id)
    end

    scenario "質問を削除できる" do
      find('.question-delete-link').click
    end

    scenario "質問情報を表示" do
      expect(page).to have_content question.user.name
      expect(page).to have_selector("img[src$='#{question.user.user_icon.identifier}']")
      expect(page).to have_content question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.q_title
      expect(page).to have_content question.q_content
    end

    scenario "質問に対するコメントを表示" do
      expect(page).to have_content q_comment.user.name
      expect(page).to have_selector("img[src$='#{q_comment.user.user_icon.identifier}']")
      expect(page).to have_content q_comment.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content q_comment.q_content
    end

    describe '質問に対するコメントの作成' do
      context '新規コメント成功' do
        it '内容に問題ない場合' do
          fill_in "q_content", with: new_q_comment.q_content
          click_button 'コメントする'
          expect(page).to have_content("コメントを投稿しました。")
        end
      end

      context '新規コメント失敗' do
        it '内容が空' do
          fill_in "q_content", with: ''
          click_button 'コメントする'
          expect(page).to have_content("コメントの投稿に失敗しました。")
        end
      end
    end
  end

  context "ログインユーザーと質問者が違う場合" do
    let(:user) { FactoryBot.create(:user) }
    let(:question) { FactoryBot.create(:question) }
    let!(:q_comment) { FactoryBot.create(:q_comment, question_id: question.id) }
    let(:new_q_comment) { FactoryBot.build(:q_comment, question_id: question.id) }

    before do
      sign_in user
      visit question_path(question.id)
    end

    scenario "質問情報を表示" do
      expect(page).to have_content question.user.name
      expect(page).to have_selector("img[src$='#{question.user.user_icon.identifier}']")
      expect(page).to have_content question.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content question.q_title
      expect(page).to have_content question.q_content
    end

    scenario "質問に対するコメントを表示" do
      expect(page).to have_content q_comment.user.name
      expect(page).to have_selector("img[src$='#{q_comment.user.user_icon.identifier}']")
      expect(page).to have_content q_comment.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content q_comment.q_content
    end

    describe '新規投稿に対するコメントの作成' do
      context '新規コメント成功' do
        it '内容に問題ない場合' do
          fill_in "q_content", with: new_q_comment.q_content
          click_button 'コメントする'
          expect(page).to have_content("コメントを投稿しました。")
        end
      end

      context '新規コメント失敗' do
        it '内容が空' do
          fill_in "q_content", with: ''
          click_button 'コメントする'
          expect(page).to have_content("コメントの投稿に失敗しました。")
        end
      end
    end
  end
end
