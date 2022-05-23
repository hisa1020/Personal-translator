class Question < ApplicationRecord
  validates :q_title, presence: true
  validates :q_content, presence: true
  belongs_to :user
  has_many :q_comments, dependent: :destroy
  has_many :q_favorites, dependent: :destroy

  def user
    User.find_by(id: user_id)
  end

  def favorited?(user)
    q_favorites.where(user_id: user.id).exists?
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @questions = Question.where("q_title LIKE?", "#{word}")
    elsif search == "forward_match"
      @questions = Question.where("q_title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @questions = Question.where("q_title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @questions = Question.where("q_title LIKE?", "%#{word}%")
    else
      @questions = Question.where("q_title LIKE?", "%#{word}%")
    end
  end
end
