class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  def user
    User.find_by(id: user_id)
  end
end
