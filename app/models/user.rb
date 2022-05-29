class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { in: 3..12 }

  mount_uploader :user_icon, UserIconUploader

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def posts_count
    posts.count + questions.count
  end

  def comments_count
    comments.count + q_comments.count
  end

  def favorites_count
    favorites.count + q_favorites.count
  end

  has_many :posts, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :q_comments, dependent: :destroy
  has_many :q_favorites, dependent: :destroy
end
