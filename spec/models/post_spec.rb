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
      it '曲名が空' do
        post.title = ""
        post.valid?
        expect(post.errors.full_messages).to include("曲名を入力してください")
      end

      it '歌手名が空' do
        post.artist = ""
        post.valid?
        expect(post.errors.full_messages).to include("歌手名を入力してください")
      end

      it '内容が空' do
        post.content = ""
        post.valid?
        expect(post.errors.full_messages).to include("内容を入力してください")
      end
    end
  end

  it '投稿したユーザーの情報を入手' do
    expect(post.user.name).to eq user.name
    expect(post.user.user_icon.identifier).to eq user.user_icon.identifier
  end

  describe 'コメントの得点の平均値を求める' do
    it '平均評価の算出' do
      t_average = 0
      post.comments.each do |comment|
        t_average += (comment.rate / comments.count)
      end
      expect(post.average).to eq t_average
    end
  end

  describe '既にお気に入りに追加されているかを取得' do
    context "既にお気に入りに登録されている場合" do
      let(:post) { FactoryBot.create(:post) }
      let!(:favorite) { FactoryBot.create(:favorite, user_id: user.id, post_id: post.id) }

      it 'post.favorited?でtrueを返す' do
        expect(post.favorited?(user)).to eq true
      end
    end

    context "お気に入りに登録されていない場合" do
      let!(:post) { FactoryBot.create(:post) }

      it 'post.favorited?でfalseを返す' do
        expect(post.favorited?(user)).to eq false
      end
    end
  end
end
