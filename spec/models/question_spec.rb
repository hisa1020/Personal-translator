require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.build(:question, user_id: user.id) }

  describe '新規質問' do
    context '新規質問成功' do
      it '内容に問題ない場合' do
        expect(question).to be_valid
      end
    end

    context '新規質問失敗' do
      it 'タイトルが空' do
        question.q_title = ""
        question.valid?
        expect(question.errors.full_messages).to include("タイトルを入力してください")
      end

      it '内容が空' do
        question.q_content = ""
        question.valid?
        expect(question.errors.full_messages).to include("内容を入力してください")
      end
    end
  end

  describe 'ユーザー情報を入手' do
    it 'ユーザー名とアイコンを取得' do
      expect(question.user.name).to eq user.name
      expect(question.user.user_icon.identifier).to eq user.user_icon.identifier
    end
  end
end
