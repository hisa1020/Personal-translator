require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.build(:post, user_id: user.id) }

  describe '新規投稿' do
    context '新規投稿成功' do
      it '内容に問題ない場合' do
        expect(post).to be_valid
      end
    end

    context '新規投稿失敗' do
      it 'タイトルが空' do
        post.title = ""
        post.valid?
        expect(post.errors.full_messages).to include("タイトルを入力してください")
      end

      it '内容が空' do
        post.content = ""
        post.valid?
        expect(post.errors.full_messages).to include("内容を入力してください")
      end
    end
  end

  describe 'ユーザー情報を入手' do
    it 'ユーザー名とアイコンを取得' do
      expect(post.user.name).to eq user.name
      expect(post.user.user_icon.identifier).to eq user.user_icon.identifier
    end
  end
end
