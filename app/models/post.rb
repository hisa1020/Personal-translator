class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true

  def user
    User.find_by(id: user_id)
  end
end
