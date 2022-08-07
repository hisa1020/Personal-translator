require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  let(:comment) { FactoryBot.build(:comment, user_id: user.id, post_id: post.id) }

  describe '投稿に対するコメント' do
    context '新規コメント成功' do
      it '評価、内容を投稿' do
        expect(comment).to be_valid
      end

      it '評価のみで投稿できる' do
        comment.content = ""
        expect(comment).to be_valid
      end
    end

    context 'コメント失敗' do
      it '評価点が空だと失敗' do
        comment.rate = ""
        comment.valid?
        expect(comment.errors.full_messages).to include("評価点を入力してください")
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
