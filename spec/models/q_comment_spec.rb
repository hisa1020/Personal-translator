require 'rails_helper'

RSpec.describe QComment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }
  let(:q_comment) { FactoryBot.build(:q_comment, user_id: user.id, question_id: question.id) }

  describe '質問に対するコメント' do
    context '新規コメント成功' do
      it '内容に問題ない場合' do
        expect(q_comment).to be_valid
      end
    end

    context '新規コメント失敗' do
      it '内容が空' do
        q_comment.q_content = ""
        q_comment.valid?
        expect(q_comment.errors.full_messages).to include("コメントを入力してください")
      end
    end
  end

  describe '質問にコメントしたユーザー情報を入手' do
    it 'ユーザー名とアイコンを取得' do
      expect(q_comment.user.name).to eq user.name
      expect(q_comment.user.user_icon.identifier).to eq user.user_icon.identifier
    end
  end
end
