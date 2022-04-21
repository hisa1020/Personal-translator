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
end
