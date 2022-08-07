require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.build(:question, user_id: user.id) }

  describe '新規質問' do
    context '新規質問成功' do
      it 'タイトル、内容が入力されていると成功' do
        expect(question).to be_valid
      end
    end

    context '新規質問失敗' do
      it 'タイトルが空だと失敗' do
        question.q_title = ""
        question.valid?
        expect(question.errors.full_messages).to include("タイトルを入力してください")
      end

      it '内容が空だと失敗' do
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

  describe '既にお気に入りに追加されているかを取得' do
    context "既にお気に入りに登録されているとき" do
      let(:question) { FactoryBot.create(:question) }
      let!(:q_favorite) do
        FactoryBot.create(:q_favorite, user_id: user.id, question_id: question.id)
      end

      it 'question.favorited?にtrueを返す' do
        expect(question.favorited?(user)).to eq true
      end
    end

    context "お気に入りに登録されていないとき" do
      let!(:question) { FactoryBot.create(:question) }

      it 'question.favorited?にfalseを返す' do
        expect(question.favorited?(user)).to eq false
      end
    end
  end
end
