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

  def posts_counts
    posts.count + questions.count
  end

  def comments_counts
    comments.count + q_comments.count
  end

  def favorites_counts
    favorites.count + q_favorites.count
  end

  def user_score
    user_score = 0
    posts.each do |post|
      user_score += (post.average / posts.count)
    end
    user_score
  end

  has_many :posts, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :q_comments, dependent: :destroy
  has_many :q_favorites, dependent: :destroy
end
