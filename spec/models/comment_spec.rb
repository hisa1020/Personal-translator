require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  let(:comment) { FactoryBot.build(:comment, user_id: user.id, post_id: post.id) }

  describe '投稿に対するコメント' do
    context '新規コメント成功' do
      it '内容に問題ない場合' do
        expect(comment).to be_valid
      end
    end

    context '新規コメント失敗' do
      it '内容が空' do
        comment.content = ""
        comment.valid?
        expect(comment.errors.full_messages).to include("コメントを入力してください")
      end
    end
  end

  describe '投稿にコメントしたユーザー情報を入手' do
    it 'ユーザー名とアイコンを取得' do
      expect(comment.user.name).to eq user.name
      expect(comment.user.user_icon.identifier).to eq user.user_icon.identifier
    end
  end
end
