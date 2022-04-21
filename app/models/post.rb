class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def user
    User.find_by(id: user_id)
  end

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
end
