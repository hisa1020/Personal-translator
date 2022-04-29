class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user

  def user
    User.find_by(id: user_id)
  end
end
