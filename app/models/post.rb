class Post < ApplicationRecord
  validates :title, presence: true
  validates :artist, presence: true
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def user
    User.find_by(id: user_id)
  end

  def average
    average = 0
    comments.each do |comment|
      average += (comment.rate / comments.count)
    end
    average
  end

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @posts = Post.where("title LIKE(?) OR artist LIKE(?)", "#{word}", "#{word}")
    elsif search == "forward_match"
      @posts = Post.where("title LIKE(?) OR artist LIKE(?)", "#{word}%", "#{word}%")
    elsif search == "backward_match"
      @posts = Post.where("title LIKE(?) OR artist LIKE(?)", "%#{word}", "%#{word}")
    elsif search == "partial_match"
      @posts = Post.where("title LIKE(?) OR artist LIKE(?)", "%#{word}%", "%#{word}%")
    else
      @posts = Post.where("title LIKE(?) OR artist LIKE(?)", "%#{word}%", "%#{word}%")
    end
  end
end
