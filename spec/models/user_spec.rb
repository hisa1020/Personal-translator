require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録' do
    let(:user) { FactoryBot.build(:user) }

    context '新規登録成功' do
      it '内容に問題ない場合' do
        expect(user).to be_valid
      end

      it 'emailが255文字以下のユーザーが作成可能' do
        user.email = 'a' * 245 + '@sample.jp'
        expect(user).to be_valid
      end

      it 'emailは全て小文字で保存される' do
        user.email = 'SAMPLE@SAMPLE.JP'
        user.save!
        expect(user.reload.email).to eq 'sample@sample.jp'
      end
    end

    context '新規登録失敗' do
      it 'ユーザー名が空' do
        user.name = ""
        user.valid?
        expect(user.errors.full_messages).to include("ユーザー名を入力してください")
      end

      it 'nameが3文字以下のユーザーを許可しない' do
        user.name = 'ああ'
        user.valid?
        expect(user.errors.full_messages).to include("ユーザー名は3文字以上で入力してください")
      end

      it 'nameが13文字以上のユーザーを許可しない' do
        user.name = 'あ' * 13
        user.valid?
        expect(user.errors.full_messages).to include("ユーザー名は12文字以内で入力してください")
      end

      it "emailが空では登録できない" do
        user.email = ""
        user.valid?
        expect(user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it "重複したemailが存在する場合登録できない" do
        user.save
        another_user = FactoryBot.build(:user)
        another_user.email = user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it "passwordが空では登録できない" do
        user.password = ""
        user.valid?
        expect(user.errors.full_messages).to include("パスワードを入力してください")
      end

      it "passwordが5文字以下であれば登録できない" do
        user.password = "00000"
        user.password_confirmation = "00000"
        user.valid?
        expect(user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        user.password_confirmation = ""
        user.valid?
        expect(user.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
      end

      it 'パスワードと確認用パスワードが間違っている場合、無効であること' do
        user.password = 'password'
        user.password_confirmation = 'pass'
        user.valid?
        expect(user.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
      end

      it 'メールアドレスが正常なフォーマットの場合、有効であること' do
        valid_addresses = %w(
          user@example.com USER@foo.COM A_US-ER@foo.bar.org
          first.last@foo.jp alice+bob@baz.cn
        )
        valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
    end
  end

  describe '登録後のユーザー情報' do
    let(:user) { FactoryBot.create(:user) }
    let!(:posts) { FactoryBot.create_list(:post, rand(3), user_id: user.id) }
    let!(:questions) { FactoryBot.create_list(:question, rand(3), user_id: user.id) }
    let!(:comments) { FactoryBot.create_list(:comment, rand(3), user_id: user.id) }
    let!(:q_comments) { FactoryBot.create_list(:q_comment, rand(3), user_id: user.id) }
    let!(:favorites) { FactoryBot.create_list(:favorite, rand(3), user_id: user.id) }
    let!(:q_favorites) { FactoryBot.create_list(:q_favorite, rand(3), user_id: user.id) }

    it 'パスワードが暗号化されていること' do
      expect(user.encrypted_password).not_to eq 'password'
    end

    it '投稿と質問の総数を取得' do
      total_posts = posts.count + questions.count
      expect(user.posts_counts).to eq total_posts
    end

    it 'コメントの総数を取得' do
      total_comments = comments.count + q_comments.count
      expect(user.comments_counts).to eq total_comments
    end

    it 'お気に入りの総数を取得' do
      total_favorites = favorites.count + q_favorites.count
      expect(user.favorites_counts).to eq total_favorites
    end

    it '投稿の平均得点を取得' do
      t_score = 0
      user.posts.each do |post|
        t_score += (post.average / posts.count)
      end
      expect(user.user_score).to eq t_score
    end
  end

  describe 'ゲストログイン' do
    it 'ゲストログイン用のアカウントが作られること' do
      expect(User.guest.name).to eq "ゲスト"
      expect(User.guest.email).to eq "guest@example.com"
    end
  end
end
