class User < ApplicationRecord
  validates :name, presence: true, length: { in: 3..12 }
  validates :introduction, presence: true, length: { in: 10..30 }, on: :update

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
    fav_count = 0
    posts.each do |post|
      fav_count += post.favorites.count
    end
    
    q_fav_count = 0
    questions.each do |question|
      q_fav_count += question.q_favorites.count
    end

    fav_count + q_fav_count
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :q_comments, dependent: :destroy
  has_many :q_favorites, dependent: :destroy
end
